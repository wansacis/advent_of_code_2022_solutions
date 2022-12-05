       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADVENT-OF-CODE.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       
       FILE-CONTROL.
         SELECT DataFile ASSIGN TO "data"
           ORGANIZATION IS LINE SEQUENTIAL.
         SELECT ActionFile ASSIGN to "action_cbl"
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       
       FILE SECTION.
       FD ActionFile.
       01 Command.
         02 M PIC X(5).
         02 AMT PIC 99.
         02 F PIC X(6).
         02 SRC PIC 99.
         02 T PIC X(4).
         02 DST PIC 99.
       FD DataFile.
       01 Store.
         02 Str PIC X(36).
       WORKING-STORAGE SECTION.
      *THIS IS A CONFIG PARAM
       77 IS-PART-2 PIC 9 VALUE 1.
      *0= Part1, 1=Part2 Boolean, basically
       77 NUM-OF-STACKS PIC 9 VALUE 9.
       01 EOF PIC Z.
       01 TMP PIC 99.
       01 PARSER-FIELDS.
         02 X-SUB PIC 99.
         02 X-SUB2 PIC 99.
         02 X-INDEX PIC 9 VALUE 0.
       01 STORAGE.
         02 STACK OCCURS 9 TIMES.
           03 INITHACK.
             04 CRATES OCCURS 56 TIMES PIC X.
             04 P PIC 99 VALUE 0.
       01 X-STORAGE.
         02 X-STACK OCCURS 9 TIMES.
           03 X-INITHACK.
             04 X-CRATES OCCURS 56 TIMES PIC X.
             04 X-P PIC 99 VALUE 0.
       PROCEDURE DIVISION.
       BEGIN.
       MOVE 0 TO EOF.
       INITIALIZE STORAGE
       INITIALIZE X-STORAGE
       PERFORM VARYING X-SUB FROM 1 BY 1 UNTIL X-SUB > NUM-Of-STACKS
           INITIALIZE INITHACK(X-SUB)
           INITIALIZE X-INITHACK(X-SUB)
       END-PERFORM
       OPEN INPUT DataFile
      * THIS PARSES THE INITIAL STATE
       PERFORM UNTIL EOF = 1
           READ DataFile
             AT END MOVE 1 TO EOF
           END-READ
           MOVE 0 TO X-INDEX
           PERFORM VARYING X-SUB
      * 2 + N*4 are the indeces in the line where the letters are, COBOL
      * counts from 1, not 0
             FROM 2 BY 4 UNTIL X-SUB > FUNCTION LENGTH(Str)
             ADD 1 TO X-INDEX
             IF Str(X-SUB:1) NOT EQUAL TO " "
               ADD 1 TO P(X-INDEX)
               MOVE Str(X-SUB:1) TO CRATES(X-INDEX, P(X-INDEX))
             END-IF
            END-PERFORM
       END-PERFORM
      *REVERSE THE CRATES BECAUSE I READ THEM UPSIDE DOWN AND DUPLICATED
      *THE LAST ONE
       PERFORM VARYING X-SUB FROM 1 BY 1 UNTIL X-SUB > NUM-OF-STACKS
             SUBTRACT 1 FROM P(X-SUB)
             PERFORM VARYING X-SUB2 FROM P(X-SUB) BY -1 UNTIL X-SUB2 < 1
               ADD 1 TO X-P(X-SUB)
               MOVE CRATES(X-SUB, X-SUB2) TO X-CRATES(X-SUB, X-P(X-SUB))
             END-PERFORM
       END-PERFORM
       CLOSE DataFile
       OPEN INPUT ActionFile
       MOVE 0 TO EOF.
       PERFORM UNTIL EOF = 1
           READ ActionFile
             AT END MOVE 1 TO EOF
           END-READ
           MOVE AMT TO X-SUB
           PERFORM UNTIl AMT < 1
             IF IS-PART-2 IS EQUAL 0
               SUBTRACT 1 FROM AMT
               ADD 1 TO X-P(DST)
               MOVE X-CRATES(SRC, X-P(SRC)) TO X-CRATES(DST, X-P(DST))
               SUBTRACT 1 FROM X-P(SRC)
             ELSE
               MOVE X-P(DST) TO TMP
               ADD AMT TO TMP
               MOVE X-CRATES(SRC, X-P(SRC)) TO X-CRATES(DST, TMP)
               SUBTRACT 1 FROM X-P(SRC)
               SUBTRACT 1 FROM AMT
             END-IF
           END-PERFORM
           IF IS-PART-2 NOT IS EQUAL 0
             ADD X-SUB TO X-P(DST)
           END-IF
       END-PERFORM
       CLOSE ActionFile
       PERFORM VARYING X-SUB FROM 1 BY 1 UNTIL X-SUB > NUM-OF-STACKS
           DISPLAY X-CRATES(X-SUB, X-P(X-SUB))
       END-PERFORM
       STOP RUN.
