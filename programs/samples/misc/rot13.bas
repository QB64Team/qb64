'2007 mennonite
'public domain
z$="hello"
for n = 1 TO len(z$)
a$ = right$(left$(z$,n),1)
b$ = a$
c = asc(ucase$(a$))
if c > 64 and c < 91 then b$ = chr$((c - 65 + 13) mod 26 + 65)
if asc(a$) > 91 then b$ = lcase$(b$)
print b$;
next n