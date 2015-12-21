##JSONKit

https://github.com/johnezang/JSONKit





	NSString Interface
	
	- (id)objectFromJSONString;
	- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
	- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;
	- (id)mutableObjectFromJSONString;
	- (id)mutableObjectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
	- (id)mutableObjectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;
	NSData Interface
	
	- (id)objectFromJSONData;
	- (id)objectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
	- (id)objectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;
	- (id)mutableObjectFromJSONData;
	- (id)mutableObjectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
	- (id)mutableObjectFromJSONDataWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;