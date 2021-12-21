package hoc2;
import java_cup.runtime.*;
import java.io.Reader;

%% /* inicio de declaraciones JFlex */
%class AnalizadorLexico
%line /* Se habilita el contador de lineas. Variable yyline, de tipo integer */
%column /* Se habilita el contado de columnas. Variable yycolumn, de tipo integer */
%char /* Se habilita el contador de caracteres. Variable yychar, de tipo long */
%cup /*Se habilita la compatibilidad con java cup */

/* el codigo entre % {y %} se copia tal cual dentro de la clase analizador léxico */
%{
/* Se crean los objetos Symbol para ser utilizados durante la sintésis de los atributos
    Symbol esta especificado en java.cup.Symbol */
    private Symbol symbol (int type){
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

/* hacemos algunas deficiones regulares, o macrodefiniciones */
LetraMin=[a-z]
Digito=[0-9]
%% /* Ahora van las expresiones regulares */
[ \t]+                      { ;}
"\n"                        {   return symbol(AnalizadorSintacticoSym.Enter);   }
{Digito}+(\.{Digito}+)?     {   return symbol(AnalizadorSintacticoSym.NUM, new Float(yytext())); }
"="                         {   return symbol(AnalizadorSintacticoSym.OpAsig);  }
"/"                         {   return symbol(AnalizadorSintacticoSym.OpDiv);   }
"*"                         {   return symbol(AnalizadorSintacticoSym.OpProd);  }
"-"                         {   return symbol(AnalizadorSintacticoSym.OpResta); }
"+"                         {   return symbol(AnalizadorSintacticoSym.OpSuma);  }
")"                         {   return symbol(AnalizadorSintacticoSym.ParDer);  }
"("                         {   return symbol(AnalizadorSintacticoSym.ParIzq);  }
{LetraMin} {int IndVar; IndVar=(int)(yytext().charAt(0)) - (int)'a'; return symbol(AnalizadorSintacticoSym.VAR, new Integer(IndVar)); }
.                           { return symbol(AnalizadorSintacticoSym.error);     }