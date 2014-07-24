void sub__getinput(int32 filehandle, qbs *deststr) {
  if (new_error) return;
  int32 filebuf_size = 512;
  qbs *eol;
  gfs_file_struct *gfs;
  int32 fileno;

  if (gfs_fileno_valid(filehandle)!=1){error(52); return;}//Bad file name or number
  fileno=gfs_fileno[filehandle];//convert fileno to gfs index
  gfs=&gfs_file[fileno];
  if (gfs->type!=2){error(54); return;}//Bad file mode
  if (!gfs->read){error(75); return;}//Path/file access error

  eol = qbs_new_txt_len("\n", 1);

  int64 start_byte = func_seek(filehandle);
  int64 filelength = func_lof(filehandle);
   if (start_byte > filelength) {
    error(62);//input past end of file
	return;
  }
  qbs *buffer = qbs_new(filebuf_size, 0);
  qbs_set(deststr, qbs_new_txt_len("", 0));
    do {
      if (start_byte + filebuf_size > filelength) filebuf_size = filelength - start_byte + 1;
      qbs_set(buffer,func_space(qbr(filebuf_size))); 
	  
	  sub_get2(filehandle, start_byte, buffer, 1);
      int32 eol_pos = func_instr(0, buffer, eol, 0);
      if (eol_pos == 0) {
		if ((start_byte + filebuf_size)>=filelength) {
            qbs_set(deststr, buffer);
			gfs_setpos(fileno,filelength); //set the position right before the EOF marker
	        gfs_file[fileno].eof_passed=1;//also set EOF flag;
			qbs_free(buffer);
	        return;
		}
        filebuf_size += 512;
	  }
      else {
    	qbs_set(deststr, qbs_add(deststr, qbs_left(buffer, eol_pos - 1)));
	    break;
      }
    } while (!func_eof(filehandle));
  qbs_free(buffer);
  if (start_byte + deststr->len + 2 >= filelength) { //if we've read to the end of the line
	  gfs_setpos(fileno,filelength); //set the position right before the EOF marker
	  gfs_file[fileno].eof_passed=1;//also set EOF flag;
	  if (deststr->chr[deststr->len - 1] == '\r') qbs_set(deststr, qbs_left(deststr, deststr->len-1));
	  return;
  }
  gfs_setpos(fileno,start_byte + deststr->len); //set the position at the end of the text
  if (deststr->chr[deststr->len - 1] == '\r') qbs_set(deststr, qbs_left(deststr, deststr->len-1));
}



/*
OPEN "test.txt" FOR OUTPUT AS #1
FOR i = 0 TO 9
    t$ = t$ + "This is a test #" + STR$(i)
    PRINT #1, t$;
NEXT
CLOSE

OPEN "test.txt" FOR BINARY AS #1
DO
    z = z + 1
    _BLINEINPUT 1, x$
    'GetInput 1, x$   <-- This should be the BASIC equivelant of our routine.  (I hope.)
    PRINT x$, LEN(x$), ASC(x$, LEN(x$))
LOOP UNTIL EOF(1)
CLOSE

SUB GetInput (filehandle AS LONG, text AS STRING)

FileBuffer = 512 '        Set this number to match the sector size of your hard drive.
'                         Then we can read as much data as possible each spin of the disk head,
'                         and not need extra reads in the future.
DIM CRLF AS STRING
CRLF = CHR$(10)
StartByte = SEEK(filehandle)
DO
    IF StartByte + FileBuffer >= LOF(filehandle) THEN FileBuffer = LOF(filehandle) - StartByte + 1
    temp$ = SPACE$(FileBuffer)
    GET #filehandle, StartByte, temp$
    x = INSTR(temp$, CRLF)
    IF x = 0 THEN
        IF StartByte + FileBuffer = LOF(1) THEN text = temp$: EXIT DO 'Our while file is one line with NO CRLF
        FileBuffer = FileBuffer + 512
    ELSE
        text = LEFT$(temp$, x - 1)
        EXIT DO
    END IF
    PRINT StartByte, FileBuffer, LEN(text), LOF(1)
    SLEEP
LOOP UNTIL EOF(filehandle)

SEEK filehandle, StartByte + LEN(text) + 1
IF StartByte + LEN(text) + 1 >= LOF(1) THEN GET #1, , temp$ 'if we're at the eol be certain to trigger the eol flag
IF RIGHT$(text, 1) = CHR$(13) THEN text = LEFT$(text$, LEN(text$) - 1)
END SUB
*/