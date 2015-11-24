# TableView Practice

**Developed by Tony Cao**

TableView is a common thing in IOS. 

In order to have solid programming skills, I created this folder to
practise the basic programming skill about creating TableView from zero.

>All the practice will be recorded in this folder.


 1. Create the UITableView by using storyboard
 2. Modify the root control(by moving the arrow)
 3. Modify the ViewController.h to UITableViewController
 4. Linked the MainStoryboard TableView to the file(ViewController)
 5. Create the CustomTableCell.h and CustomTableCell.m.
 6. Fill in the content of the CustomTableCell.h and CustomTableCell.m
 7. Linked the mainStoryboard TableViewCell to the file(CustomTableCell)
 8. Add one UILabel into the TableViewCell by using Storyboard.
 9. Create the Outlet of UILabel to the file(CustomTableCell.h)
 10. Modify the Identifier of TableViewCell to "cell";
 11. Modify the code of ViewController to add two required methods:
 numberOfRowsInSection
 cellForRowAtIndexPath
 ---> Consider the cell==nil situation.
 To use the dequeueReusableCellWithIdentifier:@"cell"  

 