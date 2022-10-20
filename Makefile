complex_cal : complex_cal.o
	gcc -o complex_cal

complex_cal.o: complex_cal.lex.yy.o complex_cal.tab.o
	gcc complex_cal.lex.yy.o complex_cal.tab.o -o complex_cal.o

complex_cal.o :	complex_cal.c
	



bison -d -v complex_cal.y 
flex -o complex_cal.lex.yy.c complex_cal.lex 
gcc -o complex_cal complex_cal.lex.yy.c complex_cal.tab.c 
./complex_cal