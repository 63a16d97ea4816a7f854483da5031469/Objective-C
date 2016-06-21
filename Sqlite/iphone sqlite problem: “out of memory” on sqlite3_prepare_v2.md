#iphone sqlite problem: “out of memory” on sqlite3_prepare_v2

http://stackoverflow.com/questions/693329/iphone-sqlite-problem-out-of-memory-on-sqlite3-prepare-v2



It is not a bug, the problem is you never open the database. For example:

if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)