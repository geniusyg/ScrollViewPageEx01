//
//  ViewController.m
//  ScrollViewPageEx01
//
//  Created by yg on 14. 1. 9..
//  Copyright (c) 2014년 yg. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_NUM 5

@interface ViewController () {
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
    int loadedPageCount;
}

@end

@implementation ViewController

- (void)loadContentsPage:(int)pageNo {
    if(pageNo < 0 || pageNo < loadedPageCount || pageNo >= IMAGE_NUM)
        return;
    
    float w = _scrollView.frame.size.width;
    float h =_scrollView.frame.size.height;
    
    NSString *fileName = [NSString stringWithFormat:@"image%d",pageNo];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    
    iv.frame = CGRectMake(w*pageNo, 0, w,h);
    [_scrollView addSubview:iv];
    loadedPageCount++;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float w = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNo = floor(offsetX/w);
    pageControl.currentPage = pageNo;
    
    [self loadContentsPage:pageNo-1];
    [self loadContentsPage:pageNo];
    [self loadContentsPage:pageNo+1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	_scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:_scrollView];
	
	float w = _scrollView.bounds.size.width;
	float h	= _scrollView.bounds.size.height;
	
	_scrollView.delegate = self;
	_scrollView.pagingEnabled = YES;
	_scrollView.contentSize = CGSizeMake(w*IMAGE_NUM, h);
	
	pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(130, 400, 60, 40)];
	[self.view addSubview:pageControl];
	pageControl.numberOfPages = IMAGE_NUM;
	
	loadedPageCount = 0;
	[self loadContentsPage:0];
	[self loadContentsPage:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end








































