'This is my starfield entry hacked down to 25 lines 
'It needs a pretty fast computer...looks OK on my 1.5 GHz 
'JKC 2003 

1 TYPE star 
  x AS INTEGER 
  y AS INTEGER 
  z AS INTEGER 
  END TYPE 
6 DIM astar(0 TO 300) AS star 
7 DIM oldstar(0 TO 300) AS star 
8 FOR i = 0 TO 300 
9  astar(i).x = RND * 640 
10  astar(i).y = RND * 480 
11  astar(i).z = RND * 300 
12 NEXT i 
13 SCREEN 11 
14 DO 
15 FOR i = 0 TO 300 
16   IF astar(i).z < 1 THEN astar(i).z = 300 ELSE astar(i).z = astar(i).z - 1 
17   FOR p% = 0 TO oldstar(i).z 
18     CIRCLE (oldstar(i).x, oldstar(i).y), p%, 0 
19     IF astar(i).z <> 300 THEN CIRCLE (INT(2 * astar(i).z + astar(i).x / (1 + astar(i).z / 30)), INT(astar(i).z + astar(i).y / (1 + astar(i).z / 30))), p% 
20   NEXT p% 
21   oldstar(i).x = INT(2 * astar(i).z + astar(i).x / (1 + astar(i).z / 30)) 
22   oldstar(i).y = INT(astar(i).z + astar(i).y / (1 + astar(i).z / 30)) 
23   oldstar(i).z = 5 / (1 + astar(i).z / 20) 
24 NEXT i 
25 LOOP UNTIL INKEY$ <> ""