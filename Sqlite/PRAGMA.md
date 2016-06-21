#PRAGMA      SQLite


    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir=dirPaths[0];
    databasePath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"userprofile.db"]];

##show table info
	+(NSMutableArray*)tableInfo:(NSString *)table{
	    
	   sqlite3_stmt *sqlStatement;
    
    NSMutableArray *result = [NSMutableArray array];
    
    const char *sql = [[NSString stringWithFormat:@"PRAGMA table_info('%@')",table] UTF8String];
    
    NSLog(@"the alter column!");
    const char *dbpath=[databasePath UTF8String];
    if (sqlite3_open(dbpath, &db)==SQLITE_OK)
    {
    
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        
    {
        NSLog(@"Problem with prepare statement tableInfo %@",
              [NSString stringWithUTF8String:(const char *)sqlite3_errmsg(db)]);
        
    }
    
    while (sqlite3_step(sqlStatement)==SQLITE_ROW)
    {
        [result addObject:
         [NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 1)]];
    }
    
    }
    return result;
    }

##whetherContainSpeficField

	+(BOOL)whetherContainSpeficField:(NSString *)table FieldName:(NSString*)fieldName{
	    
	   sqlite3_stmt *sqlStatement;
    
    NSMutableArray *result = [NSMutableArray array];
    
    const char *sql = [[NSString stringWithFormat:@"PRAGMA table_info('%@')",table] UTF8String];
    
    const char *dbpath=[databasePath UTF8String];
    if (sqlite3_open(dbpath, &db)==SQLITE_OK)
    {
    
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        
    {
        NSLog(@"Problem with prepare statement tableInfo %@",
              [NSString stringWithUTF8String:(const char *)sqlite3_errmsg(db)]);
        
    }
    
    while (sqlite3_step(sqlStatement)==SQLITE_ROW)
    {
        [result addObject:
         [NSString stringWithUTF8String:(char*)sqlite3_column_text(sqlStatement, 1)]];
    }
    }
    return [result containsObject:fieldName];

	
##Drop Table:

	-(BOOL)dropTable
	{
	    NSLog(@"the drop column!");
	    const char *dbpath=[databasePath UTF8String];
	    if (sqlite3_open(dbpath, &db)==SQLITE_OK)
	    {
	        NSString *deleteSQL=@"DROP TABLE userDetail";
	        const char *delete_stmt=[deleteSQL UTF8String];
	        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL);
	        if (sqlite3_step(statement)==SQLITE_DONE)
	        {
	            NSLog(@"drop success");
	            sqlite3_reset(statement);
	            return YES;
	        }
	        else
	        {
	            NSLog(@"drop not success");
	            sqlite3_reset(statement);
	            return NO;
	        }
	    }
	    return NO;
	}


##Alter Table to Add Column for table:
	-(BOOL)alterDB
	{
	 
	    NSLog(@"the drop column!");
	    const char *dbpath=[databasePath UTF8String];
	    if (sqlite3_open(dbpath, &db)==SQLITE_OK)
	    {
	        NSString *deleteSQL=@"ALTER TABLE userDetail ADD COLUMN employer TEXT";
	        const char *delete_stmt=[deleteSQL UTF8String];
	        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL);
	        if (sqlite3_step(statement)==SQLITE_DONE)
	        {
	            NSLog(@"drop success");
	            sqlite3_reset(statement);
	            return YES;
	        }
	        else
	        {
	            NSLog(@"drop not success");
	            sqlite3_reset(statement);
	            return NO;
	        }
	    }
	    return NO;
	}
