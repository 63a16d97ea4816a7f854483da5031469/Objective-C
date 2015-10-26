# NSUserDefaults standardUserDefaults

**Developed by Tony (Cao Lei)**

* This project is used to test the basic function of NSUserDefaults.

* Tried to load specific plist file's values in project.

##Where you can find the value you saved by using NSUserDefaults:

You can find the pList file for your app in the simulator if you go to:

/users/your user name/Library/Application Support/iPhone Simulator/<Sim Version>/Applications

This directory has a bunch of GUID named directories. If you are working on a few apps there will be a few of them. So you need to find your app binary:

find . -name foo.app
./1BAB4C83-8E7E-4671-AC36-6043F8A9BFA7/foo.app
Then go to the Library/Preferences directory in the GUID directory. So:

cd 1BAB4C83-8E7E-4671-AC35-6043F8A9BFA7/Library/Preferences
You should find a file that looks like:

<Bundle Identifier>.foo.pList
Open this up in the pList editor and browse persisted values to your heart's content.


####Recommand practising in person from zero to create project:  
> http://code.tutsplus.com/tutorials/ios-sdk-working-with-nsuserdefaults--mobile-6039

**How to save your own defined objects into the NSDefault:**  
> http://my.oschina.net/u/1245365/blog/294449

* The code to retrieve all attributes of a class is taken from http://stackoverflow.com/questions/754824/get-an-object-attributes-list-in-objective-c/13000074#13000074

#####Find a helper written by another person in GitHub:
https://github.com/roomorama/RMMapper

**Found one issue:**  
 If we use below code:  
 
 	@property(nonatomic,weak) NSString *name;  
 	@property(nonatomic,weak) NSString *gender;  
 	@property(nonatomic,weak) NSNumber *number;  
 
 You can only get the nil for NSString. You still can get the NSNumber.  
 */  
>**You need to modify the weak to retain or strong like below:**
>
	@property(nonatomic,retain) NSString *name;
	@property(nonatomic,retain) NSString *gender;
	@property(nonatomic,retain) NSNumber *number;  
>
>Or  
>
	@property(nonatomic,strong) NSString *name;
	@property(nonatomic,strong) NSString *gender;
	@property(nonatomic,strong) NSNumber *number;  
>Then you can get all the values you saved before.



>Some description about the retain,copy and release:

>* copy Makes a copy of an object, and returns it with retain count of 1. If you copy an object, you own the copy. This applies to any method that contains the word copy where “copy” refers to the object being returned.

>* retain Increases the retain count of an object by 1. Takes ownership of an object.

>* release Decreases the retain count of an object by 1. Relinquishes ownership of an object.
>

##Warnning:
* First of all it should only be used for very small amounts of data, such as settings. 
* And secondly it always returns immutable objects, even if you set mutable ones. Making a mutable copy of your first array doesn’t help because only the array will be mutable. Everything that is inside that array isn’t touched by the mutableCopy method and stay immutable.

* if you have to save so much data, you should use the NSPropertyListSerialization class to read and write your data from a file. On reading you can pass options controlling the mutability of the read objects. There you will want to pass NSPropertyListMutableContainers or NSPropertyListMutableContainersAndLeaves.


###NSUserDefaults standardUserDefaults的使用  
>存储数据简单的说有三种方式：数据库、NSUserDefaults和文件。
NSUserDefaults用于存储数据量小的数据，例如用户配置。并不是所有的东西都能往里放的，只支持：NSString,NSNumber, NSDate, NSArray, NSDictionary，详细方法可以查看类文件。

> NSUserDefaults是一个单例，在整个程序中只有一个实例对象，他可以用于数据的永久保存，而且简单实用，这是它可以让数据自由传递的一个前提，也是大家喜欢用它保存简单数据的一个主要原因。     
> 
> 值得注意的是：
NSUserDefaults 存储的对象全是不可变的（这一点非常关键，弄错的话程序会出bug），例如，如果我想要存储一个 NSMutableArray 对象，我必须先创建一个不可变数组（NSArray）再将它存入NSUserDefaults中去