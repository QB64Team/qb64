CLS
COLOR 10
PRINT "                      HTML About Page Generator:: William Chamberlain"
SLEEP 1
CLS
INPUT "Please enter your name (displayed at top of page):"; n$
INPUT "Page will be displayed in what color letters?"; c$
INPUT "Page background color will be:"; b$
INPUT "Please, state a font type:"; w$
INPUT "Please enter your e-mail:"; e$
INPUT "Specify an age:"; a$
INPUT "Please state your favorite food:"; f$
OPEN "c:\" + n$ + ".html" FOR OUTPUT AS #1
PRINT #1, "<HTML><HEAD><TITLE>" + n$ + "'s Page</TITLE></HEAD>"
PRINT #1, "<BODY text='" + c$ + "' bgcolor='" + b$ + "' font='" + w$ + "'><H1 align='center'>" + n$; "</H1>"
PRINT #1, "<br>"
PRINT #1, "Age:" + a$ + "<br>"
PRINT #1, "Fav. Food:" + f$ + "<br>"
PRINT #1, "<a href='mailto:" + e$ + "'>My Email</a>"
PRINT #1, "</BODY></HTML>"
CLOSE 1
CLS
COLOR 14
PRINT "             Page processed, Thank you for using this program."
SLEEP 2
PRINT "                    Page will be found in E:\yourname.html"
SLEEP 3
END


