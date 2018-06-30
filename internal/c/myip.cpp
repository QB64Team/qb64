//Note: Updated 26/3/2014: Switched to WWW.QB64.NET to avoid IP changes when QB64 moves servers
//Note: Updated 16/1/2013: Switched to QB64.NET IP service
//Note: Updated 15/7/2013: Switched to 223.27.25.123 because of DNS issues

/*
    PRINT whatismyip$
    
    $CHECKING:OFF
    FUNCTION whatismyip$
    c = _OPENCLIENT("TCP/IP:80:www.qb64.net")
    IF c = 0 THEN EXIT FUNCTION
    'send request
    e$ = CHR$(13) + CHR$(10)
    x$ = "GET /ip.php HTTP/1.1" + e$
    x$ = x$ + "Host: www.qb64.net" + e$
    x$ = x$ + "" + e$
    PUT #c, , x$
    'wait for reply
    t! = TIMER
    DO
    IF TIMER - t! > 5 THEN CLOSE c: EXIT FUNCTION
    _DELAY 0.1
    GET #c, , a2$
    a$ = a$ + a2$
    dots = 0
    start = 0
    FOR x = 1 TO LEN(a$)
    a = ASC(a$, x)
    IF a >= 48 AND a <= 57 THEN
    IF start = 0 THEN start = x
    ELSE
    IF a = 46 AND start <> 0 THEN
    dots = dots + 1
    ELSE
    IF dots = 3 THEN
    ip$ = MID$(a$, start, x - start)
    EXIT DO
    END IF
    start = 0: dots = 0
    END IF
    END IF
    NEXT
    LOOP
    CLOSE c
    whatismyip$ = ip$
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
    
    
    //data.txt
    qbs *_FUNC_WHATISMYIP_STRING_WHATISMYIP=NULL;
    if (!_FUNC_WHATISMYIP_STRING_WHATISMYIP)_FUNC_WHATISMYIP_STRING_WHATISMYIP=qbs_new(0,0);
    float *_FUNC_WHATISMYIP_SINGLE_C=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_C==NULL){
        _FUNC_WHATISMYIP_SINGLE_C=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_C=0;
    }
    qbs *_FUNC_WHATISMYIP_STRING_E=NULL;
    if (!_FUNC_WHATISMYIP_STRING_E)_FUNC_WHATISMYIP_STRING_E=qbs_new(0,0);
    qbs *_FUNC_WHATISMYIP_STRING_X=NULL;
    if (!_FUNC_WHATISMYIP_STRING_X)_FUNC_WHATISMYIP_STRING_X=qbs_new(0,0);
    byte_element_struct *byte_element_5276=NULL;
    if (!byte_element_5276){
        if ((mem_static_pointer+=12)<mem_static_limit) byte_element_5276=(byte_element_struct*)(mem_static_pointer-12); else byte_element_5276=(byte_element_struct*)mem_static_malloc(12);
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
    float *_FUNC_WHATISMYIP_SINGLE_DOTS=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_DOTS==NULL){
        _FUNC_WHATISMYIP_SINGLE_DOTS=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_DOTS=0;
    }
    float *_FUNC_WHATISMYIP_SINGLE_START=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_START==NULL){
        _FUNC_WHATISMYIP_SINGLE_START=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_START=0;
    }
    float *_FUNC_WHATISMYIP_SINGLE_X=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_X==NULL){
        _FUNC_WHATISMYIP_SINGLE_X=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_X=0;
    }
    double fornext_value5279;
    double fornext_finalvalue5279;
    double fornext_step5279;
    uint8 fornext_step_negative5279;
    byte_element_struct *byte_element_5280=NULL;
    if (!byte_element_5280){
        if ((mem_static_pointer+=12)<mem_static_limit) byte_element_5280=(byte_element_struct*)(mem_static_pointer-12); else byte_element_5280=(byte_element_struct*)mem_static_malloc(12);
    }
    float *_FUNC_WHATISMYIP_SINGLE_A=NULL;
    if(_FUNC_WHATISMYIP_SINGLE_A==NULL){
        _FUNC_WHATISMYIP_SINGLE_A=(float*)mem_static_malloc(4);
        *_FUNC_WHATISMYIP_SINGLE_A=0;
    }
    qbs *_FUNC_WHATISMYIP_STRING_IP=NULL;
    if (!_FUNC_WHATISMYIP_STRING_IP)_FUNC_WHATISMYIP_STRING_IP=qbs_new(0,0);
    
    
    
    if (new_error) goto exit_subfunc;
    mem_lock *sf_mem_lock;
    new_mem_lock();
    sf_mem_lock=mem_lock_tmp;
    sf_mem_lock->type=3;
    *_FUNC_WHATISMYIP_SINGLE_C=func__openclient(qbs_new_txt_len("TCP/IP:80:www.qb64.net",22));
    qbs_cleanup(qbs_tmp_base,0);
    if ((-(*_FUNC_WHATISMYIP_SINGLE_C== 0 ))||new_error){
        goto exit_subfunc;
    }
    qbs_set(_FUNC_WHATISMYIP_STRING_E,qbs_add(func_chr( 13 ),func_chr( 10 )));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_X,qbs_add(qbs_new_txt_len("GET /ip.php HTTP/1.1",20),_FUNC_WHATISMYIP_STRING_E));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_X,qbs_add(qbs_add(_FUNC_WHATISMYIP_STRING_X,qbs_new_txt_len("Host: www.qb64.net",18)),_FUNC_WHATISMYIP_STRING_E));
    qbs_cleanup(qbs_tmp_base,0);
    qbs_set(_FUNC_WHATISMYIP_STRING_X,qbs_add(qbs_add(_FUNC_WHATISMYIP_STRING_X,qbs_new_txt_len("",0)),_FUNC_WHATISMYIP_STRING_E));
    qbs_cleanup(qbs_tmp_base,0);
    sub_put2(qbr(*_FUNC_WHATISMYIP_SINGLE_C),NULL,byte_element((uint64)_FUNC_WHATISMYIP_STRING_X->chr,_FUNC_WHATISMYIP_STRING_X->len,byte_element_5276),0);
    qbs_cleanup(qbs_tmp_base,0);
    *_FUNC_WHATISMYIP_SINGLE_T=func_timer(NULL,0);
    do{
        if ((-((func_timer(NULL,0)-*_FUNC_WHATISMYIP_SINGLE_T)>( 5 )))||new_error){
            sub_close(qbr(*_FUNC_WHATISMYIP_SINGLE_C),1);
            goto exit_subfunc;
        }
        sub__delay( 0.1E+0 );
        sub_get2(qbr(*_FUNC_WHATISMYIP_SINGLE_C),NULL,_FUNC_WHATISMYIP_STRING_A2,0);
        qbs_cleanup(qbs_tmp_base,0);
        qbs_set(_FUNC_WHATISMYIP_STRING_A,qbs_add(_FUNC_WHATISMYIP_STRING_A,_FUNC_WHATISMYIP_STRING_A2));
        qbs_cleanup(qbs_tmp_base,0);
        *_FUNC_WHATISMYIP_SINGLE_DOTS= 0 ;
        *_FUNC_WHATISMYIP_SINGLE_START= 0 ;
        fornext_value5279= 1 ;
        fornext_finalvalue5279=_FUNC_WHATISMYIP_STRING_A->len;
        fornext_step5279= 1 ;
        if (fornext_step5279<0) fornext_step_negative5279=1; else fornext_step_negative5279=0;
        if (new_error) goto fornext_error5279;
        goto fornext_entrylabel5279;
        while(1){
            fornext_value5279=fornext_step5279+(*_FUNC_WHATISMYIP_SINGLE_X);
            fornext_entrylabel5279:
            *_FUNC_WHATISMYIP_SINGLE_X=fornext_value5279;
            qbs_cleanup(qbs_tmp_base,0);
            if (fornext_step_negative5279){
                if (fornext_value5279<fornext_finalvalue5279) break;
                }else{
                if (fornext_value5279>fornext_finalvalue5279) break;
            }
            fornext_error5279:;
            *_FUNC_WHATISMYIP_SINGLE_A=qbs_asc(_FUNC_WHATISMYIP_STRING_A,qbr(*_FUNC_WHATISMYIP_SINGLE_X));
            qbs_cleanup(qbs_tmp_base,0);
            if (((-(*_FUNC_WHATISMYIP_SINGLE_A>= 48 ))&(-(*_FUNC_WHATISMYIP_SINGLE_A<= 57 )))||new_error){
                if ((-(*_FUNC_WHATISMYIP_SINGLE_START== 0 ))||new_error){
                    *_FUNC_WHATISMYIP_SINGLE_START=*_FUNC_WHATISMYIP_SINGLE_X;
                }
                }else{
                if (((-(*_FUNC_WHATISMYIP_SINGLE_A== 46 ))&(-(*_FUNC_WHATISMYIP_SINGLE_START!= 0 )))||new_error){
                    *_FUNC_WHATISMYIP_SINGLE_DOTS=*_FUNC_WHATISMYIP_SINGLE_DOTS+ 1 ;
                    }else{
                    if ((-(*_FUNC_WHATISMYIP_SINGLE_DOTS== 3 ))||new_error){
                        qbs_set(_FUNC_WHATISMYIP_STRING_IP,func_mid(_FUNC_WHATISMYIP_STRING_A,qbr(*_FUNC_WHATISMYIP_SINGLE_START),qbr(*_FUNC_WHATISMYIP_SINGLE_X-*_FUNC_WHATISMYIP_SINGLE_START),1));
                        qbs_cleanup(qbs_tmp_base,0);
                        goto dl_exit_5277;
                    }
                    *_FUNC_WHATISMYIP_SINGLE_START= 0 ;
                    *_FUNC_WHATISMYIP_SINGLE_DOTS= 0 ;
                }
            }
        }
        fornext_exit_5278:;
    }while(1);
    dl_exit_5277:;
    sub_close(qbr(*_FUNC_WHATISMYIP_SINGLE_C),1);
    qbs_set(_FUNC_WHATISMYIP_STRING_WHATISMYIP,_FUNC_WHATISMYIP_STRING_IP);
    qbs_cleanup(qbs_tmp_base,0);
    exit_subfunc:;
    free_mem_lock(sf_mem_lock);
    
    
    //free.txt
    qbs_free(_FUNC_WHATISMYIP_STRING_E);
    qbs_free(_FUNC_WHATISMYIP_STRING_X);
    qbs_free(_FUNC_WHATISMYIP_STRING_A2);
    qbs_free(_FUNC_WHATISMYIP_STRING_A);
    qbs_free(_FUNC_WHATISMYIP_STRING_IP);
    
    
    
    if ((tmp_mem_static_pointer>=mem_static)&&(tmp_mem_static_pointer<=mem_static_limit)) mem_static_pointer=tmp_mem_static_pointer; else mem_static_pointer=mem_static;
    cmem_sp=tmp_cmem_sp;
    qbs_maketmp(_FUNC_WHATISMYIP_STRING_WHATISMYIP);return _FUNC_WHATISMYIP_STRING_WHATISMYIP;
}
