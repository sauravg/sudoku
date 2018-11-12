csv2facts: csv2facts_cli
	
csv2facts_cli:
	gplc csv2facts_cli.pro csv2facts.pro --no-top-level

sudoku: sudoku.pro csv2facts.pro
	gplc sudoku.pro csv2facts.pro
