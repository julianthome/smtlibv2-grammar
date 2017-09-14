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

grammar SMTLIBv2Parser;


// Lexer Rules Start

String
    : '"' (PrintableChar | WhiteSpaceChar)+ '"'
    ;

QuotedSymbol
    : '|' (PrintableCharNoBackslash | WhiteSpaceChar)+ '|'
    ;

ParOpen
    : '('
    ;

ParClose
    : ')'
    ;

// Command names

fragment Commands
    : CMD_Assert
    | CMD_CheckSat
    | CMD_CheckSatAssuming
    | CMD_DeclareConst
    | CMD_DeclareDatatype
    | CMD_DeclareDatatypes
    | CMD_DeclareFun
    | CMD_DeclareSort
    | CMD_DefineFun
    | CMD_DefineFunRec
    | CMD_DefineFunsRec
    | CMD_DefineSort
    | CMD_Echo
    | CMD_Exit
    | CMD_GetAssertions
    | CMD_GetAssignment
    | CMD_GetInfo
    | CMD_GetModel
    | CMD_GetOption
    | CMD_GetProof
    | CMD_GetUnsatAssumptions
    | CMD_GetUnsatCore
    | CMD_GetValue
    | CMD_Pop
    | CMD_Push
    | CMD_Reset
    | CMD_ResetAssertions
    | CMD_SetInfo
    | CMD_SetLogic
    | CMD_SetOption
    ;

CMD_Assert
    : 'assert'
    ;
CMD_CheckSat
    : 'check-sat'
    ;
CMD_CheckSatAssuming
    : 'check-sat-assuming'
    ;
CMD_DeclareConst
    : 'declare-const'
    ;
CMD_DeclareDatatype
    : 'declare-datatype'
    ;
CMD_DeclareDatatypes
    : 'declare-datatypes'
    ;
CMD_DeclareFun
    : 'declare-fun'
    ;
CMD_DeclareSort
    : 'declare-sort'
    ;
CMD_DefineFun
    : 'define-fun'
    ;
CMD_DefineFunRec
    : 'define-fun-rec'
    ;
CMD_DefineFunsRec
    : 'define-funs-rec'
    ;
CMD_DefineSort
    : 'define-sort'
    ;
CMD_Echo
    : 'echo'
    ;
CMD_Exit
    : 'exit'
    ;
CMD_GetAssertions
    : 'get-assertions'
    ;
CMD_GetAssignment
    : 'get-assignment'
    ;
CMD_GetInfo
    : 'get-info'
    ;
CMD_GetModel
    : 'get-model'
    ;
CMD_GetOption
    : 'get-option'
    ;
CMD_GetProof
    : 'get-proof'
    ;
CMD_GetUnsatAssumptions
    : 'get-unsat-assumptions'
    ;
CMD_GetUnsatCore
    : 'get-unsat-core'
    ;
CMD_GetValue
    : 'get-value'
    ;
CMD_Pop
    : 'pop'
    ;
CMD_Push
    : 'push'
    ;
CMD_Reset
    : 'reset'
    ;
CMD_ResetAssertions
    : 'reset-assertions'
    ;
CMD_SetInfo
    : 'set-info'
    ;
CMD_SetLogic
    : 'set-logic'
    ;
CMD_SetOption
    : 'set-option'
    ;




SimpleSymbol
    : PredefSymbols
    | Sym (Digit | Sym)*
    ;

Numeral
    : '0'
    | [1-9] Digit*
    ;


// Predefined Symbols

PredefSymbols
    : PS_Not
    | PS_Bool
    | PS_ContinuedExecution
    | PS_Error
    | PS_False
    | PS_ImmediateExit
    | PS_Incomplete
    | PS_Logic
    | PS_Memout
    | PS_Sat
    | PS_Success
    | PS_Theory
    | PS_True
    | PS_Unknown
    | PS_Unsupported
    | PS_Unsat
    ;

PS_Not
    : 'not'
    ;
PS_Bool
    : 'Bool'
    ;
PS_ContinuedExecution
    : 'continued-execution'
    ;
PS_Error
    : 'error'
    ;
PS_False
    : 'false'
    ;
PS_ImmediateExit
    : 'immediate-exit'
    ;
PS_Incomplete
    : 'incomplete'
    ;
PS_Logic
    : 'logic'
    ;
PS_Memout
    : 'Memout'
    ;
PS_Sat
    : 'Sat'
    ;
PS_Success
    : 'Success'
    ;
PS_Theory
    : 'theory'
    ;
PS_True
    : 'true'
    ;
PS_Unknown
    : 'unknown'
    ;
PS_Unsupported
    : 'unsupported'
    ;
PS_Unsat
    : 'unsat'
    ;


// Predefined Keywords

fragment PredefKeywords
    : PK_AllStatistics
    | PK_AssertionStackLevels
    | PK_Authors
    | PK_Category
    | PK_Chainable
    | PK_Definition
    | PK_DiagnosticOutputChannel
    | PK_ErrorBehaviour
    | PK_Extension
    | PK_Funs
    | PK_FunsDescription
    | PK_GlobalDeclarations
    | PK_InteractiveMode
    | PK_Language
    | PK_LeftAssoc
    | PK_License
    | PK_Name
    | PK_Named
    | PK_Notes
    | PK_Pattern
    | PK_PrintSuccess
    | PK_ProduceAssertions
    | PK_ProduceAssignments
    | PK_ProduceModels
    | PK_ProduceProofs
    | PK_ProduceUnsatAssumptions
    | PK_ProduceUnsatCores
    | PK_RandomSeed
    | PK_ReasonUnknown
    | PK_RegularOutputChannel
    | PK_ReproducibleResourceLimit
    | PK_RightAssoc
    | PK_SmtLibVersion
    | PK_Sorts
    | PK_SortsDescription
    | PK_Source
    | PK_Status
    | PK_Theories
    | PK_Values
    | PK_Verbosity
    | PK_Version
    ;

PK_AllStatistics
    : ':all-statistics'
    ;
PK_AssertionStackLevels
    : ':assertion-stack-levels'
    ;
PK_Authors
    : ':authors'
    ;
PK_Category
    : ':category'
    ;
PK_Chainable
    : ':chainable'
    ;
PK_Definition
    : ':definition'
    ;
PK_DiagnosticOutputChannel
    : ':diagnostic-output-channel'
    ;
PK_ErrorBehaviour
    : ':error-behavior'
    ;
PK_Extension
    : ':extensions'
    ;
PK_Funs
    : ':funs'
    ;
PK_FunsDescription
    : ':funs-description'
    ;
PK_GlobalDeclarations
    : ':global-declarations'
    ;
PK_InteractiveMode
    : ':interactive-mode'
    ;
PK_Language
    : ':language'
    ;
PK_LeftAssoc
    : ':left-assoc'
    ;
PK_License
    : ':license'
    ;
PK_Name
    : ':name'
    ;
PK_Named
    : ':named'
    ;
PK_Notes
    : ':notes'
    ;
PK_Pattern
    : ':pattern'
    ;
PK_PrintSuccess
    : ':print-success'
    ;
PK_ProduceAssertions
    : ':produce-assertions'
    ;
PK_ProduceAssignments
    : ':produce-assignments'
    ;
PK_ProduceModels
    : ':produce-models'
    ;
PK_ProduceProofs
    : ':produce-proofs'
    ;
PK_ProduceUnsatAssumptions
    : ':produce-unsat-assumptions'
    ;
PK_ProduceUnsatCores
    : ':produce-unsat-cores'
    ;
PK_RandomSeed
    : ':random-seed'
    ;
PK_ReasonUnknown
    : ':reason-unknown'
    ;
PK_RegularOutputChannel
    : ':regular-output-channel'
    ;
PK_ReproducibleResourceLimit
    : ':reproducible-resource-limit'
    ;
PK_RightAssoc
    : ':right-assoc'
    ;
PK_SmtLibVersion
    : ':smt-lib-version'
    ;
PK_Sorts
    : ':sorts'
    ;
PK_SortsDescription
    : ':sorts-description'
    ;
PK_Source
    : ':source'
    ;
PK_Status
    : ':status'
    ;
PK_Theories
    : ':theories'
    ;
PK_Values
    : ':values'
    ;
PK_Verbosity
    : ':verbosity'
    ;
PK_Version
    : ':version'
    ;


Keyword
    : Colon SimpleSymbol
    ;


// RESERVED Words


// General reserved words

fragment GeneralReservedWords
    : GRW_Exclamation
    | GRW_Underscore
    | GRW_As
    | GRW_Binary
    | GRW_Decimal
    | GRW_Exists
    | GRW_Hexadecimal
    | GRW_Forall
    | GRW_Let
    | GRW_Match
    | GRW_Numeral
    | GRW_Par
    | GRW_String
    ;

GRW_Exclamation
    : '!'
    ;
GRW_Underscore
    : '_'
    ;
GRW_As
    : 'as'
    ;
GRW_Binary
    : 'BINARY'
    ;
GRW_Decimal
    : 'DECIMAL'
    ;
GRW_Exists
    : 'exists'
    ;
GRW_Hexadecimal
    : 'HEXADECIMAL'
    ;
GRW_Forall
    : 'forall'
    ;
GRW_Let
    : 'let'
    ;
GRW_Match
    : 'match'
    ;
GRW_Numeral
    : 'NUMERAL'
    ;
GRW_Par
    : 'par'
    ;
GRW_String
    : 'string'
    ;

fragment Colon
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



// Lexer Rules End

// Parser Rules Start

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
    : Keyword
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
    | ParOpen GRW_As identifier sort ParClose
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
    | ParOpen GRW_Let ParOpen var_binding+ ParClose term ParClose
    | ParOpen GRW_Forall ParOpen sorted_var+ ParClose term ParClose
    | ParOpen GRW_Exists ParOpen sorted_var+ ParClose term ParClose
    | ParOpen GRW_Match term ParOpen match_case+ ParClose ParClose
    | ParOpen GRW_Exclamation term attribute+ ParClose
    ;


// Theory Declarations

sort_symbol_decl
    : ParOpen identifier numeral attribute* ParClose;

meta_spec_constant
    : GRW_Numeral
    | GRW_Decimal
    | GRW_String
    ;

fun_symbol_decl
    : ParOpen spec_constant sort attribute* ParClose
    | ParOpen meta_spec_constant sort attribute* ParClose
    | ParOpen identifier sort+ attribute* ParClose
    ;

par_fun_symbol_decl
    : fun_symbol_decl
    | ParOpen GRW_Par ParOpen symbol+ ParClose ParOpen identifier sort+
    attribute* ParClose ParClose
    ;

theory_attribute
    : PK_Sorts ParOpen sort_symbol_decl+ ParClose
    | PK_Funs ParOpen par_fun_symbol_decl+ ParClose
    | PK_SortsDescription string
    | PK_FunsDescription string
    | PK_Definition string
    | PK_Values string
    | PK_Notes string
    | attribute
    ;

theory_decl
    : ParOpen PS_Theory symbol theory_attribute+ ParClose
    ;


// Logic Declarations

logic_attribue
    : PK_Theories ParOpen symbol+ ParClose
    | PK_Language string
    | PK_Extension string
    | PK_Values string
    | PK_Notes string
    | attribute
    ;

logic
    : ParOpen PS_Logic symbol logic_attribue+ ParClose
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
    | ParOpen GRW_Par ParOpen symbol+ ParClose ParOpen constructor_dec+
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
    | ParOpen PS_Not symbol ParClose
    ;


script
    : command*
    ;

command
    : ParOpen CMD_Assert term ParClose
    | ParOpen CMD_CheckSat ParClose
    | ParOpen CMD_CheckSatAssuming ParClose
    | ParOpen CMD_DeclareConst symbol sort ParClose
    | ParOpen CMD_DeclareDatatype symbol datatype_dec ParClose
    // cardinalitiees for sort_dec and datatype_dec have to be n+1
    | ParOpen CMD_DeclareDatatypes ParOpen sort_dec+ ParClose ParOpen
    datatype_dec+ ParClose ParClose
    | ParOpen CMD_DeclareFun symbol ParOpen sort* ParClose sort ParClose
    | ParOpen CMD_DeclareSort symbol numeral ParClose
    | ParOpen CMD_DefineFun function_def ParClose
    | ParOpen CMD_DefineFunRec function_def ParClose
    // cardinalitiees for function_dec and term have to be n+1
    | ParOpen CMD_DefineFunRec ParOpen function_dec+ ParClose
    ParOpen term+ ParClose ParClose
    | ParOpen CMD_DefineSort symbol ParOpen symbol* ParClose sort ParClose
    | ParOpen CMD_Echo string ParClose
    | ParOpen CMD_Exit ParClose
    | ParOpen CMD_GetAssertions ParClose
    | ParOpen CMD_GetAssignment ParClose
    | ParOpen CMD_GetInfo info_flag ParClose
    | ParOpen CMD_GetModel ParClose
    | ParOpen CMD_GetOption keyword ParClose
    | ParOpen CMD_GetProof ParClose
    | ParOpen CMD_GetUnsatAssumptions ParClose
    | ParOpen CMD_GetUnsatCore ParClose
    | ParOpen CMD_GetValue ParOpen term+ ParClose ParClose
    | ParOpen CMD_Pop numeral ParClose
    | ParOpen CMD_Push numeral ParClose
    | ParOpen CMD_Reset ParClose
    | ParOpen CMD_ResetAssertions ParClose
    | ParOpen CMD_SetInfo attribute ParClose
    | ParOpen CMD_SetLogic symbol ParClose
    | ParOpen CMD_SetOption option ParClose
    ;


b_value
    : PS_True
    | PS_False
    ;

option
    : PK_DiagnosticOutputChannel string
    | PK_GlobalDeclarations b_value
    | PK_InteractiveMode b_value
    | PK_PrintSuccess b_value
    | PK_ProduceAssertions b_value
    | PK_ProduceAssignments b_value
    | PK_ProduceModels b_value
    | PK_ProduceProofs b_value
    | PK_ProduceUnsatAssumptions b_value
    | PK_ProduceUnsatCores b_value
    | PK_RandomSeed numeral
    | PK_RegularOutputChannel string
    | PK_ReproducibleResourceLimit numeral
    | PK_Verbosity numeral
    | attribute
    ;

info_flag
    : PK_AllStatistics
    | PK_AssertionStackLevels
    | PK_Authors
    | PK_ErrorBehaviour
    | PK_Name
    | PK_ReasonUnknown
    | PK_Version
    | keyword
    ;

// responses

error_behaviour
    : PS_ImmediateExit
    | PS_ContinuedExecution
    ;

reason_unknown
    : PS_Memout
    | PS_Incomplete
    | s_expr
    ;

model_response
    : ParOpen CMD_DefineFun function_def ParClose
    | ParOpen CMD_DefineFunRec function_def ParClose
    // cardinalitiees for function_dec and term have to be n+1
    | ParOpen CMD_DefineFunsRec ParOpen function_dec+ ParClose ParOpen term+
    ParClose ParClose
    ;

info_response
    : PK_AssertionStackLevels numeral
    | PK_Authors string
    | PK_ErrorBehaviour error_behaviour
    | PK_Name string
    | PK_ReasonUnknown reason_unknown
    | PK_Version string
    | attribute
    ;

valuation_pair
    : ParOpen term term ParClose
    ;

t_valuation_pair
    : ParOpen symbol b_value ParClose
    ;

check_sat_response
    : PS_Sat
    | PS_Unsat
    | PS_Unknown
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
    : PS_Success
    | specific_success_response
    | PS_Unsupported
    | ParOpen PS_Error string ParClose
    ;


// Parser Rules End

Comment
    : ';' ~[\r\n]* -> channel(HIDDEN)
    ;

WS  :  [ \t\r\n]+ -> skip
    ;