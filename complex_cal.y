/* Esqueleto para complex_cal.y */
/* antes de agregar el */
/* gramática adecuada, este código */
/*¡No se puede compilar correctamente! */

%{
#include <stdio.h>
#include <stdlib.h>
#include "complex_cal.h"

/*  prototypes of the provided functions */ 
complex complex_add(complex, complex);
complex complex_sub(complex, complex);
complex complex_mul(complex, complex);
complex complex_div(complex, complex);
/*  prototypes of the provided functions */ 

int yylex(void);
int yyerror(const char*);
%}

/* start: Add your Bison declarations here, one declaration has been provided to you*/
%token CNUMBER
%left '+' '-'
%left '*' '/'
%nonassoc '(' ')'
/* end: Add your Bison declarations here, one declaration has been provided to you*/

%%
/* start:  Add your grammar rules and actions here */
input: /* empty */ 
     | input line
     ;

line: '\n'
    | complexAddSub '\n' {
        if ($1.img != 0)
          printf("%f%+fi\n", $1.real, $1.img);
        else
          printf("%f\n", $1.real);
      }
    ;

complexAddSub: complexAddSub '+' complexMulDiv {$$ = complex_add($1, $3);}
             | complexAddSub '-' complexMulDiv {$$ = complex_sub($1, $3);}
             | complexMulDiv {$$ = $1;}
             ;
             
complexMulDiv: complexMulDiv '*' complexParenthesis {$$ = complex_mul($1, $3);}
             | complexMulDiv '/' complexParenthesis {$$ = complex_div($1, $3);}
             | complexParenthesis {$$ = $1;}
             ;
             
complexParenthesis: '(' complexAddSub ')' {$$ = $2;}
                  | CNUMBER {$$ = $1;}
                  ;
/* end:  Add your grammar rules and actions here */
%%

int main() {
  return yyparse();
}

int yyerror(const char* s) { 
  printf("%s\n", s); 
  return 0; 
}

/* función provista para hacer sumas complejas */
/* entrada: números complejos c1, c2 */
/* salida: nada */
/* efecto secundario: ninguno */
/* valor devuelto: resultado de la suma en c3 */
complex complex_add (complex c1, complex c2) {
  /* c1 + c2 */
  complex c3;
  c3.real = c1.real + c2.real;
  c3.img = c1.img + c2.img;
  return c3;
}

/* función provista para hacer restas complejas */
/* entrada: números complejos c1, c2 */
/* salida: nada */
/* efecto secundario: ninguno */
/* valor devuelto: resultado de la resta en c3 */
complex complex_sub (complex c1, complex c2) {
  /* c1 - c2 */
  complex c3;
  c3.real = c1.real - c2.real;
  c3.img = c1.img - c2.img;
  return c3;
}

/* función provista para hacer multiplicaciones complejas */
/* entrada: números complejos c1, c2 */
/* salida: nada */
/* efecto secundario: ninguno */
/* valor devuelto: resultado de la multiplicación en c3 */
complejo complejo_mul (complejo c1, complejo c2) {
   /* c1 * c2 */
  complex c3;
  c3.real = c1.real*c2.real - c1.img*c2.img;
  c3.img = c1.img*c2.real + c1.real*c2.img;
  return c3;
}

/* función provista para hacer divisiones complejas */
/* entrada: números complejos c1, c2 */
/* salida: nada */
/* efecto secundario: ninguno */
/* valor devuelto: resultado de c1/c2 en c3 */
complejo complejo_div (complejo c1, complejo c2) {
   /* c1 / c2 (es decir, c1 dividido por c2 ) */
  complex c3;
  double d;

  /* divisor calculation using the conjugate of c2*/
  d = c2.real*c2.real + c2.img*c2.img;

  c3.real = (c1.real*c2.real + c1.img*c2.img) / d;
  c3.img = (c1.img*c2.real - c1.real*c2.img) / d;
  return c3;
}
