//
//  Document.h
//  TahDoodle
//
//  Created by franklin smith on 9/19/20.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
    <NSTableViewDataSource>

@property (nonatomic) NSMutableArray *tasks;

@property (nonatomic) IBOutlet NSTableView *taskTable;

- (IBAction)addTask:(id)sender;


@end

