#[Sqlite] Database crash issue at the time of retriving data

http://stackoverflow.com/questions/14618991/database-crash-issue-at-the-time-of-retriving-data


This is being caused by trying to create a NSString object with a NULL string. It is on one of these lines:

	[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, ...)];
So, before you create a NSString with the results of the sql statement you need to check for NULL like this:

	char *tmp = sqlite3_column_text(statement, 1);
	if (tmp == NULL)
	    strRestaurantName = nil;
	else
	    strRestaurantName = [[NSString alloc] initWithUTF8String:tmp];
	 