#Sqlite -learning


http://www.techonthenet.com/sqlite/tables/alter_table.php




Drop column in table

You can not use the ALTER TABLE statement to drop a column in a table. Instead you will need to rename the table, create a new table, and copy the data into the new table.

Syntax
The syntax to DROP A COLUMN in a table in SQLite is:
	
	PRAGMA foreign_keys=off;
	
	BEGIN TRANSACTION;
	
	ALTER TABLE table1 RENAME TO _table1_old;
	
	CREATE TABLE table1 (
	( column1 datatype [ NULL | NOT NULL ],
	  column2 datatype [ NULL | NOT NULL ],
	  ...
	);
	
	INSERT INTO table1 (column1, column2)
	  SELECT column1, column2
	  FROM _table1_old;
	
	COMMIT;
	
	PRAGMA foreign_keys=on;
