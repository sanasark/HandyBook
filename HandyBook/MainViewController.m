//
//  MainViewController.m
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "MainViewController.h"
#import "YandexTranslateManager.h"
#import "ContainerXMLParser.h"
#import "BookCollectionViewCell.h"
#import "AppDelegate.h"
#import "Book.h"
#import "TextManager.h"
@interface MainViewController () <UIAdaptivePresentationControllerDelegate , UIPopoverPresentationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *booksCollectionView;

@property NSArray *books;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(reloadBooks)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    [[YandexTranslateManager sharedManager] translateText:@"Hello" toLanguage:@"fr" completionHandler:^(NSString *translation, NSError *error) {
        
        NSLog(@"%@",translation);
        self.booksCollectionView.dataSource = self;
        self.booksCollectionView.delegate = self;
    }];
}

-(void)reloadBooks {
    [self.booksCollectionView reloadData];
}

- (IBAction)goToMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToDictionary:(id)sender {
    MainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Dictionary"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqualToString:@"pop"]) {
        UIViewController *popover = segue.destinationViewController;
        popover.modalPresentationStyle = UIModalPresentationPopover;
        popover.popoverPresentationController.delegate = self;
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}


- (NSArray *)fetchBooks {
    NSManagedObjectContext *context = [[UIApplication appDelegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityNameBook];
    return [context executeFetchRequest:fetchRequest error:nil];
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //UICollectionViewCell *bookCell =[collectionView cellForItemAtIndexPath:indexPath];
    NSInteger selectedBookIndex = [indexPath item];
    Book *currentBook = self.books[selectedBookIndex];
    
    [UIApplication appDelegate].currentBook = currentBook;
    [TextManager sharedManager].epubText = currentBook.bookContent;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"BookCell";
    BookCollectionViewCell *bookCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier
                                                                                        forIndexPath:indexPath];
    
    NSInteger currentBookIndex = [indexPath item];
    Book *currentBook = self.books[currentBookIndex];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *coverImagePath = [documentsDirectory stringByAppendingFormat:@"/%@", currentBook.coverImagePath];
    NSLog(@"%@", coverImagePath);
    [bookCell.coverImage setImage:[UIImage imageNamed:coverImagePath]];
    return bookCell;
}

#pragma mark - CollecTionViewNavigation
- (NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    
    self.books = [self fetchBooks];
    NSInteger booksCount = [self.books count];
    return booksCount;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}





@end
