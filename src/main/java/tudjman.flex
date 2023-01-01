// import section
import java_cup.runtime.*;
%%
// declaration section
%cup
%class FranjoLexer
%function next_token
%line
%column
%debug
%eofval{
	return new Symbol( sym.EOF );
%eofval}

%{
//extra class members
KWTable kwTable = new KWTable();
public Symbol getKW() {
return new Symbol(kwTable.find(yytext()), yyline, yycolumn);
}
public int getLine(){
  return yyline;
}
%}

//states
%state COMMENT
//%state STRING
//macros
slovo = [a-zA-Z]
cifra = [0-9]
whiteSpace = [\n\r\t ]
string_one_line = \"([^\\\"]|\\.)*\"
comment = #.*

%%
// rules section
//Jel moze ovo ovako iako nemam tarabu u sym.java? trebalo bi da moze.....
//# { yybegin( COMMENT ); }
//<COMMENT>[^\n] {;} //sta god da dodjes osim NEWLINE ne razmatraj
//<COMMENT>\n { yybegin( YYINITIAL ); } //ako  dodje NEWLINE prebaci se u YYINITIAL stanje

//Ovo sa stringovima necu ni da diram
//\" {yybegin( STRING ); string = new StringBuilder("");}
//<STRING> {
//      \"                             { yybegin(YYINITIAL);
//                                       return new Symbol(sym.CONST, string.toString()); }
//      [^\n\r\"\\]+                   { string.append( yytext() ); }
//      \\t                            { string.append('\t'); }
//      \\n                            { string.append('\n'); }
//
//      \\r                            { string.append('\r'); }
//      \\\"                           { string.append('\"'); }
//      \\                             { string.append('\\'); }
//}

{whiteSpace} { ; } //Ignorisi tarabu, NEWLINE, WHITE SPACE...
{comment} { ; }
\( { return new Symbol( sym.LP, yyline, yycolumn ); }
\) { return new Symbol( sym.RP, yyline, yycolumn ); }
\< { return new Symbol( sym.LAB, yyline, yycolumn); }
\> { return new Symbol( sym.RAB, yyline, yycolumn); }

//Jos nemam potrebu za ovim viticastim, to je ideja za LAMBDA FUNKCIJU
//\{ { return new Yytoken( sym.LV, yytext(), yyline, yycolumn ); }
//\} { return new Yytoken( sym.RV, yytext(), yyline, yycolumn ); }

//operators
&&   { return new Symbol( sym.AND, yyline, yycolumn );    }
\|\| { return new Symbol( sym.OR, yyline, yycolumn );     }
\+   { return new Symbol( sym.PLUS, yyline, yycolumn );   }
\*   { return new Symbol( sym.MUL, yyline, yycolumn );    }
\-   { return new Symbol( sym.MINUS, yyline, yycolumn );  }
\/   { return new Symbol( sym.DIV, yyline, yycolumn );    }
%    { return new Symbol( sym.MOD, yyline, yycolumn );    }
==   { return new Symbol( sym.EQUAL, yyline, yycolumn );  }
\!=  { return new Symbol( sym.NOT_EQUAL, yyline, yycolumn ); }
_   { return new Symbol( sym.UNDERSCORE, yyline, yycolumn); }
//separators
, { return new Symbol( sym.COMMA, yyline, yycolumn ); }
: { return new Symbol( sym.ASSIGN, yyline, yycolumn ); }
-> { return new Symbol( sym.RETURN_SIGN, yyline, yycolumn ); }

//key words
{slovo}+ | ({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(kwTable.find(yytext()), yyline, yycolumn); }

//id-s
//({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.ID, yyline, yycolumn ); }
//constants
{cifra}+ { return new Symbol( sym.CONST, yyline, yycolumn ); }
{cifra}+\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.CONST, yyline, yycolumn ); }
{string_one_line}  {return new Symbol(sym.CONST, yyline, yycolumn);}
'{slovo}' { return new Symbol( sym.CONST, yyline, yycolumn ); } //to je onda karakter const


true  { return new Symbol( sym.CONST, yyline, yycolumn ); }
false { return new Symbol( sym.CONST, yyline, yycolumn ); }
//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() + "at line: " + getLine()); }

