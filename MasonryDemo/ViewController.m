//
//  ViewController.m
//  MasonryDemo
//
//  Created by 花花 on 16/10/9.
//  Copyright © 2016年 花花. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UpdateViewController.h"

@interface ViewController ()
{
    UIImageView *imgHead;
    UIScrollView *scr_main;
    UITextView *tv;
    UIView *visitView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"首页"];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commit)];
//    [self createUI];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self initUI];
    
}

#pragma mark -- leftItem method
- (void)cancel {
    
}

#pragma mark -- rightItem method
- (void)commit {
    UpdateViewController *updateVC = [[UpdateViewController alloc]init];
    [self.navigationController pushViewController:updateVC animated:YES];
    
}

- (void)initUI {
    scr_main = [[UIScrollView alloc]init];
    [self.view addSubview:scr_main];
    scr_main.backgroundColor = [UIColor whiteColor];
    
    [scr_main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    //头视图
    [self createTopView];
    
}

- (void)createTopView {
    UIView *topView = [[UIView alloc]init];
    [scr_main addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(scr_main);
        make.height.equalTo(@45);
        make.width.mas_equalTo(scr_main.mas_width);
    }];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img_head = [[UIImageView alloc]init];
    [topView addSubview:img_head];
    
    [img_head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(@15);
        make.width.and.height.equalTo(@25);
    }];
    
    img_head.backgroundColor = [UIColor greenColor];
    img_head.layer.cornerRadius = 25/2.0;
    img_head.layer.masksToBounds = YES;
    
    UILabel *nickLabel = [[UILabel alloc]init];
    [topView addSubview:nickLabel];
    
    /**
     
     多个固定大小的控件的等间隔排列,变化的是间隔的空隙
     *
     @param axisType 轴线方向
     @param fixedItemLength 每个控件的固定长度或者宽度值
     @param leadSpacing 头部间隔
     @param tailSpacing 尾部间隔
     
   
    NSArray *arr = @[img_head,nickLabel];
    
    arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:<#(CGFloat)#> leadSpacing:<#(CGFloat)#> tailSpacing:<#(CGFloat)#>
     */
    
    [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.left.equalTo(img_head.mas_right).offset(5);
        make.width.mas_equalTo(scr_main).offset(-CGRectGetMaxX(img_head.frame)-150);
    }];
//    nickLabel.backgroundColor = [UIColor redColor];
    nickLabel.font = [UIFont systemFontOfSize:15];
    nickLabel.text = @"王小萌";
    
    //tele
    UILabel *teleLabel = [[UILabel alloc]init];
    [topView addSubview:teleLabel];
    [teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nickLabel);
        make.left.equalTo(nickLabel.mas_right).offset(5);
//        make.height.equalTo(nickLabel);
        make.width.mas_equalTo(scr_main).offset(-CGRectGetMaxX(nickLabel.frame)-5);
        
    }];
    
//    teleLabel.backgroundColor = [UIColor yellowColor];
    teleLabel.font = [UIFont systemFontOfSize:14];
    teleLabel.text = @"18310029394";
    
    [self createSecondViewByTopView:topView];
}

- (void)createSecondViewByTopView:(UIView *)topView {
    UIView *intentionView = [[UIView alloc]init];
    intentionView.backgroundColor = [UIColor lightGrayColor];
    [scr_main addSubview:intentionView];
    
    [intentionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.width.equalTo(topView.mas_width);
        make.height.equalTo(@65);
    }];
  
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [intentionView addSubview:btn];
        [tempArr addObject:btn];
        btn.tag = i+1;
        [btn addTarget:self
                action:@selector(chooseType:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor purpleColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1]
             forState:UIControlStateNormal];
        btn.showsTouchWhenHighlighted = YES;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@45);
            make.centerY.mas_equalTo(CGRectGetHeight(intentionView.frame)/2.0);
            btn.layer.cornerRadius = 45/2.0;
            btn.layer.masksToBounds = YES;
        }];
    }
    
    //宽度固定，间隔不固定
    [tempArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:45 leadSpacing:20 tailSpacing:20];
    
    //间隔固定，宽度不固定
//    [tempArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    
    [self initVisitorUIByIntentionView:intentionView];
}

- (void)initVisitorUIByIntentionView:(UIView *)intentionView {
    visitView = [[UIView alloc]init];
    visitView.backgroundColor = [UIColor whiteColor];
    [scr_main addSubview:visitView];
    
    [visitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(intentionView.mas_bottom);
        make.width.equalTo(intentionView);
        make.height.equalTo(@45);
    }];
    
    UILabel *visitLabel = [[UILabel alloc]init];
    [visitView addSubview:visitLabel];

    [visitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(visitView);
        make.width.equalTo(@60);
        make.top.equalTo(@0);
        
    }];
    
    visitLabel.adjustsFontSizeToFitWidth = YES;
    visitLabel.text = @"回访提醒";
    
    UIImageView *line = [[UIImageView alloc]init];
    line.backgroundColor = [UIColor redColor];
    [scr_main addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visitView.mas_bottom).offset(1);
        make.width.equalTo(visitView);
        make.height.equalTo(@1);
    }];
    //输入框
    tv = [[UITextView alloc]init];
    tv.text = @"请输入要反馈的内容";
    tv.layer.cornerRadius = 4;
    tv.layer.masksToBounds = YES;
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tv.layer.borderWidth = 1;
    
    [scr_main addSubview:tv];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.offset(-15);
        make.top.equalTo(line.mas_bottom).offset(11);
//        make.centerX.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
}

#pragma mark -- 选择按钮类型
- (void)chooseType:(UIButton *)btn {
    if (btn.tag == 1 || btn.tag == 4) {
        visitView.hidden = YES;
     [tv mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(visitView);
//          make.left.mas_equalTo(15);
//          make.right.mas_equalTo(-15);
//         make.top.greaterThanOrEqualTo(visitView);
         
        }];
    }else{
        
        [tv mas_updateConstraints:^(MASConstraintMaker *make) {
            visitView.hidden = NO;
//            make.top.lessThanOrEqualTo(visitView.mas_bottom);
            make.top.equalTo(visitView.mas_bottom).offset(12);
        }];
    }
    
    /*
     [btn updateConstraints];
     
     //1.告知需要更新约束，但不会立刻开始，系统然后调用updateConstraints
     [btn setNeedsUpdateConstraints];
     
     //2.告知立刻更新约束，系统立即调用updateConstraints
     [btn updateConstraintsIfNeeded];
     
     //3.这里动画当然可以取消，具体看项目的需求
     //系统block内引用不会导致循环引用，block结束就会释放引用对象
     [UIView animateWithDuration:0.4 animations:^{
     [btn layoutIfNeeded]; //告知页面立刻刷新，系统立即调用updateConstraints
     }];
     */
    
    NSLog(@"button's tag = %ld",(long)btn.tag);
    
//    [self.view setNeedsUpdateConstraints];
}

//更新约束
- (void)updateConstraints {
    
    NSLog(@"更新updateConstraints");
}

- (void)createUI {
    
   
    UILabel *tmpLabel = [[UILabel alloc]init];
    tmpLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:tmpLabel];
    [tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
//        make.right.equalTo(superView1.mas_right).offset(-15);
        make.height.mas_equalTo(30);
        
    }];
    
    tmpLabel.layer.cornerRadius = 4;
    tmpLabel.layer.masksToBounds = YES;
    tmpLabel.textAlignment = NSTextAlignmentCenter;
    
    tmpLabel.text = @"这是label";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tmpLabel.mas_bottom).offset(20);
        make.left.equalTo(tmpLabel.mas_left).offset(30);
        make.right.equalTo(tmpLabel.mas_right).offset(-30);
        make.height.equalTo(tmpLabel).offset(15);
        
    }];
    
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 8;
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"这是按钮" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(clickEvent:)
     forControlEvents:UIControlEventTouchUpInside];
//    button.highlighted = YES;
    imgHead = [[UIImageView alloc]init];
    [self.view addSubview:imgHead];
    
    [imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(20);
        make.width.height.equalTo(@45);
//        make.height.equalTo(@45);
        make.centerX.equalTo(button);
//        make.centerX.mas_equalTo(button);
        
    }];
    
    NSLog(@"imgHead's height = %f",imgHead.frame.size.height);
    imgHead.layer.cornerRadius = 45/2.0;
    imgHead.layer.masksToBounds = YES;
    imgHead.backgroundColor = [UIColor greenColor];
    
    
}

- (void)viewDidLayoutSubviews {
    
}

- (void)clickEvent:(UIButton *)btn {
    
    [btn updateConstraints];
    [imgHead mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(10);
        make.top.equalTo(btn.mas_bottom).offset(40);
        make.centerX.equalTo(btn.mas_centerX);
        make.width.height.equalTo(imgHead.mas_height);
        
//        make.height.equalTo(btn.mas_height);
    }];
    [super updateViewConstraints];
//     通知需要更新约束，但是不立即执行
//    [self setNeedsUpdateConstraints];
//     立即更新约束，以执行动态变换
//     update constraints now so we can animate the change
//    [self updateConstraintsIfNeeded];
//     执行动画效果, 设置动画时间
//    [UIView animateWithDuration:0.4 animations:^{
//        [self layoutIfNeeded];
//    }];
    
    
}

- (void)updateConstraintsIfNeeded {
    [super updateViewConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
