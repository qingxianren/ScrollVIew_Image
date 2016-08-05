//
//  ViewController.m
//  ScrollVIew_Image
//
//  Created by 李江川 on 16/8/5.
//  Copyright © 2016年 ljc. All rights reserved.
//

#import "ViewController.h"

#define kImageCount 4

@interface ViewController ()<UIScrollViewDelegate>
/**
 *滚动视图的控件
 */
@property(nonatomic,strong)UIScrollView* scroll;
/**
 *页码指示视图的控件
 */
@property(nonatomic,strong)UIPageControl* pageControl;
/**
 *显示左边图片的控件
 */
@property(nonatomic,strong)UIImageView* LeftImageView;
/**
 *显示中心图片的控件
 */
@property(nonatomic,strong)UIImageView* centerImageView;
/**
 *显示右边图片的控件
 */
@property(nonatomic,strong)UIImageView* rightImageView;
/**
 *保存图片的数组
 */
@property(nonatomic,strong)NSArray* imageArray;
/**
 *图片的当前下标索引
 */
@property(nonatomic,assign)NSInteger currentIndex;
/**
 *图片总数
 */
@property(nonatomic,assign)NSInteger imageCount;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    self.currentIndex=0;
    [self createScrollView];
    [self createPageControl];
    [self createImageView];
    [self loadImage];
    [self setImageByIndex:(int)self.currentIndex];
}
/**
 *以下是搭建UI界面的方法
 */
-(void)loadImage
{
    self.imageArray=@[@"apic21145.jpg",@"apic21851.jpg",@"fpic5493.jpg",@"fpic5664.jpg"];
    self.imageCount=self.imageArray.count;
}
-(void)createScrollView
{
    
    self.scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 130, self.view.bounds.size.width, self.view.bounds.size.width)];
    self.scroll.backgroundColor=[UIColor whiteColor];
    self.scroll.showsHorizontalScrollIndicator=NO;
    self.scroll.showsVerticalScrollIndicator=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.bounces=NO;
    self.scroll.delegate=self;
    self.scroll.contentOffset=CGPointMake(self.view.bounds.size.width, 0);
    self.scroll.contentSize=CGSizeMake(self.view.bounds.size.width*kImageCount, self.view.bounds.size.width);
    [self.view addSubview:self.scroll];
}
-(void)createPageControl
{
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-60)/2, 600, 60, 20)];
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor blueColor];
    self.pageControl.enabled=YES;
    self.pageControl.numberOfPages=kImageCount;
    [self.view addSubview:self.pageControl];
}
-(void)createImageView
{
    self.LeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [self.scroll addSubview:self.LeftImageView];
    
    self.centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [self.scroll addSubview:self.centerImageView];
    
    self.rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [self.scroll addSubview:self.rightImageView];
}
#pragma mark ----刷新图片
-(void)refreshImage
{
    if (self.scroll.contentOffset.x>self.view.bounds.size.width) {
        self.currentIndex=((self.currentIndex+1)%self.imageCount);
    }
    else if(self.scroll.contentOffset.x<self.view.bounds.size.width){
        self.currentIndex=((self.currentIndex-1+self.imageCount)%self.imageCount);
    }
    [self setImageByIndex:(int)self.currentIndex];
}
#pragma mark ----该方法根据传回的下标设置三个ImageView的图片
-(void)setImageByIndex:(int)currentIndex
{
    NSString *name;
    name = [self.imageArray objectAtIndex:currentIndex];
    self.centerImageView.image=[UIImage imageNamed:name];
    NSLog(@"当前页的名字是:%@",name);
  
    name =[self.imageArray objectAtIndex:((self.currentIndex-1+self.imageCount)%self.imageCount)];
    self.LeftImageView.image=[UIImage imageNamed:name];
    NSLog(@"左边的图片名字是:%@",name);
    
    name =[self.imageArray objectAtIndex:((self.currentIndex+1)%self.imageCount)];
    self.rightImageView.image=[UIImage imageNamed:name];
    NSLog(@"右边的图片名字是:%@",name);
    self.pageControl.currentPage=currentIndex;
}
#pragma mark ----UIScrollViewDelegate代理方法（停止加速时调用）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshImage];
    self.scroll.contentOffset = CGPointMake(self.view.bounds.size.width,0);
    self.pageControl.currentPage = self.currentIndex;
    NSLog(@"停止了加速,停在第%ld页",self.pageControl.currentPage+1);
}
@end
