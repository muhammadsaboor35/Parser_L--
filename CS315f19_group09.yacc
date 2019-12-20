%{ int yylex(void); extern int yylineno; %}

%token COMMENT MAIN TRUE FALSE INT BOOL STRING CONN VOID FINAL IF ELSE FOR WHILE RETURN PUTS GETS LENGTH STR GET_STATE SWITCH_ON SWITCH_OFF SEND_DATA RECEIVE_DATA FORMAT_TIME FORMAT_TEMPERATURE FORMAT_HUMIDITY FORMAT_AIR_PRESSURE FORMAT_AIR_QUALITY FORMAT_LIGHT FORMAT_SOUND_LEVEL FORMAT_ULTRASONIC FORMAT_INFRARED FORMAT_GYRO_X FORMAT_GYRO_Y FORMAT_GYRO_Z FORMAT_SMOKE FORMAT_GPS_LONG FORMAT_GPS_LAT READ_TIME READ_TEMPERATURE READ_HUMIDITY READ_AIR_PRESSURE READ_AIR_QUALITY READ_LIGHT READ_SOUND_LEVEL READ_ULTRASONIC READ_INFRARED READ_GYRO_X READ_GYRO_Y READ_GYRO_Z READ_SMOKE READ_GPS_LONG READ_GPS_LAT BUILD_CONN CLOSE_CONN EXP_OP MULT_OP DIV_OP AND_OP OR_OP XOR_OP NOT_OP GT_OP LT_OP GTE_OP LTE_OP EQ_OP NEQ_OP SEMI_COLON DOT L_PARA R_PARA L_CURL R_CURL COMMA ASSIGN_OP INC_OP DEC_OP PLUS MINUS INTEGER VARIABLE STRING_LIT

%start entry_point

%%

entry_point: pre_main_statements VOID MAIN L_PARA R_PARA L_CURL program R_CURL post_main_statements { puts("Valid input\n"); return 0; };

pre_main_statements: empty | COMMENT pre_main_statements ;
 
post_main_statements: empty | COMMENT post_main_statements ;

program: empty | stmt_list ;

stmt_list: stmt | stmt_list stmt ;
 
stmt: matched_stmt | unmatched_stmt ;

matched_stmt: IF L_PARA expr R_PARA matched_stmt ELSE matched_stmt | non_if_stmt ;

non_if_stmt: COMMENT | block | empty SEMI_COLON | assign_stmt | func_def | for_stmt| while_stmt| void_func_call ;

unmatched_stmt: IF L_PARA expr R_PARA stmt | IF L_PARA expr R_PARA matched_stmt ELSE unmatched_stmt ;

empty: ;
 
block: L_CURL program R_CURL ;

assign_stmt: simple_assign | final_assign | conn_assign | conn_decl_assign ;

simple_assign: decl_assign | assign ;

decl_assign: data_type VARIABLE ASSIGN_OP expr SEMI_COLON ;

final_assign: FINAL data_type VARIABLE ASSIGN_OP literal SEMI_COLON ;

assign: VARIABLE ASSIGN_OP expr SEMI_COLON | VARIABLE INC_OP SEMI_COLON | VARIABLE DEC_OP SEMI_COLON ;
 
update_stmt: VARIABLE ASSIGN_OP expr | VARIABLE INC_OP | VARIABLE DEC_OP ;

conn_decl_assign: CONN VARIABLE ASSIGN_OP conn_expr SEMI_COLON ;

conn_assign: VARIABLE ASSIGN_OP conn_expr SEMI_COLON ;

literal: bool_lit | INTEGER | STRING_LIT ;

bool_lit: TRUE | FALSE ;

data_type: INT | BOOL | STRING ;

expr: non_comp_expr | comp_expr ;

non_comp_expr: non_comp_expr OR_OP xor_expr | xor_expr ;

xor_expr: xor_expr XOR_OP and_expr | and_expr ;

and_expr: and_expr AND_OP add_expr | add_expr ;

add_expr: add_expr PLUS mult_expr | add_expr MINUS mult_expr | mult_expr ;

mult_expr: mult_expr MULT_OP exp_expr | mult_expr DIV_OP exp_expr | exp_expr ;

exp_expr: exp_expr EXP_OP un_expr | un_expr ;

un_expr: para_expr INC_OP | para_expr DEC_OP | PLUS para_expr | MINUS para_expr | NOT_OP para_expr | para_expr ;

para_expr: L_PARA non_comp_expr R_PARA | sim_expr ;
 
sim_expr: VARIABLE | literal | func_ret | func_prim_ret ;

func_prim_ret: bool_prim_ret | int_prim_ret | string_prim_ret ;
 
bool_prim_ret: GET_STATE L_PARA non_comp_expr R_PARA ;

int_prim_ret: READ_TEMPERATURE L_PARA non_comp_expr R_PARA | READ_HUMIDITY L_PARA non_comp_expr R_PARA | READ_AIR_PRESSURE L_PARA non_comp_expr R_PARA | READ_AIR_QUALITY L_PARA non_comp_expr R_PARA | READ_LIGHT L_PARA non_comp_expr R_PARA | READ_SOUND_LEVEL L_PARA non_comp_expr COMMA non_comp_expr R_PARA | READ_ULTRASONIC L_PARA non_comp_expr R_PARA | READ_INFRARED L_PARA non_comp_expr R_PARA | READ_GYRO_X L_PARA non_comp_expr R_PARA | READ_GYRO_Y L_PARA non_comp_expr R_PARA | READ_GYRO_Z L_PARA non_comp_expr R_PARA | READ_SMOKE L_PARA non_comp_expr R_PARA | READ_GPS_LONG L_PARA non_comp_expr R_PARA | READ_GPS_LAT L_PARA non_comp_expr R_PARA | READ_TIME L_PARA R_PARA | LENGTH L_PARA non_comp_expr R_PARA | VARIABLE DOT RECEIVE_DATA L_PARA R_PARA ;

string_prim_ret: FORMAT_TIME L_PARA non_comp_expr R_PARA | STR L_PARA non_comp_expr R_PARA | FORMAT_TEMPERATURE L_PARA non_comp_expr R_PARA | FORMAT_HUMIDITY 
L_PARA non_comp_expr R_PARA | FORMAT_AIR_PRESSURE L_PARA non_comp_expr R_PARA | FORMAT_AIR_QUALITY L_PARA non_comp_expr R_PARA | FORMAT_LIGHT L_PARA non_comp_expr R_PARA | FORMAT_SOUND_LEVEL L_PARA non_comp_expr R_PARA | FORMAT_ULTRASONIC L_PARA 
non_comp_expr R_PARA | FORMAT_INFRARED L_PARA non_comp_expr R_PARA | FORMAT_GYRO_X L_PARA non_comp_expr R_PARA | FORMAT_GYRO_Y L_PARA non_comp_expr R_PARA | FORMAT_GYRO_Z L_PARA non_comp_expr R_PARA | FORMAT_SMOKE L_PARA non_comp_expr R_PARA | FORMAT_GPS_LONG L_PARA non_comp_expr R_PARA | FORMAT_GPS_LAT L_PARA non_comp_expr R_PARA ;

comp_expr: non_comp_expr EQ_OP non_comp_expr | non_comp_expr NEQ_OP non_comp_expr | non_comp_expr GTE_OP non_comp_expr | non_comp_expr LTE_OP non_comp_expr | non_comp_expr LT_OP non_comp_expr | non_comp_expr GT_OP non_comp_expr | L_PARA comp_expr R_PARA ;

void_func_call: func_ret SEMI_COLON | void_prim_ret ;

void_prim_ret: PUTS L_PARA non_comp_expr R_PARA SEMI_COLON | GETS L_PARA VARIABLE R_PARA SEMI_COLON | VARIABLE DOT SEND_DATA L_PARA non_comp_expr R_PARA SEMI_COLON | SWITCH_ON L_PARA non_comp_expr R_PARA SEMI_COLON | SWITCH_OFF L_PARA non_comp_expr R_PARA SEMI_COLON | VARIABLE DOT CLOSE_CONN L_PARA R_PARA SEMI_COLON ;

conn_expr: BUILD_CONN L_PARA VARIABLE R_PARA | BUILD_CONN L_PARA non_comp_expr COMMA non_comp_expr R_PARA ;

func_ret: VARIABLE L_PARA param_call_list R_PARA | VARIABLE L_PARA empty R_PARA ;

param_call_list: param_call | param_call_list COMMA param_call ;

param_call: non_comp_expr ;

func_def: func_data_type | func_void ;

func_data_type: data_type VARIABLE L_PARA param_list R_PARA L_CURL program return_stmt R_CURL | data_type VARIABLE L_PARA empty R_PARA L_CURL program return_stmt R_CURL ;

return_stmt: RETURN expr SEMI_COLON ;

func_void: VOID VARIABLE L_PARA param_list R_PARA L_CURL program R_CURL | VOID VARIABLE L_PARA empty R_PARA L_CURL program R_CURL ;

param_list: param | param_list COMMA param ;

param: data_type VARIABLE ;

for_stmt: FOR L_PARA simple_assign expr SEMI_COLON update_stmt R_PARA block ;

while_stmt: WHILE L_PARA expr R_PARA block ;

%%
#include "lex.yy.c"
int yyerror(char* s){
  fprintf(stderr, "%s at line %d\n",s, yylineno);
  return 1;
}
int main(){
 yyparse();
 return 0;
}