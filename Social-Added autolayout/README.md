# Social-Added autolayout
**Developed by Tony Cao**

This app is for practising the auto layout and basic programming
skills. I tried to ‘copy’ all the functions from an existing app.

I used auto layout in this app's UI.

**Most of them are auto layout issues.**

 >Used some useful auto layout skills:
 
 1. Center X.  
 2. Set the distance to boarder to 0.  
 3. Three buttons have same width(Equal Width) and   the distance between them is 0(Horizontal space).  
 4. Two components' Vertical space to 0  
 5. Two components' Horizontal space to 0  
 


>Used CALayer to draw line:

    CALayer* layer=[self.headerBackgroundLabel layer];
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorder.borderWidth = 1;



>Draw buttons' border:
    
    [cell.button1.layer setBorderWidth:1.0];
    [cell.button1.layer setBorderColor:		 [COLOR_BUTTON_BOARDER CGColor]];



>Added OverLay Button

Users can rotate the screen to use this app.


