# sudoku
A sudoku implementation in Prolog

This requireys GNU Prolog to build/run. It may work with others, but I haven't tested.

Use the Makefile to build the `sudoku` target. And run it like this

`./sudoku < tests/1`

It reads the sudoku input from STDIN. Doesn't deal with command-line args.

The format of input files in `test` directory should be pretty self-explanatory. Note that there should be a `space` char
after the last comma if the last cell in a row is blank.

Input parsing is quite unforgiving. Use the Makefile to generate the `csv2grid` target and run your input through it:

`./csv2grid < tests/1`

This will print the csv in a grid-like format, which is useful to visually check if your input is correct. Input is NOT validated. A wrong value in a cell would produce an error message or a wrong output.

The `csv2facts` tool converts the csv input into a set of Prolog facts that represent the input grid. Its just a leftover artifact and should be ignored.

Comments/suggestions/Bug reports/PR welcome.
