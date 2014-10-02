#include <stdlib.h>

int32 func__str_nc_compare(qbs *s1, qbs *s2) {
	int32 limit, l1, l2;
	int32 v1, v2;
	unsigned char *c1=s1->chr, *c2=s2->chr;
	
	l1 = s1->len; l2 = s2->len;  //no need to get the length of these strings multiple times.
	if (!l1) {   
		if (l2) return -1; else return 0;  //if one is a null string we known the answer already.
	}
	if (!l2) return 1;
	if (l1<=l2) limit = l1; else limit = l2; //our limit is going to be the length of the smallest string.

	for (int32 i=0;i<limit; i++) {  //check the length of our string
	  v1=*c1;v2=*c2;
	  if ((v1>64)&&(v1<91)) v1=v1|32;
	  if ((v2>64)&&(v2<91)) v2=v2|32;
	  if (v1<v2) return -1;
	  if (v1>v2) return 1;
       c1++;
	   c2++;
    }
      
    if (l1<l2) return -1; 
	if (l2>l1) return 1;
	return 0;
}


int32 func__str_compare(qbs *s1, qbs *s2) {
	int32 i, limit, l1, l2;
    l1 = s1->len; l2 = s2->len;  //no need to get the length of these strings multiple times.
	if (!l1) {   
		if (l2) return -1; else return 0;  //if one is a null string we known the answer already.
	}
	if (!l2) return 1;
	if (l1<=l2) limit = l1; else limit = l2; 
    i=memcmp(s1->chr,s2->chr,limit); 
    if (i<0) return -1;
    if (i>0) return 1; 
    if (l1<l2) return -1; 
    if (l1>l2) return 1;
    return 0;
}
