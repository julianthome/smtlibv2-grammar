/**
 * SMT-LIB (v2.6) grammar
 *
 * http://smtlib.cs.uiowa.edu/papers/smt-lib-reference-v2.6-r2017-07-18.pdf
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2017 Julian Thome <julian.thome.de@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/

grammar SMT2;



String
    : '"' (PrintableChar | WhiteSpaceChar)+ '"'
    ;

QuotedSymbol
    : '|' (PrintableCharNoBackslash | WhiteSpaceChar)+ '|'
    ;

SimpleSymbol
    : Sym (Digit | Sym)*
    ;

Numeral
    : '0'
    | [1-9] Digit*
    ;

Exclamation
    : '!'
    ;

Colon
    : ':'
    ;

fragment Digit
    : [0-9]
    ;

fragment Sym
    : 'a'..'z'
    | 'A' .. 'Z'
    | '+'
    | '='
    | '/'
    | '*'
    | '%'
    | '?'
    | '!'
    | '$'
    | '-'
    | '_'
    | '~'
    | '&'
    | '^'
    | '<'
    | '>'
    | '@'
    ;

ParOpen
    : '('
    ;

ParClose
    : ')'
    ;

Binary:
    BinaryDigit+
    ;

HexDigit
    : '0' .. '9' | 'a' .. 'f' | 'A' .. 'F'
    ;

HexDecimal
    : '#x' HexDigit HexDigit HexDigit HexDigit
    ;

Decimal
    : Numeral '.' '0'* Numeral
    ;


fragment BinaryDigit
    : [01]
    ;

fragment PrintableChar
    : '\u0020' .. '\u007E'
    | '\u0080' .. '\uffff'
    | EscapedSpace
    ;

fragment PrintableCharNoBackslash
    : '\u0020' .. '\u005B'
    | '\u005D' .. '\u007B'
    | '\u007D' .. '\u007E'
    | '\u0080' .. '\uffff'
    | EscapedSpace
    ;

fragment EscapedSpace
    : '""'
    ;

fragment WhiteSpaceChar
    : '\u0009' | '\u000A' | '\u000D' | '\u0020'
    ;



// Starting rule(s)

start
    : script EOF
    ;

response
    : general_response EOF
    ;

// Lexicon

numeral
    : Numeral
    ;

decimal
    : Decimal
    ;

hexadecimal
    : HexDecimal
    ;

binary
    : Binary
    ;

string
    : String
    ;

symbol
    : SimpleSymbol
    | QuotedSymbol
    ;

keyword
    : Colon SimpleSymbol
    ;

// S-expression

spec_constant
    : numeral
    | decimal
    | hexadecimal
    | binary
    | string
    ;


s_expr
    : spec_constant
    | symbol
    | keyword
    | ParOpen s_expr* ParClose
    ;

// Identifiers

index
    : numeral
    | symbol
    ;

identifier
    : symbol
    | ParOpen '_' symbol index+ ParClose
    ;

// Attributes

attribute_value
    : spec_constant
    | symbol
    | ParOpen s_expr* ParClose
    ;

attribute
    : keyword
    | keyword attribute_value
    ;

// Sorts

sort
    : identifier
    | ParOpen identifier sort+ ParClose
    ;


// Terms and Formulas

qual_identifer
    : identifier
    | ParOpen 'as' identifier sort ParClose
    ;

var_binding
    : ParOpen symbol term ParClose
    ;

sorted_var
    : ParOpen symbol sort ParClose
    ;

pattern
    : symbol
    | ParOpen symbol symbol+ ParClose
    ;

match_case
    : ParOpen pattern term ParClose
    ;

term
    : spec_constant
    | qual_identifer
    | ParOpen qual_identifer term+ ParClose
    | ParOpen 'let' ParOpen var_binding+ ParClose term ParClose
    | ParOpen 'forall' ParOpen sorted_var+ ParClose term ParClose
    | ParOpen 'exists' ParOpen sorted_var+ ParClose term ParClose
    | ParOpen 'match' term ParOpen match_case+ ParClose ParClose
    | ParOpen '!' term attribute+ ParClose
    ;


// Theory Declarations

sort_symbol_decl
    : ParOpen identifier numeral attribute* ParClose;

meta_spec_constant
    : 'NUMERAL'
    | 'DECIMAL'
    | 'STRING'
    ;

fun_symbol_decl
    : ParOpen spec_constant sort attribute* ParClose
    | ParOpen meta_spec_constant sort attribute* ParClose
    | ParOpen identifier sort+ attribute* ParClose
    ;

par_fun_symbol_decl
    : fun_symbol_decl
    | ParOpen 'par' ParOpen symbol+ ParClose ParOpen identifier sort+
    attribute* ParClose ParClose
    ;

theory_attribute
    : ':sorts' ParOpen sort_symbol_decl+ ParClose
    | ':funs' ParOpen par_fun_symbol_decl+ ParClose
    | ':sorts-description' string
    | ':funs-description' string
    | ':definition' string
    | ':values:' string
    | ':notes' string
    | attribute
    ;

theory_decl
    : ParOpen 'theory' symbol theory_attribute+ ParClose
    ;


// Logic Declarations

logic_attribue
    : ':theories' ParOpen symbol+ ParClose
    | ':language' string
    | ':extensions' string
    | ':values' string
    | ':notes' string
    | attribute
    ;

logic
    : ParOpen 'logic' symbol logic_attribue+ ParClose
    ;


// Scripts

sort_dec
    : ParOpen symbol numeral ParClose
    ;

selector_dec
    : ParOpen symbol sort ParClose
    ;

constructor_dec
    : ParOpen symbol selector_dec* ParClose
    ;

datatype_dec
    : ParOpen constructor_dec+ ParClose
    | ParOpen 'par' ParOpen symbol+ ParClose ParOpen constructor_dec+
    ParClose ParClose
    ;

function_dec
    : ParOpen symbol ParOpen sorted_var* ParClose sort ParClose
    ;

function_def
    : symbol ParOpen sorted_var* ParClose sort term
    ;

prop_literal
    : symbol
    | ParOpen 'not' symbol ParClose
    ;


script
    : command*
    ;

command
    : ParOpen 'assert' term ParClose
    | ParOpen 'check-sat' ParClose
    | ParOpen 'check-sat-assuming' ParClose
    | ParOpen 'declare-const' symbol sort ParClose
    | ParOpen 'declare-datatype' symbol datatype_dec ParClose
    // cardinalitiees for sort_dec and datatype_dec have to be n+1
    | ParOpen 'declare-datatypes' ParOpen sort_dec+ ParClose ParOpen
    datatype_dec+ ParClose ParClose
    | ParOpen 'declare-fun' symbol ParOpen sort* ParClose sort ParClose
    | ParOpen 'declare-sort' symbol numeral ParClose
    | ParOpen 'define-fun'  function_def ParClose
    | ParOpen 'define-fun-rec' function_def ParClose
    // cardinalitiees for function_dec and term have to be n+1
    | ParOpen 'define-funs-rec' ParOpen function_dec+ ParClose
    ParOpen term+ ParClose ParClose
    | ParOpen 'define-sort' symbol ParOpen symbol* ParClose sort ParClose
    | ParOpen 'echo' string ParClose
    | ParOpen 'exit' ParClose
    | ParOpen 'get-assertions' ParClose
    | ParOpen 'get-assignment' ParClose
    | ParOpen 'get-info' info_flag ParClose
    | ParOpen 'get-model' ParClose
    | ParOpen 'get-option' keyword ParClose
    | ParOpen 'get-proof' ParClose
    | ParOpen 'get-unsat-assumptions' ParClose
    | ParOpen 'get-unsat-core' ParClose
    | ParOpen 'get-value' ParOpen term+ ParClose ParClose
    | ParOpen 'pop' numeral ParClose
    | ParOpen 'push' numeral ParClose
    | ParOpen 'reset' ParClose
    | ParOpen 'reset-assertions' ParClose
    | ParOpen 'set-info' attribute ParClose
    | ParOpen 'set-logic' symbol ParClose
    | ParOpen 'set-option' option ParClose
    ;


b_value
    : 'true'
    | 'false'
    ;

option
    : 'diagnostic-output-channel' string
    | ':global-declarations' b_value
    | ':interactive-mode' b_value
    | ':print-success' b_value
    | ':produce-assertions' b_value
    | ':produce-assignments' b_value
    | ':produce-models' b_value
    | ':produce-proofs' b_value
    | ':produce-unsat-assumptions' b_value
    | ':produce-unsat-cores' b_value
    | ':random-seed' numeral
    | ':regular-output-channel' string
    | ':reproducible-resource-limit' numeral
    | ':verbosity' numeral
    | attribute
    ;

info_flag
    : ':all-statistics'
    | ':assertion-stack-levels'
    | ':authors'
    | ':error-behaviours'
    | ':name'
    | ':reason-unknown'
    | ':version'
    | keyword
    ;

// responses

error_behaviour
    : 'immediate-exit'
    | 'continued-execution'
    ;

reason_unknown
    : 'memout'
    | 'incomplete'
    | s_expr
    ;

model_response
    : ParOpen 'define-fun' function_def ParClose
    | ParOpen 'define-fun-ref' function_def ParClose
    // cardinalitiees for function_dec and term have to be n+1
    | ParOpen 'define-funs-rec' ParOpen function_dec+ ParClose ParOpen term+
    ParClose ParClose
    ;

info_response
    : ':assertion-stack-levels' numeral
    | ':authors' string
    | ':error-behaviour' error_behaviour
    | ':name' string
    | ':reason-unknown' reason_unknown
    | ':version' string
    | attribute
    ;

valuation_pair
    : ParOpen term term ParClose
    ;

t_valuation_pair
    : ParOpen symbol b_value ParClose
    ;

check_sat_response
    : 'sat'
    | 'unsat'
    | 'unkown'
    ;

echo_response
    : string
    ;

get_assertions_response
    : ParOpen term* ParClose
    ;

get_assignment_response
    : ParOpen t_valuation_pair* ParClose
    ;

get_info_response
    : ParOpen info_response+ ParClose
    ;

get_model_response
    : ParOpen model_response* ParClose
    ;

get_option_response
    : attribute_value
    ;

get_proof_response
    : s_expr
    ;

get_unsat_assump_response
    : ParOpen symbol* ParClose
    ;

get_unsat_core_response
    : ParOpen symbol* ParClose
    ;

get_value_response
    : ParOpen valuation_pair+ ParClose
    ;

specific_success_response
    : check_sat_response
    | echo_response
    | get_assertions_response
    | get_assignment_response
    | get_info_response
    | get_model_response
    | get_option_response
    | get_proof_response
    | get_unsat_assump_response
    | get_unsat_core_response
    | get_value_response
    ;

general_response
    : 'success'
    | specific_success_response
    | 'unsupported'
    | ParOpen 'error' string ParClose
    ;


Comment
    : ';' ~[\r\n]* -> channel(HIDDEN)
    ;

WS  :  [ \t\r\n]+ -> skip
    ;