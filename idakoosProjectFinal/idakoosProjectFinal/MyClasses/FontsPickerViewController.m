//
//  FontsPickerViewController.m
//  idakoosProjectFinal
//
//  Created by Ricardo Herrera Valle on 5/06/13.
//  Copyright (c) 2013 Idakoos. All rights reserved.
//

#import "FontsPickerViewController.h"

@interface FontsPickerViewController ()

@end

@implementation FontsPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        //initialize path
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DetailsProduct" ofType:@"plist"];
        NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:path];
        
        //Set up the array of colors.
        _arrayFonts = [[NSMutableArray alloc] initWithArray:[root objectForKey:@"TextFont"]];
        
        //Make row selections persist.
        self.clearsSelectionOnViewWillAppear = NO;
        
        //Calculate how tall the view should be by multiplying
        //the individual row height by the total number of rows.
        NSInteger rowsCount = [_arrayFonts count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        //Calculate how wide the view should be by finding how
        //wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (NSString *sizeName in _arrayFonts) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [sizeName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        //Add a little padding to the width
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        //Set the property to tell the popover container how big this view will be.
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    
    _arrayFonts = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_arrayFonts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *fontName = [_arrayFonts objectAtIndex:indexPath.row];
    cell.textLabel.text = [fontName substringToIndex:fontName.length-4];
    cell.textLabel.font = [UIFont fontWithName:[fontName substringToIndex:fontName.length-4] size:20.0f];
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate != nil) {
        [_delegate SelectedFont:[_arrayFonts objectAtIndex:indexPath.row]];
    }
}

@end
