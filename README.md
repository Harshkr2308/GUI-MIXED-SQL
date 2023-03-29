# GUI-MIXED-SQL
This Project takes input as normal english command and converts it to SQL Query using LALR technique from lex files. Further it takes the Query and displays the updated table. The project is integrated with GUI.
Important Notes:

Create a database with table 'student' having four entities as id,name,roll,cpi.

Take the cpi datatype as 'decimal(10,2)'.

Running the project:

flex file.l

bison -d file.y

gcc lex.yy.c file.tab.c 

npm install

node compilers.js

Run the commands in specific syntax given in 'test.txt'.
