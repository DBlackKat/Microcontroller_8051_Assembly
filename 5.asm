ORG	00H
JMP	START
ORG	50H
START:
MOV	R2,#0D
MOV	R3,#0D
MOV	R4,#0D
MOV	R5,#0D
COL1:
MOV		P1,#07FH
MOV   R1,#0
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,ROW1
COL2:
MOV		P1,#0BFH
MOV		R1,#1
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,ROW1
COL3:
MOV		P1,#0DFH
MOV		R1,#2
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,ROW1
COL4:
MOV		P1,#0EFH
MOV		R1,#3
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,ROW1
JMP		SHOW
ROW1:
CJNE 	A,#14,ROW2
MOV		R0,#0
JMP		CK
ROW2:
CJNE	A,#13,ROW3
MOV		R0,#3
JMP		CK
ROW3:
CJNE	A,#11,ROW4
MOV		R0,#6
JMP		CK
ROW4:
CJNE	A,#07,ROW1
MOV		R0,#9
CK:
SETB	C
JMP 	SHOW
CKC1:
CLR		C
MOV		P1,#07FH
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,CK
CKC2:
MOV		P1,#0BFH
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,CK
CKC3:
MOV		P1,#0DFH
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,CK
CKC4:
MOV		P1,#0EFH
MOV		A,P1
CALL	DELAY
ANL		A,#0FH
CJNE	A,#0FH,CK
SHIFT:
MOV		A,R4
MOV		R5,A
MOV		A,R3
MOV		R4,A
MOV		A,R2
MOV		R3,A
MOV		A,R1
ADD		A,R0
MOV		R2,A
MOV 	R1,#20
SHOW:
MOV		DPTR,#TABLE
MOV		A,R2
MOVC	A,@A+DPTR
ADD		A,#070H
MOV		P2,A
CALL 	DELAY3
MOV		A,R3
MOVC	A,@A+DPTR
ADD		A,#0B0H
MOV		P2,A
CALL 	DELAY3
MOV		A,R4
MOVC	A,@A+DPTR
ADD		A,#0D0H
MOV		P2,A
CALL 	DELAY3
MOV		A,R5
MOVC	A,@A+DPTR
ADD		A,#0E0H
MOV		P2,A
CALL	DELAY3
JC		CKC1
DJNZ	R1,SHOW
JMP		COL1
DELAY:
MOV		R6,#040H
DELAY1:
MOV		R7,#0FH
DELAY2:
DJNZ	R7,DELAY2
DJNZ	R6,DELAY1
RET
DELAY3:
MOV		R6,#100
DELAY4:
MOV		R7,#100
DELAY5:
DJNZ	R7,DELAY5
DJNZ	R6,DELAY4
RET
TABLE:
DB	00H,01H,02H,03H
DB	04H,05H,06H,07H
DB	08H,09H,0AH,0BH
DB	07CH,07DH,07EH,07FH
TABLE2:
DB	0B0H,0B1H,0B2H,0B3H
DB	0B4H,0B5H,0B6H,0B7H
DB	0B8H,0B9H,0BAH,0BBH
DB	0BCH,0BDH,0BEH,0BFH
TABLE3:
DB	0D0H,0D1H,0D2H,0D3H
DB	0D4H,0D5H,0D6H,0D7H
DB	0D8H,0D9H,0DAH,0DBH
DB	0DCH,0DDH,0DEH,0DFH
TABLE4:
DB	0E0H,0E1H,0E2H,0E3H
DB	0E4H,0E5H,0E6H,0E7H
DB	0E8H,0E9H,0EAH,0EBH
DB	0ECH,0EDH,0EEH,0EFH
END
