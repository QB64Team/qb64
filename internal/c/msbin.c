//
// The following are implementations of Microsoft RTL functions not
// include in the Borland RTL.
//
// Functions:
//     _fmsbintoieee()
//     _fieeetomsbin()
//     _dmsbintoieee()
//     _dieeetomsbin()
//
// These functions convert back and forth from Microsoft Binary Format
// to IEEE floating point format.
//
// As with the Microsoft RTL functions,
//
// The argument srcX points to the value to be converted and the
// result is stored at the location given at destX.
//
// These routines do not handle IEE NAN's and infinities.  IEEE
// denormals are treated as 0's.
//
// Return:
//
// These functions return 0 if the conversion is successful and 1
// if the conversion causes an overflow.
//
//
//
// Examples of the use of these functions can be found online as
// MSBIN.ZIP.
//
//--------------------------------------------------------------------




//#include <string.h>        /* for strncpy  */

int32 _fmsbintoieee(float *src4, float *dest4)
{
    unsigned char *msbin = (unsigned char *)src4;
    unsigned char *ieee = (unsigned char *)dest4;
    unsigned char sign = 0x00;
    unsigned char ieee_exp = 0x00;
    int32 i;
    
    /* MS Binary Format                         */
    /* byte order =>    m3 | m2 | m1 | exponent */
    /* m1 is most significant byte => sbbb|bbbb */
    /* m3 is the least significant byte         */
    /*      m = mantissa byte                   */
    /*      s = sign bit                        */
    /*      b = bit                             */
    
    sign = msbin[2] & 0x80;      /* 1000|0000b  */
    
    /* IEEE Single Precision Float Format       */
    /*    m3        m2        m1     exponent   */
    /* mmmm|mmmm mmmm|mmmm emmm|mmmm seee|eeee  */
    /*          s = sign bit                    */
    /*          e = exponent bit                */
    /*          m = mantissa bit                */
    
    for (i=0; i<4; i++) ieee[i] = 0;
    
    /* any msbin w/ exponent of zero = zero */
    if (msbin[3] == 0) return 0;
    
    ieee[3] |= sign;
    
    /* MBF is bias 128 and IEEE is bias 127. ALSO, MBF places   */
    /* the decimal point before the assumed bit, while          */
    /* IEEE places the decimal point after the assumed bit.     */
    
    ieee_exp = msbin[3] - 2;    /* actually, msbin[3]-1-128+127 */
    
    /* the first 7 bits of the exponent in ieee[3] */
    ieee[3] |= ieee_exp >> 1;   
    
    /* the one remaining bit in first bin of ieee[2] */
    ieee[2] |= ieee_exp << 7;   
    
    /* 0111|1111b : mask out the msbin sign bit */
    ieee[2] |= msbin[2] & 0x7f;
    
    ieee[1] = msbin[1];
    ieee[0] = msbin[0];
    
    return 0;
}


int32 _fieeetomsbin(float *src4, float *dest4)
{
    unsigned char *ieee = (unsigned char *)src4;
    unsigned char *msbin = (unsigned char *)dest4;
    unsigned char sign = 0x00;
    unsigned char msbin_exp = 0x00;
    int32 i;
    
    /* See _fmsbintoieee() for details of formats   */
    sign = ieee[3] & 0x80;
    msbin_exp |= ieee[3] << 1;
    msbin_exp |= ieee[2] >> 7;
    
    /* An ieee exponent of 0xfe overflows in MBF    */
    if (msbin_exp == 0xfe) return 1;
    
    msbin_exp += 2;     /* actually, -127 + 128 + 1 */
    
    for (i=0; i<4; i++) msbin[i] = 0;
    
    msbin[3] = msbin_exp;
    
    msbin[2] |= sign;
    msbin[2] |= ieee[2] & 0x7f;
    msbin[1] = ieee[1];
    msbin[0] = ieee[0];
    
    return 0;
}



int32 _dmsbintoieee(double *src8, double *dest8)
{
    unsigned char msbin[8];
    unsigned char *ieee = (unsigned char *)dest8;
    unsigned char sign = 0x00;
    uint32 ieee_exp = 0x0000;
    int32 i;
    
    /* A manipulatable copy of the msbin number     */
    memcpy(msbin,src8,8); //strncpy((char *)msbin,(char *)src8,8);
    
    
    /* MS Binary Format                                             */
    /* byte order =>    m7 | m6 | m5 | m4 | m3 | m2 | m1 | exponent */
    /* m1 is most significant byte => smmm|mmmm                     */
    /* m7 is the least significant byte                             */
    /*      m = mantissa byte                                       */
    /*      s = sign bit                                            */
    /*      b = bit                                                 */
    
    sign = msbin[6] & 0x80;      /* 1000|0000b  */
    
    
    /* IEEE Single Precision Float Format                           */
    /*  byte 8    byte 7    byte 6    byte 5    byte 4    and so on */
    /* seee|eeee eeee|mmmm mmmm|mmmm mmmm|mmmm mmmm|mmmm ...        */
    /*          s = sign bit                                        */
    /*          e = exponent bit                                    */
    /*          m = mantissa bit                                    */
    
    for (i=0; i<8; i++) ieee[i] = 0;
    
    /* any msbin w/ exponent of zero = zero */
    if (msbin[7] == 0) return 0;
    
    
    ieee[7] |= sign;
    
    /* MBF is bias 128 and IEEE is bias 1023. ALSO, MBF places  */
    /* the decimal point before the assumed bit, while          */
    /* IEEE places the decimal point after the assumed bit.     */
    
    ieee_exp = msbin[7] - 128 - 1 + 1023;
    
    /* First 4 bits of the msbin exponent   */
    /* go into the last 4 bits of ieee[7]   */
    ieee[7] |= ieee_exp >> 4;
    
    /* The last 4 bits of msbin exponent    */
    /* go into the first 4 bits of ieee[6]  */
    ieee[6] |= ieee_exp << 4;
    
    /* The msbin mantissa must be shifted to the right 1 bit.   */
    /* Remember that the msbin number has its bytes reversed.   */
    for (i=6; i>0; i--)
    {
        msbin[i] <<= 1;
        msbin[i] |= msbin[i-1] >> 7;
    }
    msbin[0] <<= 1;
    
    /* Now the mantissa is put into the ieee array starting in  */
    /* the middle of the second to last byte.                   */
    
    for (i=6; i>0; i--)
    {
        ieee[i] |= msbin[i] >> 4;
        ieee[i-1] |= msbin[i] << 4;
    }
    ieee[0] |= msbin[0] >> 4;
    
    /* IEEE has a half byte less for its mantissa.  If the msbin    */
    /* number has anything in this last half byte, then there is an */
    /* overflow.                                                    */
    if (msbin[0] & 0x0f) 
    return 1;
    else
    return 0;
}

int32 _dieeetomsbin(double *src8, double *dest8)
{
    unsigned char ieee[8];
    unsigned char *msbin = (unsigned char *)dest8;
    unsigned char sign = 0x00;
    unsigned char any_on = 0x00;
    uint32 msbin_exp = 0x0000;
    int32 i;
    
    /* Make a clobberable copy of the source number */ 
    memcpy(ieee,src8,8); //strncpy((char *)ieee,(char *)src8,8);
    
   memset(msbin, 0, sizeof(*dest8)); //for (i=0; i<8; i++) msbin[i] = 0;
    
    /* If all are zero in src8, the msbin should be zero */
    for (i=0; i<8; i++) any_on |= ieee[i];
    if (!any_on) {return 0;}
    
    sign = ieee[7] & 0x80;
    msbin[6] |= sign;
   msbin_exp = (unsigned)(ieee[7] & 0x7f) << 4;	//(unsigned)(ieee[7] & 0x7f) * 0x10;
    msbin_exp += ieee[6] >> 4;
    
   // verify the exponent is in range for MBF encoding
   msbin_exp = msbin_exp - 0x3ff + 0x80 + 1;
   if ((msbin_exp & 0xff00) != 0) return 1;
   msbin[7] = msbin_exp;
   // if (msbin_exp-0x3ff > 0x80) return 1;
   // msbin[7] = msbin_exp - 0x3ff + 0x80 + 1; 
    
    /* The ieee mantissa must be shifted up 3 bits */
    ieee[6] &= 0x0f; /* mask out the exponent in the second byte    */
    for (i=6; i>0; i--)
    {
        msbin[i] |= ieee[i] << 3;
        msbin[i] |= ieee[i-1] >> 5;
    }
    
    msbin[0] |= ieee[0] << 3;
    
    return 0;
}







