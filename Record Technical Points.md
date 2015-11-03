## Record Technical Points



###NSAttributedString 详解                                              
                                                                           
http://blog.csdn.net/zhangao0086/article/details/7616385

	//把this的字体颜色变为红色  
	[attriString addAttribute:(NSString *)kCTForegroundColorAttributeName  
	                    value:(id)[UIColor redColor].CGColor   
	                    range:NSMakeRange(0, 4)];  
	//把is变为黄色  
	[attriString addAttribute:(NSString *)kCTForegroundColorAttributeName  
	                    value:(id)[UIColor yellowColor].CGColor   
	                    range:NSMakeRange(5, 2)];  
	//改变this的字体，value必须是一个CTFontRef  
	[attriString addAttribute:(NSString *)kCTFontAttributeName  
	                    value:(id)CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,  
	                                                   14,   
	                                                   NULL)  
	                    range:NSMakeRange(0, 4)];  
	//给this加上下划线，value可以在指定的枚举中选择  
	[attriString addAttribute:(NSString *)kCTUnderlineStyleAttributeName  
	                    value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble]  
	                    range:NSMakeRange(0, 4)];  
	return attriString;  
	
	
In the real app:
	
		 NSMutableAttributedString* AppTimeAttr;

	     AppTimeAttr = [[NSMutableAttributedString alloc] initWithString:AppTimeString];
        [AppTimeAttr addAttribute:NSForegroundColorAttributeName
                                 value:COLOR_BUTTON_YELLOW
                                 range:NSMakeRange(0, AppTime.length)];
        [AppTimeAttr addAttribute:NSForegroundColorAttributeName
                                 value:COLOR_APP_GRAY
                                 range:NSMakeRange(AppTime.length+1, [[LocaleHelper getLocalizedStringWithKey:STR_KEY_to] length])];

        [header.AppTime setAttributedText:AppTimeAttr];
	



### Scroll to specific row---> scrollToRowAtIndexPath
 

            [banner setText:[[LocaleHelper getLocalizedStringWithKey:STR_KEY_text_tap_to_check_products] uppercaseString]];

            if (productsCount > 0) {
            UILabel *banner = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 50.0)];
            [banner setBackgroundColor:COLOR_BUTTON_YELLOW];
            [banner setFont:[UIFont fontWithName:[FontHelper getDefaultFontForCurrentLocale] size:19]];
            [banner setTextAlignment:NSTextAlignmentCenter];
            [banner setTextColor:COLOR_APP_TEXT_PRIMARY_BUTTON];
            [banner setText:[[LocaleHelper getLocalizedStringWithKey:STR_KEY_text_tap_to_check_products] uppercaseString]];
            [banner setNumberOfLines:1];
            [banner setUserInteractionEnabled:YES];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToproductsSection:)];
            [recognizer setNumberOfTapsRequired:1];
            [banner addGestureRecognizer:recognizer];
            [header addSubview:banner];
            CGRect rect = title.frame;
            rect.origin.y += 50.0;
            [title setFrame:rect];
        }

\#define ITEMS_SECTION    (1)

	- (void)scrollToproductsSection:(UITapGestureRecognizer *)recognizer
	{
	    UITableView *mTableView = (UITableView*)[self.view viewWithTag:100];
	    [mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:ITEMS_SECTION] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}


Check the definition of this function:

	NS_CLASS_AVAILABLE_IOS(2_0) @interface UITableView : UIScrollView <NSCoding>

	- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;



















