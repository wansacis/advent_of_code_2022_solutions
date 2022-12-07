: data s" data";

variable 'data
variable #data
variable 'comp
variable #comp
variable fh
variable offset
variable #letters
( PART 1 => 4, PART 2 => 14)
14 CONSTANT #letters 
variable letters #letters CELLS ALLOT
variable inc
variable pointer
variable counter
variable r
variable r2

: init0	    0 SWAP ! ;
: inc	    1 SWAP +! ;
: dec	    -1 SWAP +! ;

: start	    here 'data ! ;
: open	    data r/o open-file throw fh ! ;
: scan	    here 4096 fh @ read-file throw dup allot ;
: close	    fh @ close-file throw ;
: end	    here 'data @ - #data ! ;

start open scan close end

: letter    CELLS letters + ;
: log	    1 r ! begin r @ #letters 1 + u< while r @ . r @ letter c@ emit r inc repeat CR  1 r ! ;
: die	    pointer @ . CR bye ;
: check	    1 begin r @ #letters 1 + u< while
	      begin r @ r2 @ + #letters 1 + u< while
		r @ r2 @ + letter c@
		r @ letter c@ 
		= if  r @ r @ r2 @ + <> if 0 * #letters r +! then then r2 inc
	      repeat
	      r inc
	      r2 init0
	    repeat ;
: shift	    1 r ! begin r @ #letters u< while
	      r @ 1 + letter C@ 
	      r @ letter 
	      !
	      r inc
	    repeat #letters letter ! 1 r ! log ;
: judge	    pointer inc shift check 1 = IF 4 pointer @ < IF die then then ;
: solve	    begin offset @ #data @ u< while 
	    'data @ offset @ + c@ judge 1 offset +! 
	    repeat ;
offset init0
counter init0
pointer init0
r init0 r inc
r2 init0
CR
solve
