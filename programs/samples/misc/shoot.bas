CHDIR ".\samples\qb64\original"

deflng a-z
SCREEN 13,,1,0

_sndplayfile "ps2battl.mid"
shootsound=_sndopen("fireball.wav","SYNC")

'index,filename(.RAW),width,height
DATA 1,ship1,21,27
DATA 2,shot1,10,10
DATA 3,evil1,93,80
DATA 4,land1,320,56
DATA 5,boom1,65,75

dim shared spritedata(1000000) as _unsigned _byte
dim shared freespritedata as long
dim shared freesprite as long
freesprite=1

type spritetype
x as integer
y as integer
index as long 'an index in the spritedata() array
index2 as long 'optional secondary index
halfx as integer
halfy as integer
end type
dim shared s(1 to 1000) as spritetype

'load sprites
for i=1 to 5
b$=" "
read n
read f$:f$=f$+".raw"
read x,y
open f$ for binary as #1
if lof(1)<>x*y then screen 0:print "Error loading "+f$:end
for y2=y-1 to 0 step -1
for x2=0 to x-1
get #1,,b$
pset(x2,y2),asc(b$)
next
next
close #1
get (0,0)-(x-1,y-1),spritedata(freespritedata)
s(freesprite).index=freespritedata
freespritedata=freespritedata+x*y+4
'create shadow
for y2=y-1 to 0 step -1
for x2=0 to x-1
if point(x2,y2)<>254 then pset(x2,y2),18
next
next
get (0,0)-(x-1,y-1),spritedata(freespritedata)
s(freesprite).index2=freespritedata
freespritedata=freespritedata+x*y+4
s(freesprite).x=x:s(freesprite).y=y
s(freesprite).halfx=x\2:s(freesprite).halfy=y\2
freesprite=freesprite+1
next

type object
active as integer
x as integer
y as integer
z as integer 'height
mx as integer
my as integer
sprite as integer
end type

'create objects
dim o(1 to 1000) as object 'all game objects
dim shared lastobject as integer
lastobject=1000

'create player
i=newobject(o())
o(i).sprite=1
o(i).z=50
o(i).active=20
player=i

_MOUSEHIDE

'gameloop
do

do: loop while _MOUSEINPUT 'read all available mouse messages until current message

'set player's position
o(player).x=_mousex: o(player).y=_mousey

'draw land
landy=(landy+1) mod 56
for i=-1 to 4
put (0,i*56+landy),spritedata(s(4).index),_CLIP PSET,254
next

'draw enemy shadows
for i=1 to lastobject
if o(i).sprite=3 then displayshadow o(i)
next

'draw player's shadow
displayshadow o(player)

'draw enemies
for i=1 to lastobject
if o(i).sprite=3 then
display o(i)
move o(i)
if o(i).y-s(o(i).sprite).halfy>200 then o(i).y=-1000
end if
next

'draw bullets
for i=1 to lastobject
if o(i).sprite=2 then
display o(i)
move o(i)
if offscreen(o(i)) then freeobject o(i)
xshift=int(rnd*3)-1
o(i).mx=o(i).mx+xshift
o(i).my=o(i).my-1
end if
next

'draw player
display o(player)

'draw explosion(s)
for i=1 to lastobject
if o(i).sprite=5 then
for i2=1 to o(i).active
rad=i2*5:halfrad=rad\2
dx=rnd*rad-halfrad: dy=rnd*rad-halfrad
displayat o(i).x+dx,o(i).y+dy,o(i)
next
move o(i)
o(i).active=o(i).active-1
if o(i).active=0 then freeobject o(i)
end if
next

'hp bar
x=60
y=185
line (x-1,y)-step(20*10+2,5),2,b
line (x,y-1)-step(20*10,5+2),2,b
line (x,y)-step(20*10,5),40,bf
line (x,y)-step(o(player).active*10,5),47,bf

pcopy 1,0

'shoot?
if _MOUSEBUTTON(1) then
i=newobject(o())
o(i).sprite=2
o(i).x=o(player).x
o(i).y=o(player).y-s(o(player).sprite).halfy
o(i).my=-1
_sndplaycopy shootsound
end if

'bullet->enemy collision
for i=1 to lastobject
if o(i).sprite=2 then 'bullet
for i2=1 to lastobject
if o(i2).sprite=3 then 'enemy
if collision(o(i),o(i2)) then
_sndplaycopy shootsound
i3=newobject(o())
o(i3).sprite=5
o(i3).my=o(i2).my\2+1
if o(i2).active>1 then 'hit (small explosion)
o(i2).active=o(i2).active-1
o(i3).x=o(i).x
o(i3).y=o(i).y
else 'destroyed (large explosion)
o(i3).x=o(i2).x
o(i3).y=o(i2).y
o(i3).active=15
freeobject o(i2) 'enemy
end if
freeobject o(i) 'bullet
exit for
end if 'collision
end if
next
end if
next

'ship->enemy collision
i=player
for i2=1 to lastobject
if o(i2).sprite=3 then 'enemy
if collision(o(i),o(i2)) then
o(i).active=o(i).active-1
if o(i).active=0 then end
exit for
end if 'collision
end if
next

'add new enemy?
addenemy=addenemy+1
if addenemy=50 then
addenemy=0
i=newobject(o())
o(i).sprite=3
o(i).x=rnd*320
o(i).y=rnd*-1000-s(o(i).sprite).halfy
o(i).my=3+rnd*6
o(i).z=25+o(i).my*8
o(i).active=15 'hp
end if

'speed limit main loop to 18.2 frames per second
do: nt!=timer: loop while nt!=lt!
lt!=nt!

loop
'end main loop

sub move (o as object)
o.x=o.x+o.mx
o.y=o.y+o.my
end sub

sub display (o as object)
put (o.x-s(o.sprite).halfx,o.y-s(o.sprite).halfy),spritedata(s(o.sprite).index),_CLIP PSET,254
end sub

sub displayat (x as integer,y as integer,o as object)
put (x-s(o.sprite).halfx,y-s(o.sprite).halfy),spritedata(s(o.sprite).index),_CLIP PSET,254
end sub


sub displayshadow (o as object)
put (o.x-s(o.sprite).halfx,o.y-s(o.sprite).halfy+o.z),spritedata(s(o.sprite).index2),_CLIP PSET,254
end sub

function newobject (o() as object)
for i=1 to lastobject
if o(i).active=0 then
o(i).active=1
o(i).mx=0: o(i).my=0
o(i).z=0
newobject=i
exit function
end if
next
screen 0: print "No more free objects available!":end
end function

function offscreen (o as object)
if o.x+s(o.sprite).halfx<0 then offscreen=1:exit function
if o.x-s(o.sprite).halfx>319 then offscreen=1:exit function
if o.y+s(o.sprite).halfy<0 then offscreen=1:exit function
if o.y-s(o.sprite).halfy>199 then offscreen=1:exit function
end function

sub freeobject (o as object)
o.active=0
o.sprite=0
end sub

function collision(o1 as object, o2 as object)
if o1.y+s(o1.sprite).halfy<o2.y-s(o2.sprite).halfy then exit function
if o2.y+s(o2.sprite).halfy<o1.y-s(o1.sprite).halfy then exit function
if o1.x+s(o1.sprite).halfx<o2.x-s(o2.sprite).halfx then exit function
if o2.x+s(o2.sprite).halfx<o1.x-s(o1.sprite).halfx then exit function
collision=1
end function
