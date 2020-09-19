//
//  Document.m
//  TahDoodle
//
//  Created by franklin smith on 9/19/20.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document

#pragma mark - NSDocument Overrides


#pragma mark - Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    // This table view displays the tasks arrya,
    // so the number of entries in the tableview will be the same
    // as the number of objects in the array
    return [self.tasks count];
}

- (id)tableView:(NSTableView *)tableView
objectVlaueForTableColumn:(NSTableColumn *) tableColumn
            row:(NSInteger)row{
    // return the item from tasks that corresponds to the cell
    // that the table view wants to display
    return [self.tasks objectAtIndex:row];
}

- (void)tableView:(NSTableView *)tableView
   setObjectVlaue:(id)object
   forTableColumn:(NSTableColumn *)tableColumn
              row:(NSInteger)row
{
    // When the user changes a task on teh table view,
    // update the tasks array
    [self.tasks replaceObjectAtIndex:row withObject:object];
    
    //and then flag the document as having unsaved changes.
    [self updateChangeCount:NSChangeDone];
}

#pragma mark - Actions

- (void)addTask:(id)sender{
    NSLog(@"Add Task button clicked!");
    // if there is no array yet, create one
    if (!self.tasks){
        self.tasks = [NSMutableArray array];
    }
    [self.tasks addObject:@"New Item"];
    
    // -reloadData tells the table view to refresh and ask its dataSource
    // (which happens to be this BNRDocument object in this case)
    // for new data to display
    [self.taskTable reloadData];
    // -updateChangeCount: tells the application whether or not the document
    // has unsaved changes NSChangeDone flags the document as unsaved
    [self updateChangeCount:NSChangeDone];

}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}



- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

//
//- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
//    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return nil.
//    // Alternatively, you could remove this method and override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
//    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
//    return nil;
//}


//- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
//    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error if you return NO.
//    // Alternatively, you could remove this method and override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
//    // If you do, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
//    [NSException raise:@"UnimplementedMethod" format:@"%@ is unimplemented", NSStringFromSelector(_cmd)];
//    return YES;
//}


#pragma mark - Saving and Loading Data

- (NSData *)dataOfType:(NSString *)typeName
                 error:(NSError **)outError
{
    // This method is called when oour document is being saved
    // you are expected to hand the caller an NSData object wrapping our data
    // so that it can be written to disk
    // if there is no array, write out an empty array
    if (!self.tasks){
        self.tasks = [NSMutableArray array];
    }
    // Pack the tasks array into an NSData object
    NSData *data = [NSPropertyListSerialization
                    dataWithPropertyList:self.tasks
                    format:NSPropertyListXMLFormat_v1_0
                    options:0
                    error:outError];
    
    // return the newly-packed NSData object
    return data;
}

-(BOOL)readFromData:(NSData *)data
             ofType:(NSString *)typeName
              error:(NSError **)outError
{
    // This method is called whena  document is being loaded
    // you are handed an NSData object and expected to pull our data out of it
    // extract the tasks
    self.tasks = [NSPropertyListSerialization
                  propertyListWithData:data
                  options:NSPropertyListMutableContainers
                  format:NULL
                  error:outError];
    // return success or failure depending on success of the above call
    return (self.tasks !=nil);
}

@end
