If you have problems running the install scripts under Linux (./setup_lnx.sh) or OS X (./setup_osx.command), run the following line in terminal, from your QB64 folder:

For Linux:
find . -name '*.sh' -exec sed -i "s/\r//g" {} \;

For OS X (don't forget you need to have Xcode installed to use QB64):
find . -name '*.command' -exec perl -pi -e 's/\r\n|\n|\r/\n/g' {} \;

If you have any other issues, check out the Forum:
http://www.qb64.net/forum/

http://www.qb64.net/forum/index.php?topic=13359.msg115525#msg115525