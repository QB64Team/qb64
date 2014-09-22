#ifdef QB64_WINDOWS
#define SNCMP(x,y,z) _memicmp((char *)x, (char *)y, z)
#else
#define SNCMP(x,y,z) strncasecmp((char *)x, (char *)y, z)
#endif 
int32 func__str_nc_compare(qbs *s1, qbs *s2) {
	int32 i, limit, l1, l2;
    l1 = s1->len; l2 = s2->len;  //no need to get the length of these strings multiple times.
	if (!l1) {   
		if (l2) return -1; else return 0;  //if one is a null string we known the answer already.
	}
	if (l1<=l2) limit = l1; else limit = l2; //our limit is going to be the length of the smallest string.

	#ifdef QB64_LINUX //by using memicmp with Windows, we don't need to do a precheck for CHR$(0) as it handles it just fine.
	  unsigned char *c1=s1->chr, *c2=s2->chr;
	  for (int32 i=0;i<limit; i++) {  //check the length of our string
        if (*c1==0||*c2==0) { //to see if it has a chr$(0) in it.
		   i=memcmp(qbs_lcase(s1)->chr,qbs_lcase(s2)->chr,limit); //if so, then we cheat and use the lcase comparisons to get a valid result.
	       if (i<0) return -1;
	       if (i>0) return 1; 
	       if (l1<l2) return -1; 
	       if (l2>l1) return 1;
	       return 0;
	    }
        c1++;
	    c2++;
      }
    #endif
	

    i=SNCMP(s1->chr,s2->chr,limit); //check only to the length of the shortest string
	if (i<0) return -1; //if the number is smaller by this point, say so
	if (i>0) return 1; // if it's larger by this point, say so
	//if the number is the same at this point, compare length.
	//if the length of the first one is smaller, then the string is smaller. Otherwise the second one is the same string, or longer.
	if (l1<l2) return -1;
	if (l1>l2) return 1;
    return 0;
}
#undef SNCMP

int32 func__str_compare(qbs *s1, qbs *s2) {
	int32 i, limit, l1, l2;
    l1 = s1->len; l2 = s2->len;  //no need to get the length of these strings multiple times.
	if (!l1) {   
		if (l2) return -1; else return 0;  //if one is a null string we known the answer already.
	}
	if (l1<=l2) limit = l1; else limit = l2; 
    i=memcmp(s1->chr,s2->chr,limit); 
    if (i<0) return -1;
    if (i>0) return 1; 
    if (l1<l2) return -1; 
    if (l2>l1) return 1;
    return 0;
}