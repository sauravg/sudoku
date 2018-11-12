csv2facts: csv2facts_cli.pro csv2facts.pro 
	gplc --no-top-level -o csv2facts $^

sudoku: sudoku.pro csv2facts.pro sudoku_io.pro sudoku_misc.pro
	gplc --no-top-level -o sudoku $^

csv2grid: csv2facts.pro sudoku_io.pro csv2grid.pro sudoku_misc.pro
	gplc --no-top-level -o csv2grid $^
