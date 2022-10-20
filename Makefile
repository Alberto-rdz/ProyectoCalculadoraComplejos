complex_cal : complex_cal.o
	gcc -o complex_cal

complex_cal.o: complex_cal.lex.yy.o complex_cal.tab.o




bison -d -v complex_cal.y 
flex -o complex_cal.lex.yy.c complex_cal.lex 
gcc -o complex_cal complex_cal.lex.yy.c complex_cal.tab.c 
./complex_cal