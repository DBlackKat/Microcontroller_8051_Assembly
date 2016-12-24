ORG 00H
JMP START
ORG 50H
START:
   MOV P2,#000000B
   MOV TMOD,#00010001B //select mod
ROW1:
	MOV  P1,#7FH			;?????row(s01-s04)
	CALL DELAY  			;delay
	MOV A,P1				;??port1?
	ANL A,#0FH				;????4-bit??0
	MOV R1,#0				;??R1???????(????) R1=0
	CJNE A,#0FH,COL1		;??s01-s04??????,??????col
ROW2:
	MOV  P1,#0BFH			;?????row(s05-s08)
	CALL DELAY
	MOV A,P1
	ANL A,#0FH
	MOV R1,#4				;??R1??? R1=4
	CJNE A,#0FH,COL1		;??s05-s08??????,??????col
ROW3:
	MOV  P1,#0DFH			;?????row(s09-s12)
	CALL DELAY
	MOV A,P1
	ANL A,#0FH
	MOV R1,#8				;??R1????  R1=8
	CJNE A,#0FH,COL1		;??s09-s12??????,??????col
ROW4:		
	MOV  P1,#0EFH			;?????row(s13-s16)
	CALL DELAY
	MOV A,P1
	ANL A,#0FH
	MOV R1,#12				;??R1????  R1=12
	CJNE A,#0FH,COL1		;??s09-s12??????,??????col
COL1:
	CJNE A,#0EH,COL2		;??????????,??????COL2
	MOV R0,#0				;?R1????????(????) R0=0
	JMP SHOW				;??SHOW????
COL2:
	CJNE A,#0DH,COL3		;??????????,??????COL3
	MOV R0,#1				;R0=1
	JMP SHOW
COL3:
	CJNE A,#0BH,COL4		;??????????,??????COL4
	MOV R0,#2				;R0=2
	JMP SHOW
COL4:
	CJNE A,#07H,ROW1		;??????????,??????ROW1
	MOV R0,#3				 ;R0=3
SHOW:
	MOV A,R1				;R1??A
	ADD A,R0				;R0?A??(?????????????)
	MOV R6,A
	MOV DPTR,#FREQ1
	MOVC A,@A+DPTR
	MOV R3,A
	MOV DPTR,#FREQ2
	MOV A,R6
	MOVC A,@A+DPTR
	MOV R4,A
OVER:	
	MOV R7,#5H
	CALL LOOP
	JMP ROW1				;????	
DELAY:
	MOV R5,#50
DELAY1:
	MOV R6,#150
DELAY2:
	DJNZ R6,DELAY2
	DJNZ R5,DELAY1
	RET


LOOP:
	CALL TIMER1
	DJNZ R7,LOOP
	CLR P2.0
	RET
TIMER1:
	MOV TH1,#03CH
	MOV TL1,#0B0H
	SETB TR1
TIME:
	CALL SOUND
	JNB TF1,TIME
	CLR TR1
	CLR TF1
	RET
SOUND:
	SETB P2.0
	ACALL FREQ
	CLR P2.0
	ACALL FREQ
	RET
FREQ:
	MOV TH0,R3
	MOV TL0,R4
	SETB TR0
HERE:
	JNB TF0,HERE
	CLR TR0
	CLR TF0
	SETB P2.0
	RET 
FREQ1:
	DB 0FBH,0FBH,0FCH,0FCH
	DB 0FCH,0FDH,0FDH,0FDH
	DB 0FDH,0FEH,0FEH,0FEH
	DB 09H,0DH,0EH,7FH

FREQ2:
	DB 004H,090H,0CH,44H
	DB 0ACH,009H,034H,84H
	DB 0C8H,00AH,022H,056H
	DB 09H,0DH,0EH,7FH
END