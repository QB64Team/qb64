//Note: Updated 23/9/2018: Switched to www.qb64.org since .net is down; replaces implementation with download sample code from wiki
//Note: Updated 26/3/2014: Switched to WWW.QB64.NET to avoid IP changes when QB64 moves servers
//Note: Updated 16/1/2013: Switched to QB64.NET IP service
//Note: Updated 15/7/2013: Switched to 223.27.25.123 because of DNS issues

/*
    'ip.php:
    '<?php
    '$ip = $_SERVER["REMOTE_ADDR"];
    'echo $ip;
    '?>
    PRINT whatismyip$

    $CHECKING:OFF
    FUNCTION whatismyip$
        url$ = "www.qb64.org/ip.php"
        url2$ = url$
        x = INSTR(url2$, "/")
        IF x THEN url2$ = LEFT$(url$, x - 1)
        client = _OPENCLIENT("TCP/IP:80:" + url2$)
        IF client = 0 THEN EXIT FUNCTION
        e$ = CHR$(13) + CHR$(10) ' end of line characters
        url3$ = RIGHT$(url$, LEN(url$) - x + 1)
        x$ = "GET " + url3$ + " HTTP/1.1" + e$
        x$ = x$ + "Host: " + url2$ + e$ + e$
        PUT #client, , x$
        t! = TIMER ' start time
        DO
            _DELAY 0.05 ' 50ms delay (20 checks per second)
            GET #client, , a2$
            a$ = a$ + a2$
            IF l = 0 THEN
                i = INSTR(a$, e$ + e$)
                IF i THEN
                    i2 = INSTR(i + 4, a$, e$)
                    IF i2 THEN
                        l = VAL("&H" + MID$(a$, i + 4, i2 - i - 2))
                        a$ = MID$(a$, i + 4 + i2 - i - 2)
                    END IF ' i2
                END IF ' i
            ELSE
                IF LEN(a$) >= l THEN
                    whatismyip$ = LEFT$(a$, l)
                    CLOSE client
                    EXIT FUNCTION
                END IF
            END IF
        LOOP UNTIL TIMER > t! + 5 ' (in seconds)
        CLOSE client
    END FUNCTION
    $CHECKING:ON
*/

qbs* WHATISMYIP(){ //changed name from FUNC_WHATISMYIP to WHATISMYIP
    qbs *tqbs;
    ptrszint tmp_long;
    int32 tmp_fileno;
    uint32 qbs_tmp_base=qbs_tmp_list_nexti;
    uint8 *tmp_mem_static_pointer=mem_static_pointer;
    uint32 tmp_cmem_sp=cmem_sp;
    
    // include "data1.txt"
    qbs *_FUNC_WHATISMYIP_STRING_WHATISMYIP=NULL;
    if (!_FUNC_WHATISMYIP_STRING_WHATISMYIP)_FUNC_WHATISMYIP_STRING_WHATISMYIP=qbs_new(0,0);
    qbs *_FUNC_WHATISMYIP_STRING_URL=NULL;
    if (!_FUNC_WHATISMYIP_STRING_URL)_FUNC_WHATISMYIP_STRING_URL=qbs_new(0,0);
    qbs *_FUNC_WHATISMYIP_STRING_URL2=NULL;
    if (!_FUNC_WHATISMYIP_STRING_URL2)_FUNC_WHATISMYIP_STRING_URL2=qbs_new(0,0);
    float *_FUNC_WHATISMYIP_SINGLE_X=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_X==NULL){
        _FUNC_WHATISMYIP_SINGLE_X=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_X=0;
    }
    float *_FUNC_WHATISMYIP_SINGLE_CLIENT=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_CLIENT==NULL){
        _FUNC_WHATISMYIP_SINGLE_CLIENT=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_CLIENT=0;
    }
    qbs *_FUNC_WHATISMYIP_STRING_E=NULL;
    if (!_FUNC_WHATISMYIP_STRING_E)_FUNC_WHATISMYIP_STRING_E=qbs_new(0,0);
    qbs *_FUNC_WHATISMYIP_STRING_URL3=NULL;
    if (!_FUNC_WHATISMYIP_STRING_URL3)_FUNC_WHATISMYIP_STRING_URL3=qbs_new(0,0);
    byte_element_struct *byte_element_2=NULL;
    if (!byte_element_2){
        if ((mem_static_pointer+=12)<mem_static_limit) byte_element_2=(byte_element_struct*)(mem_static_pointer-12); else byte_element_2=(byte_element_struct*)mem_static_malloc(12);
    }
    qbs *_FUNC_WHATISMYIP_STRING_X=NULL;
    if (!_FUNC_WHATISMYIP_STRING_X)_FUNC_WHATISMYIP_STRING_X=qbs_new(0,0);
    byte_element_struct *byte_element_3=NULL;
    if (!byte_element_3){
        if ((mem_static_pointer+=12)<mem_static_limit) byte_element_3=(byte_element_struct*)(mem_static_pointer-12); else byte_element_3=(byte_element_struct*)mem_static_malloc(12);
    }
    float *_FUNC_WHATISMYIP_SINGLE_T=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_T==NULL){
        _FUNC_WHATISMYIP_SINGLE_T=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_T=0;
    }
    qbs *_FUNC_WHATISMYIP_STRING_A2=NULL;
    if (!_FUNC_WHATISMYIP_STRING_A2)_FUNC_WHATISMYIP_STRING_A2=qbs_new(0,0);
    qbs *_FUNC_WHATISMYIP_STRING_A=NULL;
    if (!_FUNC_WHATISMYIP_STRING_A)_FUNC_WHATISMYIP_STRING_A=qbs_new(0,0);
    float *_FUNC_WHATISMYIP_SINGLE_L=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_L==NULL){
        _FUNC_WHATISMYIP_SINGLE_L=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_L=0;
    }
    float *_FUNC_WHATISMYIP_SINGLE_I=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_I==NULL){
        _FUNC_WHATISMYIP_SINGLE_I=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_I=0;
    }
    float *_FUNC_WHATISMYIP_SINGLE_I2=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_I2==NULL){
        _FUNC_WHATISMYIP_SINGLE_I2=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_I2=0;
    }
    byte_element_struct *byte_element_5=NULL;
    if (!byte_element_5){
        if ((mem_static_pointer+=12)<mem_static_limit) byte_element_5=(byte_element_struct*)(mem_static_pointer-12); else byte_element_5=(byte_element_struct*)mem_static_malloc(12);
    }
    // end of "data1.txt
    
    mem_lock *sf_mem_lock;
    new_mem_lock();
    sf_mem_lock=mem_lock_tmp;
    sf_mem_lock->type=3;
    if (new_error) goto exit_subfunc;
    qbs_set(_FUNC_WHATISMYIP_STRING_URL,qbs_new_txt_len("www.qb64.org/ip.php",19));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_URL2,_FUNC_WHATISMYIP_STRING_URL);
    qbs_cleanup(qbs_tmp_base,0);
    *_FUNC_WHATISMYIP_SINGLE_X=func_instr(NULL,_FUNC_WHATISMYIP_STRING_URL2,qbs_new_txt_len("/",1),0);
    qbs_cleanup(qbs_tmp_base,0);
    if ((*_FUNC_WHATISMYIP_SINGLE_X)||new_error){
        qbs_set(_FUNC_WHATISMYIP_STRING_URL2,qbs_left(_FUNC_WHATISMYIP_STRING_URL,qbr(*_FUNC_WHATISMYIP_SINGLE_X- 1 )));
        qbs_cleanup(qbs_tmp_base,0);
    }
    *_FUNC_WHATISMYIP_SINGLE_CLIENT=func__openclient(qbs_add(qbs_new_txt_len("TCP/IP:80:",10),_FUNC_WHATISMYIP_STRING_URL2));
    qbs_cleanup(qbs_tmp_base,0);
    if ((-(*_FUNC_WHATISMYIP_SINGLE_CLIENT== 0 ))||new_error){
        goto exit_subfunc;
    }
    qbs_set(_FUNC_WHATISMYIP_STRING_E,qbs_add(func_chr( 13 ),func_chr( 10 )));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_URL3,qbs_right(_FUNC_WHATISMYIP_STRING_URL,qbr(_FUNC_WHATISMYIP_STRING_URL->len-*_FUNC_WHATISMYIP_SINGLE_X+ 1 )));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_X,qbs_add(qbs_add(qbs_add(qbs_new_txt_len("GET ",4),_FUNC_WHATISMYIP_STRING_URL3),qbs_new_txt_len(" HTTP/1.1",9)),_FUNC_WHATISMYIP_STRING_E));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_X,qbs_add(qbs_add(qbs_add(qbs_add(_FUNC_WHATISMYIP_STRING_X,qbs_new_txt_len("Host: ",6)),_FUNC_WHATISMYIP_STRING_URL2),_FUNC_WHATISMYIP_STRING_E),_FUNC_WHATISMYIP_STRING_E));
    qbs_cleanup(qbs_tmp_base,0);
    sub_put2(qbr(*_FUNC_WHATISMYIP_SINGLE_CLIENT),NULL,byte_element((uint64)_FUNC_WHATISMYIP_STRING_X->chr,_FUNC_WHATISMYIP_STRING_X->len,byte_element_3),0);
    qbs_cleanup(qbs_tmp_base,0);
    *_FUNC_WHATISMYIP_SINGLE_T=func_timer(NULL,0);
    do{
        sub__delay( 0.05E+0 );
        sub_get2(qbr(*_FUNC_WHATISMYIP_SINGLE_CLIENT),NULL,_FUNC_WHATISMYIP_STRING_A2,0);
        qbs_cleanup(qbs_tmp_base,0);
        qbs_set(_FUNC_WHATISMYIP_STRING_A,qbs_add(_FUNC_WHATISMYIP_STRING_A,_FUNC_WHATISMYIP_STRING_A2));
        qbs_cleanup(qbs_tmp_base,0);
        if ((-(*_FUNC_WHATISMYIP_SINGLE_L== 0 ))||new_error){
            *_FUNC_WHATISMYIP_SINGLE_I=func_instr(NULL,_FUNC_WHATISMYIP_STRING_A,qbs_add(_FUNC_WHATISMYIP_STRING_E,_FUNC_WHATISMYIP_STRING_E),0);
            qbs_cleanup(qbs_tmp_base,0);
            if ((*_FUNC_WHATISMYIP_SINGLE_I)||new_error){
                *_FUNC_WHATISMYIP_SINGLE_I2=func_instr(qbr(*_FUNC_WHATISMYIP_SINGLE_I+ 4 ),_FUNC_WHATISMYIP_STRING_A,_FUNC_WHATISMYIP_STRING_E,1);
                qbs_cleanup(qbs_tmp_base,0);
                if ((*_FUNC_WHATISMYIP_SINGLE_I2)||new_error){
                    *_FUNC_WHATISMYIP_SINGLE_L=func_val(qbs_add(qbs_new_txt_len("&H",2),func_mid(_FUNC_WHATISMYIP_STRING_A,qbr(*_FUNC_WHATISMYIP_SINGLE_I+ 4 ),qbr(*_FUNC_WHATISMYIP_SINGLE_I2-*_FUNC_WHATISMYIP_SINGLE_I- 2 ),1)));
                    qbs_cleanup(qbs_tmp_base,0);
                    qbs_set(_FUNC_WHATISMYIP_STRING_A,func_mid(_FUNC_WHATISMYIP_STRING_A,qbr(*_FUNC_WHATISMYIP_SINGLE_I+ 4 +*_FUNC_WHATISMYIP_SINGLE_I2-*_FUNC_WHATISMYIP_SINGLE_I- 2 ),NULL,0));
                    qbs_cleanup(qbs_tmp_base,0);
                }
            }
            }else{
            if ((qbs_cleanup(qbs_tmp_base,-(_FUNC_WHATISMYIP_STRING_A->len>=*_FUNC_WHATISMYIP_SINGLE_L)))||new_error){
                qbs_set(_FUNC_WHATISMYIP_STRING_WHATISMYIP,qbs_left(_FUNC_WHATISMYIP_STRING_A,qbr(*_FUNC_WHATISMYIP_SINGLE_L)));
                qbs_cleanup(qbs_tmp_base,0);
                sub_close(qbr(*_FUNC_WHATISMYIP_SINGLE_CLIENT),1);
                goto exit_subfunc;
            }
        }
        dl_continue_4:;
    }while((!(-(((float)((func_timer(NULL,0))))>((float)((*_FUNC_WHATISMYIP_SINGLE_T+ 5 ))))))&&(!new_error));
    dl_exit_4:;
    sub_close(qbr(*_FUNC_WHATISMYIP_SINGLE_CLIENT),1);
    exit_subfunc:;
    free_mem_lock(sf_mem_lock);

    // include "free1.txt"
    qbs_free(_FUNC_WHATISMYIP_STRING_URL);
    qbs_free(_FUNC_WHATISMYIP_STRING_URL2);
    qbs_free(_FUNC_WHATISMYIP_STRING_E);
    qbs_free(_FUNC_WHATISMYIP_STRING_URL3);
    qbs_free(_FUNC_WHATISMYIP_STRING_X);
    qbs_free(_FUNC_WHATISMYIP_STRING_A2);
    qbs_free(_FUNC_WHATISMYIP_STRING_A);
    // end of "free1.txt"
    
    if ((tmp_mem_static_pointer>=mem_static)&&(tmp_mem_static_pointer<=mem_static_limit)) mem_static_pointer=tmp_mem_static_pointer; else mem_static_pointer=mem_static;
    cmem_sp=tmp_cmem_sp;
    qbs_maketmp(_FUNC_WHATISMYIP_STRING_WHATISMYIP);return _FUNC_WHATISMYIP_STRING_WHATISMYIP;
}
