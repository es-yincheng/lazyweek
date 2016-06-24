//
//  GuidViewController.m
//  lazyweek
//
//  Created by 尹成 on 16/6/23.
//  Copyright © 2016年 尹成. All rights reserved.
//

#import "GuidViewController.h"

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionUnknown,
    DirectionLeft,
    DirectionRight
};

#define MinTickleSpacing 20.0
#define MaxTickleCount 3
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface GuidViewController ()<UIScrollViewDelegate>{
    float previousTouchPoint;
    UIPageControl *pageControl;
    BOOL didEndAnimate;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidth;
@property (weak, nonatomic  ) IBOutlet UILabel            *imageTitle;
@property (weak, nonatomic  ) IBOutlet UIButton           *weiboLogin;
@property (weak, nonatomic  ) IBOutlet UIButton           *webchatLogin;
@property (weak, nonatomic  ) IBOutlet UIButton           *delayLogin;









@property (nonatomic, strong) UIImage        *currentImage;
//@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger      currentPage;

@property (assign, nonatomic) NSUInteger tickleCount; //挠痒次数
@property (assign, nonatomic) CGPoint currentTickleStart; //当前挠痒开始坐标位置
@property (assign, nonatomic) Direction lastDirection; //最后一次挠痒方向

@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int x = 1; x < 5; x ++) {
        [self.imageArray addObject:[NSString stringWithFormat:@"%d",x]];
    }
    
    [self setScrollView];
}

- (void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - custom
//- (void)setImageArray:(NSMutableArray *)imageArray{
//    self.imageArray = imageArray;
//    [self setScrollView];
//}

- (void)startAnimatingScrl
{
    if (self.imageArray.count) {
        [self.scrollView scrollRectToVisible:CGRectMake(((pageControl.currentPage +1)%_imageArray.count)*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
        [pageControl setCurrentPage:((pageControl.currentPage +1)%_imageArray.count)];
        [self performSelector:@selector(startAnimatingScrl) withObject:nil  afterDelay:1.5];
    }
}
-(void) cancelScrollAnimation{
    didEndAnimate =YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimatingScrl) object:nil];
}


#pragma mark - delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self cancelScrollAnimation];
    previousTouchPoint = scrollView.contentOffset.x;
}

- (IBAction)pgCntlChanged:(UIPageControl *)sender {
    [_scrollView scrollRectToVisible:CGRectMake(sender.currentPage*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    [self cancelScrollAnimation];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [pageControl setCurrentPage:_scrollView.bounds.origin.x/_scrollView.frame.size.width];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    int page = floor((scrollView.contentOffset.x - ScreenWidth) / ScreenWidth) + 1;
    
    
    NSLog(@"page:%d",page);
    
    
    float OldMin = ScreenWidth * page;
    int Value = scrollView.contentOffset.x -OldMin;
    float alpha = (Value % (int)ScreenWidth) / ScreenWidth;
    
    
    if (previousTouchPoint > scrollView.contentOffset.x)
        page = page+2;
    else
        page = page+1;
    
    
    NSLog(@"page2:%d",page);
    
    UIView *nextPage = [scrollView.superview viewWithTag:page+1];
    UIView *previousPage = [scrollView.superview viewWithTag:page-1];
    UIView *currentPage = [scrollView.superview viewWithTag:page];
    
    if(previousTouchPoint <= scrollView.contentOffset.x){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = 1-alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = alpha;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 0;
    }else if(page != 0){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = 0;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 1-alpha;
    }
    
    if (!didEndAnimate && pageControl.currentPage == 0) {
        for (UIView * imageView in self.scrollView.subviews){
            if (imageView.tag !=1 && [imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 0;
            else if([imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 1 ;
        }
    }
    
}

#pragma mark - lazy
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (UIImage *)currentImage {
    
//    self.currentPage = ++self.currentPage % self.imageArray.count;
    self.currentPage = 1;
    NSLog(@"图片：%@,%@",self.imageArray,[self.imageArray objectAtIndex:self.currentPage]);
    return [UIImage imageNamed:[self.imageArray objectAtIndex:self.currentPage]];
}

- (void)setScrollView{
    
//    self.scrollViewWidth.constant = ScreenWidth*self.imageArray.count;

    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.imageArray.count,0);

    self.scrollView.delegate = self;
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((98/ScreenWidth)*ScreenWidth,(400/ScreenHeight)*ScreenHeight, 122, 36);
    pageControl.numberOfPages = self.imageArray.count;
    pageControl.currentPage = 0;
    pageControl.hidden = YES;

    
    [pageControl addTarget:self
                    action:@selector(pgCntlChanged:)forControlEvents:UIControlEventValueChanged];
    [self performSelector:@selector(startAnimatingScrl) withObject:nil afterDelay:3.0];
    [self.view addSubview:pageControl];
    
    for (int i =0; i<self.imageArray.count ; i++) {
        
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[self.imageArray objectAtIndex:i]]];
        imageview.frame = [UIScreen mainScreen].bounds;
        
        [imageview setTag:i+1];
        if (i !=0) {
            imageview.alpha = 0;
        }
        [self.view insertSubview:imageview belowSubview:self.scrollView];  
    }
}

@end
