//
//  ReaderViewController.m
//  HandyBook
//
//  Created by User on 4/17/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "ReaderViewController.h"
#import "TextViewController.h"


@interface ReaderViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *checkSwitch;
@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageVC = [[self childViewControllers] objectAtIndex:0];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    self.checkSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"checkStatus"];
    
    
    
    [self.pageVC setViewControllers:[NSArray arrayWithObject:[self newVCAtPage:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    }
- (IBAction)switchAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:self.checkSwitch.on forKey:@"checkStatus"];
}

- (textViewController *)newVCAtPage:(NSInteger)page {
    textViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"textVC"];
    vc.checkIsOn = self.checkSwitch.on;
    vc.pageNumber = page;
    return vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(textViewController *)viewController pageNumber];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self newVCAtPage:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(textViewController *)viewController pageNumber];
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self newVCAtPage:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
