//Get Current Working Directory
qbs *func__cwd(){
  qbs *final, *tqbs;
  int length;
  char *buf, *ret;

#if defined QB64_WINDOWS
  length = GetCurrentDirectoryA(0, NULL);
  buf = (char *)malloc(length);
  if (!buf) {
    error(7); //"Out of memory"
    return tqbs;
  }
  if (GetCurrentDirectoryA(length, buf) != --length) { //Sanity check
    free(buf); //It's good practice
    tqbs = qbs_new(0, 1);
    error(51); //"Internal error"
    return tqbs;
  }
#elif defined QB64_LINUX
  length = 512;
  while(1) {
    buf = (char *)malloc(length);
    if (!buf) {
      tqbs = qbs_new(0, 1);
      error(7);
      return tqbs;
    }
    ret = getcwd(buf, length);
    if (ret) break;
    if (errno != ERANGE) {
      tqbs = qbs_new(0, 1);
      error(51);
      return tqbs;
    }
    free(buf);
    length += 512;
  }
  length = strlen(ret);
  ret = (char *)realloc(ret, length); //Chops off the null byte
  if (!ret) {
    tqbs = qbs_new(0, 1);
    error(7);
    return tqbs;
  }
  buf = ret;
#endif
  final = qbs_new(length, 1);
  memcpy(final->chr, buf, length);
  free(buf);
  return final;
}

