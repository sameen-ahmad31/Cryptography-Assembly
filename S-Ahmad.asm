.ORIG x3000; start the program at address x3000
    start .STRINGZ "STARTING PRIVACY MODULE \n"
    prompt .STRINGZ "ENTER E OR D OR X \n"
    LEA R0, start; loads the string into R0
    PUTS; prints out the start message
main
	; resets all the registers
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    ;AND R6 R6 #0
    E .FILL x45; E hexadecimal 
    D .FILL x44; D hexadecimal
    X .FILL x58; X hexadecimal
    LEA R0, prompt; loads the prompt message into R0
    PUTS; prints out the prompt message
    GETC; get the char
	; R0 right now hold, E, D, X, or something else 
	; for E
	LD R1 E
	NOT R3 R0
	ADD R3 R3 #1
	ADD R4 R3 R1; if it is 0 (R0 is E)
	BRz goToencrypt; go to the encrypted subroutine
	; clear all the other registers
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    ; for D
    LD R1 D
	NOT R3 R0
	ADD R3 R3 #1
	ADD R4 R3 R1; if it is 0 (R0 is D)
	BRz goTodecrypt; go to the decrypted subroutine
    ; clear all the other registers
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
	; for X
    LD R1 X
	NOT R3 R0
	ADD R3 R3 #1
	ADD R4 R3 R1; if it is 0 (R0 is X)
	BRz goToEn; go to the subroutine 
    invalid .STRINGZ "INVALID INPUT \n"
	; if none of the above aka Invalid Input
	LEA R0, invalid; loads the invalid input message into R0
	PUTS; prints out the message
	BRnzp main; go to step 1 again and ask for input 
	
goToEn; if the input is X, then it comes here
    ST R0, result; store the (valid input) character into the memory address
    ; clear the registers
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
	zeroo .FILL #0
	LD R5 zeroo; R5 has zero 
	LD R1 MESSAGE; R1 has the memory address of the message 
	tenn .FILL xA
	LD R2 tenn; has ten 
	; erases the encrypted data and replaces it with zeros 
	loopq 
	    ;AND R1 R1 #0; clears it 
		STR R5 R1 #0; fills it with zero 
		ADD R1 R1 #1; goes to the next address
		ADD R2 R2 #-1; clears until it reaches 10
		BRp loopq; loops until it reaches 0
	HALT; halts the program
result .FILL x3900; the memory address of the E or D or X  
goToencrypt; if the input is E, then it comes here 
    ST R0, result; store the (valid input) character into the memory address
	AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    JSR keyE; the subroutine for entering the key, takes in five characters 
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
    JSR checkKey; goes to the checkKey subroutine
    JSR entermess; go the subroutine to enter the message after the key is correctly entered
	encrypt
		;encrypts the message
        AND R1 R1 #0
        AND R2 R2 #0
        AND R3 R3 #0
        AND R4 R4 #0
        AND R5 R5 #0
        AND R6 R6 #0
        LD R1 MESSAGE; R1 has the message address
        LDI R2 t; R2 has t 
        compare .FILL #48
        LD R6 compare
        NOT R6 R6 
        ADD R6 R6 #1
        o .FILL #10
        LD R0 o; R3 has the value ten 
        ADD R6 R2 R6; if R2 equals 0, the second character is 0
        BRz caesar; then jump to caesar’s cipher subroutine
        AND R6 R6 #0
    ; Vigenere
    vigenere
        LDI R0 zero
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 one
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 two
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 three
        b .FILL #0
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address
        LDI R0 four
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 five
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 six
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address 
        LDI R0 seven
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address
        LDI R0 eight
        JSR XOR; call the subroutine
        ADD R1 R1 #1; go the next memory address
        LDI R0 nine
        JSR XOR; call the subroutine
    ; Caesar’s Cipher
    caesar
        LDI R5 w; the last three digits of the key
	    ADD R5 R5 #0; add zero itself
        LD R6 compare
        NOT R6 R6 
        ADD R6 R6 #1
        ADD R6 R5 R6
	    BRz bitshift; if all are zero then go to the bitshift 
        AND R1 R1 #0
	    AND R2 R2 #0
	    AND R3 R3 #0
        AND R4 R4 #0
  	    AND R6 R6 #0
  	    teh .FILL #10
  	    LD R0 teh; R0 has the value ten
	    LD R1 MESSAGE; R1 has the message address
	    loopmod; only keep R5, R0, and R1
	        LDI R0 zero
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 one
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 two
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 three
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 four
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 five
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 six
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 seven
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 eight
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 nine
		    ADD R3 R0 R5; add message + the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
    ; Bit Shift
    bitshift 
        ty .FILL #10
        LD R0 ty; load ten into R0
        LD R1 message; load message into R1
        LDI R2 xs; R2 has the value of v 
        LD R6 compare
        NOT R6 R6 
        ADD R6 R6 #1
        ADD R6 R2 R6
        BRz clearkey; if first character is 0, then there is no bit-shift so just clear the key and go back to main
        AND R6 R6 #0
        loopbits
            LDI R0 zero
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address 
	        LDI R0 one
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 two
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 three
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 four
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 five
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 six
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 seven
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 eight
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address
	        LDI R0 nine
	        JSR leftshift
	        ADD R1 R1 #1; go to the memory address 
    ;clear the key stored because of security vulnerability that can occur
    clearkey
        i .FILL #6; i has the value 5
        LD R4 keaddress; R4 has the key address
        AND R2 R2 #0; clear R2
        LD R5 i; R5 has the value of i
        loopy 
            STR R2 R4 #0; clear it 
            ADD R4 R4 #1; go to the address
            ADD R5 R5 #-1; substract the counter
            BRp loopy
	JSR main; go to step 1 after encrypting 
keaddress .FILL x3801; the memory address for storing the key
MESSAGE .FILL x4000; the message is at memory address x4000
xs .FILL x3801; the first character in the key 
t .FILL x3802; t has the second character of the key
w .FILL x3806; the last three digits
decryptmessage .FILL x5000; the decrypted message is at memory address x5000
ten .FILL #10; number 10
zero .FILL x4000;
one .FILL X4001
two .FILL x4002
three .FILL x4003
four .FILL x4004
five .FILL x4005
six .FILL x4006
seven .FILL x4007
eight .FILL x4008
nine .FILL x4009
goTodecrypt; if the input is D, then it comes here
    ST R0, result; store the (valid input) character into the memory address
   ; clears the registers
	AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
    JSR keyE; the subroutine for entering the key, takes in five characters
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
    JSR checkKey; goes to the checkKey subroutine
    JSR copyit
    Dbitshift
	    LDI R2 xs; R2 has the value of f
	    LD R6 compare
        NOT R6 R6 
        ADD R6 R6 #1
        ADD R6 R2 R6
	    BRz Dcaesar; if it is zero, then go to caesar
	    AND R6 R6 #0
	    LD R4 decryptmessage; R4 has the decrypted message’s memory address
	    loopbit
            LDI R0 dZero
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption 
	        LDI R0 dOne
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dTwo
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dThree
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dFour
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dFive
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dSix
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dSeven
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dEight
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	        LDI R0 dNine
	        JSR rightshift
	        ADD R4 R4 #1; go to the next memory address for the decryption
	Dcaesar
    	LDI R5 w; the last three digits of the key 
	    LD R6 compare
        NOT R6 R6 
        ADD R6 R6 #1
        ADD R6 R5 R6
	    BRz Dvigenere; go the vigenere if everything is zero
	    NOT R5 R5; complement the last three digits 
	    ADD R5 R5 #1; add 1 to get the 2’s Complement 
	    AND R1 R1 #0
	    AND R2 R2 #0
	    AND R3 R3 #0
        AND R4 R4 #0
  	    AND R6 R6 #0
	    LD R1 decryptmessage; R1 has the decrypted message 
	    loopmodw; only keep R5, R0, and R1
	        LDI R0 dZero
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dOne
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dTwo
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dThree
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dFour
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dFive
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dSix
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dSeven
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dEight
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
		    LDI R0 dNine
		    ADD R3 R0 R5; add message - the last three digits
		    JSR MODK; go the mod subroutine 
		    AND R3 R3 #0
		    ADD R1 R1 #1; go the next memory address
    Dvigenere
        AND R1 R1 #0
        AND R2 R2 #0
        AND R3 R3 #0
        AND R4 R4 #0
        AND R5 R5 #0
        AND R6 R6 #0
        LD R1 decryptmessage; R1 has the message address
        LDI R2 t; R2 has t 
        z .FILL #48
        LD R6 z
        NOT R6 R6 
        ADD R6 R6 #1
        ADD R6 R2 R6
        BRz goBack; if it is zero, then just go back to main
        AND R6 R6 #0
        loope
	        LDI R0 dZero
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dOne
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dTwo
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dThree
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address
            LDI R0 dFour
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dFive
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dSix
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address 
            LDI R0 dSeven
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address
            LDI R0 dEight
            JSR XOR; call the subroutine
            ADD R1 R1 #1; go the next memory address
            LDI R0 dNine
            JSR XOR; call the subroutine
	goBack
	    JSR main
	JSR main; go the step 1 after decrypting
copyit
    savespace13 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace13; save R7 into the location 
    LD R1 decryptmessage
    LDI R0 zero
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 one
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 two
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 three
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 four
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 five
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 six
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 seven
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 eight
    STR R0 R1 #0
    ADD R1 R1 #1
    LDI R0 nine
    STR R0 R1 #0
    LD R7 savespace13
    RET
enterMess; the subroutine for entering the message
    savespace12 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace12; save R7 into the location 
	entermessage .STRINGZ "ENTER MESSAGE \n"
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
	LD R1 MESSAGE; R1 has the memory address of the message 
	tew .FILL #10
	LD R2 tew; has ten 
	; loop through the stores a string of 10 characters
	LEA R0 entermessage; loads the enter message
	PUTS; prints the message 
	loopm 
		GETC; gets the character
		STR R0 R1 #0; stores the character
		ADD R1 R1 #1; goes to the next address
		ADD R2 R2 #-1; clears until it reaches 10
		BRp loopm; loops until it reaches 0	
	LD R7 savespace12
	RET	
keyaddress .FILL x3801; the memory address for storing the key
key .STRINGZ "ENTER KEY \n"

keyE; the subroutine for entering the key, takes in five characters
    savespace10 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace10; save R7 into the location 
    fivee .FILL x5; holds the value 5
    LD R1 fivee; load five into R1
    LD R2 keyaddress; R2 holds the memory address of the key
    LEA R0, key; loads the key
    PUTS; prints 
    loopqw; loops
	   GETC; get the character
	   STR R0 R2 #0; store the input 
	   ADD R2 R2 #1; go the next address
	   ;ADD R3 R3 #1; increase the counter by 1
	   ADD R1 R1 #-1; 
	   BRp loopqw; loops until it is 0
	LD R7 savespace10
    RET
    
k .FILL x3802; 	 
q .FILL x3803; third digit 
vv .FILL x3804;
dZero .FILL x5000
dOne .FILL x5001
dTwo .FILL x5002
dThree .FILL x5003
dFour .FILL x5004
dFive .FILL x5005
dSix .FILL x5006
dSeven .FILL x5007
dEight .FILL x5008
dNine .FILL x5009
checkKey
    savespace11 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace11; save R7 into the location 
    AND R1 R1 #0
    AND R2 R2 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    decimal .FILL #48
    LDI R3 keyaddress;
    LD R5 decimal 
    NOT R5 R5
    ADD R5 R5 #1
    ADD R5 R3 R5
    BRn incorrectkey; if it is a negative then it will error
    eightt .FILL x38;
    LD R2 eightt
    NOT R2 R2
    ADD R2 R2 #1
    ADD R1 R2 R3;
    BRzp incorrectkey; if it is positive or zero, then it is wrong
    AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    ; second character: 0 or non-numeric 
    LDI R3 k;
    ADD R3 R3 #0
    BRn incorrectkey; if it is a negative then it will give an error
    BRz ltd; this is correct
    LD R4 decimal 
    NOT R4 R4
    ADD R4 R4 #1
    ADD R1 R4 R3
    BRnz ltd; this is correct
    ; 1 - 9 is wrong 
    ninee .FILL x39;
    AND R1 R1 #0
    LD R2 ninee; 
    NOT R2 R2
    ADD R2 R2 #1
    ADD R1 R2 R3;
    BRnz incorrectkey; then it is wrong 
    ltd
        AND R1 R1 #0
        AND R2 R2 #0
        AND R3 R3 #0
        AND R4 R4 #0
        AND R5 R5 #0
        LDI R2 q; R2 has the third digit 
        LD R3 decimal 
        NOT R3 R3
        ADD R3 R3 #1
        ADD R2 R2 R3
	    hundr .FILL x64;
	    LD R1 hundr; 
	    JSR multi
	    LDI R2 vv; R2 now has the fourth digit 
	    LD R3 decimal 
        NOT R3 R3
        ADD R3 R3 #1
        ADD R2 R2 R3
	    tee .FILL xA
	    LD R1 tee
	    JSR multi
        JSR ltd2
    LD R7 savespace11
    RET
    
ww .FILL x3805; 5th character
lastthreedigits .FILL x3806

ltd2
    savespace9 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace9; save R7 into the location 
	LDI R2 ww;
	LD R3 decimal 
    NOT R3 R3
    ADD R3 R3 #1
    ADD R2 R2 R3
	ADD R5, R5, R2; add the last digit
	AND R1 R1 #0
    AND R2 R2 #0
    AND R3 R3 #0
    AND R4 R4 #0
    AND R6 R6 #0
    LD R3 lastthreedigits
    STR R5 R3 #0;
    ADD R5 R5 #0; check to see if it is zero
    BRn incorrectkey; if it is negative, then it is invalid
    highbound .FILL x7F; hexadecimal for 127
    LD R4 highbound
    NOT R4 R4
    ADD R4 R4 #1; 2's Complement of 127
    ADD R6 R4 R5
    BRp incorrectkey
    LD R7 savespace9
    RET
        
incorrectkey; when it is an incorrect key
    iinvalid .STRINGZ "INVALID INPUT \n"
	LEA R0, iinvalid; loads invalid input into R0
	PUTS; prints out the message
	BRnzp keyE; ask for the key again 
	
	
XOR
    ;clear the other registers
    AND R3 R3 #0
    AND R4 R4 #0
    AND R5 R5 #0
    AND R6 R6 #0
    savespace2 .BLKW 1; predefined memory location .BLWK
    ST R7, savespace2; save R7 into the location 
    NOT R4, R0; !A
    NOT R5, R2; !B
    AND R6, R4, R2; !A AND B
    AND R3, R5, R0; A AND !B
    NOT R6, R6; !(!A AND B)
    NOT R3, R3; !(A AND !B)
    AND R0 R0 #0; what is wrong in this line 525
    AND R0, R6, R3; !(!A AND B) AND !(A AND !B)
    NOT R0, R0; !(!(!A AND B) AND !(A AND !B))
    AND R6 R6 #0; gets a x0000 memory address at this line 528
    STR R0 R1 #0; store in the memory location
    LD R7, savespace2; store back the value
    RET

MODK; subroutine for the modulo operation, keep R3
    savespace7 .BLKW 1
    ST R7, savespace7
	AND R2 R2 #0
    AND R4 R4 #0
  	AND R6 R6 #0
	nummod .FILL x80; hexadecimal for 128
	LD R2 nummod; K
    NOT R6, R2
    ADD R6, R6, #1; -K
   	loopk
        ADD R3, R3, R6; temp = temp - K
        BRzp loopk; while (temp >= 0)
    ADD R4, R3, R2; NmodK = temp + K
	STR R4 R1 #0
	LD R7 savespace7
    RET

Multi; subroutine
    savespace6 .BLKW 1
    ST R7, savespace6
    AND R3 R3 #0
    AND R4 R4 #0
    AND R6 R6 #0
    ADD R6, R1, #0 
    loop
        ADD R4, R4, R2; add to the product
        ADD R6, R6, #-1; decrement 
        BRp loop; keep looping
    ADD R5, R5, R4; 
    LD R7 savespace6
    RET
    
leftshift
    savespace5 .BLKW 1
    ST R7, savespace5
    AND R3 R3 #0
	AND R4 R4 #0
	AND R5 R5 #0
	AND R6 R6 #0
    ADD R3 R2 #0; R3 has the value of R2
    ADD R5 R0 #0; R5 has the value of R0
	loopls
	    ADD R0 R0 R5
	    ADD R3 R3 #-1
	    BRzp loopls
    STR R0 R1 #0
    LD R7 savespace5
    RET
    
rightshift	
    AND R3 R3 #0
    AND R6 R6 #0
    AND R5 R5 #0
    AND R1 R1 #0
	ADD R3 R2 #0; R3 has the value of R2
	savespace4 .BLKW 1;
	ST R7, savespace4; save R7 into the location 
	NOT R6, R2; complement R2, which is the key
	ADD R6, R6, #1; add 1 to get the 2's Complement of key
	loopr
	    ADD R1 R0 #0; put R0 into R7
		ADD R1 R1 R6
		ADD R5 R1 #1; add one to the previous result 
		NOT R5 R5
		ADD R5, R5, #1; add 1 to get the 2's Complement of key
		ADD R6 R5 #0
		ADD R3 R3 #-1
		BRp loopr
	STR R1 R4 #0
	LD R7, savespace4; store back the value
	RET

.END