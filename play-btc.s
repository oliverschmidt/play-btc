.data

.incbin "sound.btc"


.code

.import __DATA_LOAD__, __DATA_SIZE__

        jsr $FC58

        lda #>__DATA_LOAD__
        ldx #>__DATA_SIZE__
        jsr PLAY

        lda $C010
WAIT:   lda $C000
        bpl WAIT
        lda $C010

        jsr $BF00
        .byte $65       ; quit
        .word QUIT

QUIT:   .byte $04       ; param_count
        .byte $00       ; quit_type
        .word $0000     ; reserved
        .byte $00       ; reserved
        .word $0000     ; reserved

; player core
; parameters:
;   A - first page to play
;   X - pages to play
; uses:
;   $FE,$FF
PLAY:   ldy #$00
        sty $FE
        sta $FE+1

; loop here as long as bits are [F]alse (aka 0)
F_NX:   nop             ; 2                         2
        nop             ; 2                         2
        nop             ; 2                         2
        bit $00         ; 3                         3
F_RD:   lda ($FE),y     ; 5                         5               5
        asl             ; 2                         2               2
        bcs T_1_SW      ; 2/3           2
        nop             ; 2             2
        nop             ; 2             2
        nop             ; 2             2
        nop             ; 2             2

F_1:    jsr DELAY       ; 6 (+13)      19
        asl             ; 2             2 = 31
        bcs T_2_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_2:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_3_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_3:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_4_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_4:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_5_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_5:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_6_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_6:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_7_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

F_7:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcs T_8_SW      ; 2/3                       2               2
        nop             ; 2                         2               2
        nop             ; 2                         2               2
        nop             ; 2                         2               2
        nop             ; 2                         2               2

F_8:    iny             ; 2                         2               2
        bne F_NX        ; 2/3                       3 = 31          2
        inc $FE+1       ; 5                                         5
        dex             ; 2                                         2
        bne F_RD        ; 2/3                                       3 = 31
        rts


; [SW]itch to [T]rue on bit [1]
T_1_SW: sta $C030       ; 4
        bcs T_1         ; 3 (always)


; [SW]itch to [T]rue on bit [2]
T_2_SW: sta $C030       ; 4
        bcs T_2         ; 3 (always)


; [SW]itch to [T]rue on bit [3]
T_3_SW: sta $C030       ; 4
        bcs T_3         ; 3 (always)


; [SW]itch to [T]rue on bit [4]
T_4_SW: sta $C030       ; 4
        bcs T_4         ; 3 (always)


; [SW]itch to [T]rue on bit [5]
T_5_SW: sta $C030       ; 4
        bcs T_5         ; 3 (always)


; [SW]itch to [T]rue on bit [6]
T_6_SW: sta $C030       ; 4
        bcs T_6         ; 3 (always)


; [SW]itch to [T]rue on bit [7]
T_7_SW: sta $C030       ; 4
        bcs T_7         ; 3 (always)


; [SW]itch to [T]rue on bit [8]
T_8_SW: sta $C030       ; 4
        bcs T_8         ; 3 (always)


; [SW]itch to [F]alse on bit [1]
F_1_SW: sta $C030       ; 4
        bcc F_1         ; 3 (always)


; [SW]itch to [F]alse on bit [2]
F_2_SW: sta $C030       ; 4
        bcc F_2         ; 3 (always)


; [SW]itch to [F]alse on bit [3]
F_3_SW: sta $C030       ; 4
        bcc F_3         ; 3 (always)


; [SW]itch to [F]alse on bit [4]
F_4_SW: sta $C030       ; 4
        bcc F_4         ; 3 (always)


; [SW]itch to [F]alse on bit [5]
F_5_SW: sta $C030       ; 4
        bcc F_5         ; 3 (always)


; [SW]itch to [F]alse on bit [6]
F_6_SW: sta $C030       ; 4
        bcc F_6         ; 3 (always)


; [SW]itch to [F]alse on bit [7]
F_7_SW: sta $C030       ; 4
        bcc F_7         ; 3 (always)


; [SW]itch to [F]alse on bit [8]
F_8_SW: sta $C030       ; 4
        bcc F_8         ; 3 (always)


; loop here as long as bits are [T]rue (aka 1)
T_NX:   nop             ; 2
        nop             ; 2
        nop             ; 2
        bit $00         ; 3
T_RD:   lda ($FE),y     ; 5
        asl             ; 2
        bcc F_1_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_1:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_2_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_2:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_3_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_3:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_4_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_4:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_5_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_5:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_6_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_6:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_7_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_7:    jsr DELAY       ; 6 (+13)
        asl             ; 2
        bcc F_8_SW      ; 2/3
        nop             ; 2
        nop             ; 2
        nop             ; 2
        nop             ; 2

T_8:    iny             ; 2
        bne T_NX        ; 2/3
        inc $FE+1       ; 5
        dex             ; 2
        bne T_RD        ; 2/3
        rts


DELAY:  stx $0400       ; 4
        bit $00         ; 3
        rts             ; 6 = 13
