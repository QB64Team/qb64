
mtri2_usegrad3:;


if(final == 1){
    if(no_edge_overlap) y2 = y2 - 1;
}

//not on screen?
if(y1 >= dheight){
    return;
}
if(y2 < 0){
    if(final) return;
    //jump to y2's position
    //note; original point locations are referenced because they are unmodified & represent the true distance of the run
    y = y2 - y1;
    p1 = g1->p1; p2 = g1->p2;
    d = g1->y2 - g1->y1;
    if(d){
        i64 = p2->tx - p1->tx;
        g1->tx += i64 * y / d;
        i64 = p2->ty - p1->ty;
        g1->ty += i64 * y / d;
        i64 = p2->x - p1->x;
        g1->x += i64 * y / d;
        p1 = g2->p1; p2 = g2->p2;
    }
    d = g2->y2 - g2->y1;
    if(d){
        i64 = p2->tx - p1->tx;
        g2->tx += i64 * y / d;
        i64 = p2->ty - p1->ty;
        g2->ty += i64 * y / d;
        i64 = p2->x - p1->x;
        g2->x += i64 * y / d;
    }
    goto mtri2_final;
}

//clip top
if(y1 < 0){
    //note; original point locations are referenced because they are unmodified & represent the true distance of the run
    y = -y1;
    p1 = g1->p1; p2 = g1->p2;
    d = g1->y2 - g1->y1;
    if(d){
        i64 = p2->tx - p1->tx;
        g1->tx += i64 * y / d;
        i64 = p2->ty - p1->ty;
        g1->ty += i64 * y / d;
        i64 = p2->x - p1->x;
        g1->x += i64 * y / d;
        p1 = g2->p1; p2 = g2->p2;
    }
    d = g2->y2 - g2->y1;
    if(d){
        i64 = p2->tx - p1->tx;
        g2->tx += i64 * y / d;
        i64 = p2->ty - p1->ty;
        g2->ty += i64 * y / d;
        i64 = p2->x - p1->x;
        g2->x += i64 * y / d;
    }
    y1 = 0;
}

if(y2 >= dheight){ //clip bottom
    y2 = dheight - 1;
}

//move indexed variable values into direct variables for faster referencing within 2nd bottleneck
g1x = g1->x; g2x = g2->x;
g1tx = g1->tx; g2tx = g2->tx;
g1ty = g1->ty; g2ty = g2->ty;
g1xi = g1->xi; g2xi = g2->xi;
g1txi = g1->txi; g2txi = g2->txi;
g1tyi = g1->tyi; g2tyi = g2->tyi;

//2nd bottleneck
for(y=y1;y<=y2;y++){
    
    if(g1x < 0) x1 = (g1x - 65535) / 65536;else x1 = g1x / 65536; //int-style rounding of fixed-point value
    if(g2x < 0) x2 = (g2x - 65535) / 65536;else x2 = g2x / 65536;
    
    if(x1 >= dwidth | x2 < 0) goto mtri2_donerow; //crop if(entirely offscreen
    
    tx = g1tx; ty = g1ty;
    
    //calculate gradients if they might be required
    if(x1 != x2){
        d = g2x - g1x;
        i64 = g2tx - g1tx; txi = (i64 << 16) / d;
        i64 = g2ty - g1ty; tyi = (i64 << 16) / d;
        }else{
        txi = 0; tyi = 0;
    }
    
    //calculate pixel offsets from ideals
    loff = ((g1x & 65535) - 32768); //note; works for positive & negative values
    roff = ((g2x & 65535) - 32768);
    
    if(roff < 0){ //not enough of rhs pixel exists to use
        if(x2 < dwidth & no_edge_overlap == 0){ //onscreen check
            //draw rhs pixel as is
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            pixel_offset32=dst_offset32+(y*dwidth+x2);
            //--------plot pixel--------
            switch((col=src_offset32[(g2ty>>16)*swidth+(g2tx>>16)])&0xFF000000){
                case 0xFF000000:
                *pixel_offset32=col;
                break;
                case 0x0:
                break;
                case 0x80000000:
                *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend128[*pixel_offset32>>24]<<24);
                break; 
                case 0x7F000000:
                *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend127[*pixel_offset32>>24]<<24);
                break;
                default:
                destcol=*pixel_offset32;
                cp=cblend+(col>>24<<16);
                *pixel_offset32=
                cp[(col<<8&0xFF00)+(destcol&255)    ]
                +(cp[(col&0xFF00)   +(destcol>>8&255) ]<<8)
                +(cp[(col>>8&0xFF00)+(destcol>>16&255)]<<16)
                +(ablend[(col>>24)+(destcol>>16&0xFF00)]<<24);
            };//switch
            //--------done plot pixel--------
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        }
        //move left one position
        x2--;
        if(x1 > x2 | x2 < 0) goto mtri2_donerow; //no more to do
        }else{
        if(no_edge_overlap){
            x2 = x2 - 1;
            if(x1 > x2 | x2 < 0) goto mtri2_donerow; //no more to do
        }
    }
    
    if(loff > 0){
        //draw lhs pixel as is
        if(x1 >= 0){
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            pixel_offset32=dst_offset32+(y*dwidth+x1);
            //--------plot pixel--------
            switch((col=src_offset32[(ty>>16)*swidth+(tx>>16)])&0xFF000000){
                case 0xFF000000:
                *pixel_offset32=col;
                break;
                case 0x0:
                break;
                case 0x80000000:
                *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend128[*pixel_offset32>>24]<<24);
                break; 
                case 0x7F000000:
                *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend127[*pixel_offset32>>24]<<24);
                break;
                default:
                destcol=*pixel_offset32;
                cp=cblend+(col>>24<<16);
                *pixel_offset32=
                cp[(col<<8&0xFF00)+(destcol&255)    ]
                +(cp[(col&0xFF00)   +(destcol>>8&255) ]<<8)
                +(cp[(col>>8&0xFF00)+(destcol>>16&255)]<<16)
                +(ablend[(col>>24)+(destcol>>16&0xFF00)]<<24);
            };//switch
            //--------done plot pixel--------
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        }
        //skip to next x location, effectively reducing steps by 1
        x1++;
        if(x1 > x2) goto mtri2_donerow;
        loff = -(65536 - loff); //adjust alignment to jump to next ideal offset
    }
    
    //align to loff
    i64 = -loff;
    tx += (i64 * txi) / 65536;
    ty += (i64 * tyi) / 65536;
    
    if(x1 < 0){ //clip left
        d = g2x - g1x;
        i64 = g2tx - g1tx;
        tx += ((i64 << 16) * -x1) / d;
        i64 = g2ty - g1ty;
        ty += ((i64 << 16) * -x1) / d;
        if(x1 < 0) x1 = 0;
    }
    
    if(x2 >= dwidth){
        x2 = dwidth - 1; //clip right
    }
    
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    pixel_offset32=dst_offset32+(y*dwidth+x1);
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    //bottleneck
    for(x=x1;x<=x2;x++){
        
        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        //--------plot pixel--------
        switch((col=src_offset32[(ty>>16)*swidth+(tx>>16)])&0xFF000000){
            case 0xFF000000:
            *pixel_offset32=col;
            break;
            case 0x0:
            break;
            case 0x80000000:
            *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend128[*pixel_offset32>>24]<<24);
            break; 
            case 0x7F000000:
            *pixel_offset32=(((*pixel_offset32&0xFEFEFE)+(col&0xFEFEFE))>>1)+(ablend127[*pixel_offset32>>24]<<24);
            break;
            default:
            destcol=*pixel_offset32;
            cp=cblend+(col>>24<<16);
            *pixel_offset32=
            cp[(col<<8&0xFF00)+(destcol&255)    ]
            +(cp[(col&0xFF00)   +(destcol>>8&255) ]<<8)
            +(cp[(col>>8&0xFF00)+(destcol>>16&255)]<<16)
            +(ablend[(col>>24)+(destcol>>16&0xFF00)]<<24);
        };//switch
        //--------done plot pixel--------
        pixel_offset32++;
        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        
        tx += txi;
        ty += tyi;
        
    }
    
    mtri2_donerow:;
    
    if(y != y2){
        g1x += g1xi; g1tx += g1txi; g1ty += g1tyi;
        g2x += g2xi; g2tx += g2txi; g2ty += g2tyi;
    }
    
}

if(final == 0){
    
    //update indexed variable values with direct variable values which have changed & may be required
    g1->x = g1x; g2->x = g2x;
    g1->tx = g1tx; g2->tx = g2tx;
    g1->ty = g1ty; g2->ty = g2ty;
    
    mtri2_final:;
    if(y2 < dheight - 1){ //no point continuing if(offscreen!
        if(g1->y2 < g2->y2) g1 = g3;else g2 = g3;
        
        //avoid doing the same row twice
        y1 = g3->y1 + 1;
        y2 = g3->y2;
        g1->x += g1->xi; g1->tx += g1->txi; g1->ty += g1->tyi;
        g2->x += g2->xi; g2->tx += g2->txi; g2->ty += g2->tyi;
        
        final = 1;
        goto mtri2_usegrad3;
    }
}

return;

