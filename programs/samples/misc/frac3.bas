SCREEN 12
WINDOW (-5, 0)-(5, 10)
RANDOMIZE TIMER
COLOR 10
DO
  SELECT CASE RND
    CASE IS < .01
      X = 0
      Y = .16 * Y
    CASE .01 TO .08
      X = .2 * X - .26 * Y
      Y = .23 * X + .22 * Y + 1.6
    CASE .08 TO .15
      X = -.15 * X + .28 * Y
      Y = .26 * X + .24 * Y + .44
    CASE ELSE
      X = .85 * X + .04 * Y
      Y = -.04 * X + .85 * Y + 1.6
  END SELECT
  PSET (X, Y)
LOOP UNTIL INKEY$ = CHR$(27)