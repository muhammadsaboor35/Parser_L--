main: lex yacc parse

parse: y.tab.c
	gcc -o parser y.tab.c

yacc: CS315f19_group09.yacc lex.yy.c
	yacc CS315f19_group09.yacc

lex: CS315f19_group09.lex
	lex CS315f19_group09.lex
