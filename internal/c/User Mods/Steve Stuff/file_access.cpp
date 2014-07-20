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
  if (start_byte + filebuf_size > func_lof(filehandle)) filebuf_size = func_lof(filehandle) - start_byte;
  if (start_byte > func_lof(filehandle)) {
    error(62);//input past end of file
	return;
  }
  qbs *buffer = qbs_new(filebuf_size, 0);
  qbs_set(deststr, qbs_new_txt_len("", 0));
    do {
 
      sub_get2(filehandle, start_byte, buffer, 1);
      int32 eol_pos = func_instr(0, buffer, eol, 0);
      if (eol_pos == 0) {
        start_byte += filebuf_size;
	qbs_set(deststr, qbs_add(deststr, buffer));
      }
      else {
    	start_byte += eol_pos - 1;
	qbs_set(deststr, qbs_add(deststr, qbs_left(buffer, eol_pos - 1)));
	break;
      }
    } while (!func_eof(filehandle));
  if (deststr->chr[deststr->len - 1] == '\r') qbs_set(deststr, qbs_left(deststr, deststr->len-1));
  sub_seek(filehandle, start_byte + eol->len);
  qbs_free(buffer);
}