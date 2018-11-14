#
# Copyright (C) 2018 Saurav Ghosh <sauravg@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
csv2facts: csv2facts_cli.pro csv2facts.pro 
	gplc --no-top-level -o csv2facts $^

sudoku: sudoku.pro csv2facts.pro sudoku_io.pro sudoku_misc.pro
	gplc --no-top-level -o sudoku $^

csv2grid: csv2facts.pro sudoku_io.pro csv2grid.pro sudoku_misc.pro
	gplc --no-top-level -o csv2grid $^
