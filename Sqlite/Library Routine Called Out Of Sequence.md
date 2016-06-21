#“Library Routine Called Out Of Sequence” sqlite3_prepare_v2(CREATE TABLE)

http://stackoverflow.com/questions/8372871/library-routine-called-out-of-sequence-sqlite3-prepare-v2create-table

1. Calling any API routine with an sqlite3* pointer that was not obtained from sqlite3_open() or sqlite3_open16() or which has already been closed by sqlite3_close().  

2. Trying to use the same database connection at the same instant in time from two or more threads.

3. Calling sqlite3_step() with a sqlite3_stmt* statement pointer that was not obtained from sqlite3_prepare() or sqlite3_prepare16() or that has already been destroyed by sqlite3_finalize().

4. Trying to bind values to a statement (using sqlite3_bind_...()) while that statement is running.


