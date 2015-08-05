//
//  MainViewController.m
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
#define WEBVIEW_Y 64
#define SHARE_TEXTE @"移动掌上学院，美发行业电子百科全书，边学习边赚钱的超级平台！"
#define SHARE_IMAGE @"logoshare.png"
#define BTN_IMAGE_SIZE 25
#define TABBAR_HEIGHT 50
#import "MainViewController.h"
#import "SpecialViewController.h"
#import "ThirdViewController.h"

#import "UMSocial.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"

#import "ErrorView.h"
#import "SVProgressHUD.h"
#import "UIImage+TransFormWandH.h"
#import "MLBModel.h"
#import "AppDelegate.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"

#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"
#import "payRequsestHandler.h"
#import "WXUtil.h"


@interface MainViewController ()<SpecialViewDelegate,UMSocialUIDelegate>{
    EGORefreshTableHeaderView * _rv;
    ErrorView * _ev;
    MLBModel * _mlbModel;
    BOOL _isSlected;
    UIView * _tabbarView;
    UIView * _navView;
    UIButton * _leftBtn;
    UIButton * _rightBtn;
    UIButton * _rightBtn2;
    UIImageView * _leftIV;
    UIImageView * _rightIV;
    UIImageView * _rightIv2;
    UILabel * _righLabel;
    NSDictionary * _currentDict;
    NSMutableData * _backData;
    UIView * _whiteLine;
}

@end

@implementation MainViewController

- (NSDictionary *)dic{
    if (!_dic) {
        _dic = [[NSDictionary alloc] init];
    }
    return _dic;
}

-(id)init{
    self =[super init];
    if (self) {
        self.currentUrl =[[NSURL alloc]init];
        _mlbModel = [[MLBModel alloc]init];
        _currentDict =[NSDictionary dictionary];
        _backData =[NSMutableData data];
        app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    if (IOS6) {
    }else{
         self.automaticallyAdjustsScrollViewInsets =NO;
    }
    [self createNav];
    self.view.backgroundColor =[UIColor whiteColor];
    [self createWebViewWithUrl:self.currentUrl];
    [self createShareWith:self.currentUrl];
    
  
}

-(void)viewWillAppear:(BOOL)animated{
    if ( app.isReload == YES) {
        [_webView reload];
        app.isReload =NO;
    }else{
        
    }
    
    
    
    
    
}

-(void)createShareWith:(NSURL *)url{
    //设置第三方分享
    //设置友盟社会化组件
    [UMSocialData setAppKey:APP_KEY];
    //设置微信
    [UMSocialWechatHandler setWXAppId:@"wx7e5cafaa5a14e3c6" appSecret:@"3803679910a2677b4d94c6d67c5fbcc1" url:[url absoluteString]];
    //设置qq
    [UMSocialQQHandler setQQWithAppId:@"1104783888" appKey:@"OT3A59l4sEFjuwTW" url:[url absoluteString]];
    //打开新浪微博的sso开关
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToLWTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSina]];
}

-(void)createWebViewWithUrl:(NSURL *)url{
    NSLog(@"%d",self.hidesBottomBarWhenPushed);
    if (self.hidesBottomBarWhenPushed) {
        if (IOS6) {
            _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,44,VIEW_WIDH,VIEW_HEIGHT-64)];
        }else{
            _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,64,VIEW_WIDH,VIEW_HEIGHT-64)];
        }
    }else{
        if (IOS6) {

            _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,44,VIEW_WIDH,VIEW_HEIGHT-114)];
        }else{
            _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,64,VIEW_WIDH,VIEW_HEIGHT-114)];
        }

    }

    _webView.backgroundColor =[UIColor whiteColor];
    _webView.delegate =self;
    _webView.scrollView.delegate =self;
    _webView.scrollView.bounces =YES;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.scrollEnabled =YES;
    [_webView sizeToFit];
    if (url==nil) {
        url=[[NSURL alloc]initWithString:MAIN_URL];
        self.currentUrl =url;
    }
    NSLog(@"this is currentUrl:%@",url);
    NSURLRequest * request =[NSURLRequest requestWithURL:url];
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    _lv = [[loadView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, _webView.frame.size.height)];
    [_webView addSubview:_lv];



}

#pragma mark ---Refresh
-(void)createRefreshView{
    if (_rv ==nil) {
    _rv =[[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, -150, VIEW_WIDH,150)];
    _rv.delegate =self;
    [_webView.scrollView addSubview:_rv];
    }
    [_rv refreshLastUpdatedDate];
}

-(void)removeRefreshView{
    if (_rv ==nil) {
        return;
    }
    [_rv removeFromSuperview];
}


#pragma mark ---NAV
-(void)createNav{
    self.navigationController.navigationBarHidden =YES;
    if (IOS6) {
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, 44)];
    }else{
        _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, VIEW_WIDH, 44)];
    }

    _navView.backgroundColor =UIColorFromRGB(0xdd127b);

    //标题
    self.titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(55, 7, VIEW_WIDH-55*2, 30)];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.titleLabel.textColor =[UIColor whiteColor];
    self.titleLabel.text =@"加载中..";
    self.titleLabel.backgroundColor = [UIColor clearColor];

    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    [_navView addSubview:self.titleLabel];


    //左btn
    _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.tag =BTN_TAG+1;
    _leftBtn.frame =CGRectMake(0, 0, 44, 44);

    //左IV
    _leftIV =[[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 28, 32)];

    //右btn1
    _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.tag =BTN_TAG+2;
    _rightBtn.frame =CGRectMake(VIEW_WIDH-155, 0, 88, 44);
    _rightBtn.hidden =YES;
    //右IV
    _rightIV =[[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WIDH-155+8, 9, 26, 26)];
    _rightIV.hidden =YES;
    //右LB
    _righLabel =[[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDH -155+36, 11, 40, 22)];
    _righLabel.backgroundColor =[UIColor clearColor];
    [_righLabel setTextColor:[UIColor whiteColor]];
    _righLabel.font = [UIFont systemFontOfSize:13];
    _righLabel.textAlignment = NSTextAlignmentRight;
    _righLabel.hidden =YES;

    //右btn2
    _rightBtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn2.tag =BTN_TAG+3;
    _rightBtn2.frame =CGRectMake(VIEW_WIDH-40, 0, 44, 44);
    //右IV2
    _rightIv2 =[[UIImageView alloc]initWithFrame:CGRectMake(VIEW_WIDH-40, 6, 33, 33)];

    if (self.isHome == YES) {
        if (self.isMainHome ==YES) {
            [_leftIV setImage:[UIImage imageNamed:@"menu.png"]];
            [_leftBtn addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];

            [_rightIv2 setImage:[UIImage imageNamed:@"about.png"]];
            [_rightBtn2 addTarget:self action:@selector(showAboutNavBtn) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [_leftIV setImage:[UIImage imageNamed:@"menu.png"]];
            [_leftBtn addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchUpInside];

            [_rightIv2 setImage:[UIImage imageNamed:@"about2.png"]];
            [_rightBtn2 addTarget:self action:@selector(showAbout2NavBtn) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        [_leftIV setImage:[UIImage imageNamed:@"back.png"]];
        [_leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_leftIV setFrame:CGRectMake(0, 6, 28, 32)];

        [_rightIv2 setImage:[UIImage imageNamed:@"about2.png"]];
        [_rightBtn2 addTarget:self action:@selector(showAbout2NavBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    [_navView addSubview:_leftIV];
    [_navView addSubview:_leftBtn];

    [_navView addSubview:_rightIV];
    [_navView addSubview:_rightBtn];
    [_navView addSubview:_righLabel];

    [_navView addSubview:_rightIv2];
    [_navView addSubview:_rightBtn2];

    if (_lv !=nil) {
        [self.view insertSubview:_navView belowSubview:_lv];
    }else{
        [self.view addSubview:_navView];
    }

    _whiteLine =[[UIView alloc]initWithFrame:CGRectMake(_rightBtn2.frame.origin.x-15, 8, 1, _navView.frame.size.height-16 )];
    _whiteLine.hidden =YES;
    _whiteLine.backgroundColor =[UIColor whiteColor];
    [_navView addSubview:_whiteLine];
    
}



-(void)changeNavWithModel:(MLBModel *)model{

    //标题
    if ([model.titleAligen isEqualToString:@"l"]) {
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.frame =CGRectMake(55-13, _titleLabel.frame.origin.y, 120, _titleLabel.frame.size.height);
    }

    if (model.isShowNavRightBtn1==1) {
        _whiteLine.hidden =NO;
        _rightBtn.hidden =NO;
        if (model.btnImage !=nil) {
            NSLog(@"btnImage === %@",model.btnImage);
            _rightIV.hidden =NO;
            [_rightIV sd_setImageWithURL:[NSURL URLWithString:model.btnImage]];

//            [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        }
        if (model.btnName.length !=0) {
            _righLabel.hidden =NO;
            _righLabel.text = model.btnName;
        }else{
            _rightIV.frame =CGRectMake(VIEW_WIDH -155 +48
                                       , 9, 26, 26);
        }

        if (model.btnType ==1) {
            [_rightBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [_rightBtn addTarget:self action:@selector(dofunction:) forControlEvents:UIControlEventTouchUpInside];
        }

    }else{
        [_rightBtn removeFromSuperview];
        [_righLabel removeFromSuperview];
        [_rightIV removeFromSuperview];
        _whiteLine.hidden =YES;

    }

    if (model.isShowNavRightBtn2 ==0) {
        _rightBtn2.hidden =YES;
        _whiteLine.hidden =YES;
    }
}




-(void)back{
    NSLog(@"%d",self.isPresent);
    if (self.isPresent) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        [animation setType:kCATransitionMoveIn];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.view.window.layer addAnimation:animation forKey:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

-(void)push:(MLBModel *)model{
    if ([[self.currentUrl absoluteString] isEqualToString:@"http://m.meilianbao.net/Video/DailyLesson/"]) {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_mlbModel.btnData]]];
    }else if([[self.currentUrl absoluteString] isEqualToString:@"http://m.meilianbao.net/Video/Category"]) {
        ThirdViewController * tvc =[[ThirdViewController alloc]init];
        tvc.delegate =self;
        tvc.currentUrl =[NSURL URLWithString:_mlbModel.btnData];
        tvc.isHome =NO;
        tvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:tvc animated:YES];
    }else if([[self.currentUrl absoluteString] rangeOfString:@"/Video/Index/"].length != 0){
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_mlbModel.btnData]]];
    }else{
        SpecialViewController * svc = [[SpecialViewController alloc]init];
        svc.delegate =self;
        svc.currentUrl  =[NSURL URLWithString:_mlbModel.btnData];
        svc.isHome =NO;
        svc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

-(void)dofunction:(MLBModel *)model{
    [_webView stringByEvaluatingJavaScriptFromString:_mlbModel.btnData];
}

-(void)showList{
    if (IOS6) {

        [app.rooVC openDrawerSide:1 animated:YES completion:^(BOOL finished) {
        }];
    }else{
        if ([self.mainDelegate respondsToSelector:@selector(showLeftMeun)]) {
            [self.mainDelegate showLeftMeun];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if (isHidden ==YES) {
        isHidden =!isHidden;
        _rnv.hidden =YES;
    }
}

static BOOL isHidden =NO;

-(void)showAbout2NavBtn{
    if (_rnv ==nil) {
        _rnv  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT)];
        _rnv.backgroundColor =[UIColor clearColor];
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenAbout2NavBtn)];
        [_rnv addGestureRecognizer:tap];
        RightNavView * downList =[[[NSBundle mainBundle]loadNibNamed:@"RightNavView" owner:self options:nil]lastObject];
        if (IOS6) {
            downList.frame =CGRectMake(VIEW_WIDH-150, 44, 144, 174);
        }else{
            downList.frame =CGRectMake(VIEW_WIDH-150, 64, 144, 174);
        }
        downList.homeBtn.backgroundColor =[UIColor clearColor];
        downList.shareBtn.backgroundColor =[UIColor clearColor];
        downList.refresh.backgroundColor =[UIColor clearColor];

        downList.homeBtn.tag =BTN_TAG+11;
        downList.shareBtn.tag =BTN_TAG+12;
        downList.refresh.tag =BTN_TAG+13;
        [downList.homeBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
        [downList.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [downList.refresh addTarget:self action:@selector(refreshWebView) forControlEvents:UIControlEventTouchUpInside];
        [_rnv addSubview:downList];
        [self.view addSubview:_rnv];
    }
    _rnv.hidden =isHidden;
    NSLog(@"%d",isHidden);
    isHidden =!isHidden;
}

-(void)hiddenAbout2NavBtn{
    _rnv.hidden =isHidden;
    isHidden =!isHidden;
}

-(void)showAboutNavBtn{
    SpecialViewController * svc =[[SpecialViewController alloc]init];
    svc.delegate =self;
    svc.currentUrl = [NSURL URLWithString:ABOUT_URL];
    [self presentViewController:svc animated:YES completion:^{

    }];
    
}

-(void)backToHome{
    _rnv.hidden =isHidden;
    isHidden =!isHidden;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}

-(void)refreshWebView{
    _rnv.hidden =isHidden;
    isHidden =!isHidden;
    [_webView loadRequest:[NSURLRequest requestWithURL:self.currentUrl]];
    [_lv startLoad];
}

-(void)share{
    if (isHidden ==YES) {
        _rnv.hidden =isHidden;
        isHidden =!isHidden;
    }

    if (_mlbModel.rightBtnShareToWhere ==1) {
    NSURLRequest * request =[NSURLRequest requestWithURL:[NSURL URLWithString:_mlbModel.sharePicture]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    }else{
        [UMSocialSnsService presentSnsIconSheetView:self appKey:APP_KEY shareText:SHARE_TEXTE shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToSms,UMShareToEmail,nil] delegate:self];

        [UMSocialData defaultData].extConfig.wechatSessionData.shareImage =[UIImage imageNamed:SHARE_IMAGE];

        [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage =[UIImage imageNamed:SHARE_IMAGE];

        [UMSocialData defaultData].extConfig.wechatFavoriteData.shareImage =[UIImage imageNamed:SHARE_IMAGE];

        [UMSocialData defaultData].extConfig.qqData.shareImage =[UIImage imageNamed:SHARE_IMAGE];

        [UMSocialData defaultData].extConfig.qzoneData.shareImage =[UIImage imageNamed:SHARE_IMAGE];
        //短信分享内容
        NSString * tmpStr =[NSString stringWithFormat:@"%@:%@",SHARE_TEXTE,[self.currentUrl absoluteString]];
        [UMSocialData defaultData].extConfig.smsData.shareText =tmpStr;
        

    }
}

-(void)useLocation{

    if (self.location ==nil) {
    self.location =[[CLLocationManager alloc]init];
    self.location.delegate =self;
    //控制定位精度
    self.location.desiredAccuracy =kCLLocationAccuracyBest;
    //控制定位频率,单位是米
    self.location.distanceFilter =100;
    //由于ios8下需要授权
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        [self.location requestWhenInUseAuthorization];//调用了这句就会弹出询问框
    }
    }

    [self.location startUpdatingLocation];
}

-(void)stopLocation{
    [self.location stopUpdatingLocation];
}


#pragma mark --Photo
-(void)showphoto{
//    NSData *data;
//    UIImage * tmpimage =[UIImage imageNamed:@"error.png"];
//    data =UIImagePNGRepresentation(tmpimage);
//    NSString * dataStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSLog(@"%@",dataStr);
//    NSString * statas =[_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(1,'%@')",dataStr]];
//    NSLog(@"%@",statas);

    _myActionSheet= [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [_myActionSheet showInView:self.view];
}

//打开照相机
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType =  UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate =self;
        //设置拍照后的照片可被编辑
        picker.allowsEditing =YES;
        picker.sourceType =sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else{
        NSLog(@"打开相机失败");
    }
}

//打开本地相册
-(void)localPhoto{

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
    UIImagePickerController *picker =[[UIImagePickerController alloc]init];
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate =self;
    picker.allowsEditing =YES;

    [self presentViewController:picker animated:YES completion:^{
        
    }];
    }else{
        NSLog(@"图库不可用");
    }

}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info =%@",info);
    NSString *type =[info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转换成NSdata
        UIImage * image =[info objectForKey:UIImagePickerControllerEditedImage];
        NSData * data =UIImagePNGRepresentation(image);
//        if (UIImagePNGRepresentation(image) ==nil) {
//            data =UIImageJPEGRepresentation(image, 1.0);
//        }else{
//        }
//        UIImage * tmpimage =[UIImage imageNamed:@"error.png"];
//        data =UIImagePNGRepresentation(tmpimage);
        NSString * dataStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(1,'%@')",dataStr]];
        
        //    //图片保存的路径
        //    //这里将图片放在沙盒里
        //    NSString * DocumentsPath =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //
        //    //文件管理器
        //    NSFileManager * fileManager =[NSFileManager defaultManager];
        //
        //    //把刚才转换的data对象拷贝至沙盒中 并保存为image.png
        //    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        //    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //
        //    //得到选择后沙盒图片的完整路径
        //        NSString * filePath =[[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
        //        NSLog(@"image's path is :%@",filePath);
        //    //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        //创建一个选择后图片的小图标放在下面
        //        UIImageView *smallimage =[[UIImageView alloc]initWithFrame:CGRectMake(50, 120, 40, 40)];
        //        smallimage.image =image;
        //    //加在视图中
        //        [self.view addSubview:smallimage];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消选择照片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark  --PAY



- (void)AliPay{


    MLBModel * model   =[MLBModel makePayModelWithDict:self.dic];
    Order *order = [[Order alloc] init];
    order.partner = AliPartner;
    order.seller = AliSeller;
    order.tradeNO = model.OrderId;
    order.productName = model.OrderTitle;
    order.productDescription = model.OrderTitle;
    order.amount = [NSString stringWithFormat:@"%@",model.Amount];
    order.notifyURL = model.notifyUrl;
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";

    NSString *appScheme = @"mlbali";

    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);

    id<DataSigner> signer = CreateRSADataSigner(AliPrivateKey);

    NSString *signedString = [signer signString:orderSpec];

    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
   //   NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"f",@"0",@"pt", nil];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"]  isEqual: @"9000"]) {
                NSString *jsonStr = @"{\"f\":1,\"pt\":0}";
               [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
             
            }else  if ([resultDic[@"resultStatus"]  isEqual: @"6002"]) {
                NSString *jsonStr = @"{\"f\":0,\"pt\":0}";
                [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
                
            }else if ([resultDic[@"resultStatus"]  isEqual: @"6001"]){
                NSString *jsonStr = @"{\"f\":2,\"pt\":0}";
                [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
               
                
            }
            
            
        }];
        

        
    }
}

- (void)startNetWithURL:(NSURL *)url
{

    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:url];

    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self] ;
    NSLog(@"urlrequest ==%@",urlRequest);
   
    [urlConn start];
}


- (void)YinlianPay{
    
    MLBModel * model   =[MLBModel makePayModelWithDict:self.dic];
   

    // FirstViewController *first = [[FirstViewController alloc] init];

    [UPPayPlugin startPay:model.yinLiaTN mode:@"01" viewController:self delegate:self];

}

- (void)UPPayPluginResult:(NSString *)result
{
    NSLog(@"result == %@",result);
    if ([result isEqualToString:@"success"]) {
        NSString *jsonStr = @"{\"f\":1,\"pt\":2}";
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
      
    }else if ([result isEqualToString:@"fail"]){
        NSString *jsonStr = @"{\"f\":0,\"pt\":2}";
      [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
       
        
    }else if ([result isEqualToString:@"cancel"]){
        NSString *jsonStr = @"{\"f\":2,\"pt\":2}";
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
        
        
    }
    
}







- (void)wetchatPay{
    [WXApi registerApp:APP_ID withDescription:@"wx25e9216238354370"];
    NSLog(@"注意微信支付了");
    //创建支付签名对象
    MLBModel *model   =[MLBModel makePayModelWithDict:self.dic];
    
    
    
        /*
     payRequsestHandler *req1 = [[payRequsestHandler alloc] init];
     //初始化支付签名对象
     [req1 init:APP_ID mch_id:MCH_ID];
     //设置密钥
     [req1 setKey:PARTNER_ID];
     NSLog(@"req1 == %@",req1);
     NSMutableDictionary *dict = [req1 sendPay_demo];
     NSLog(@"-=-=-=- dict====%@",dict);

     NSLog(@"%@\n\n",[req1 getDebugifo]);
     //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];

     NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
     */
    NSString    *package, *time_stamp, *nonce_str;
    //设置支付参数
    time_t now;
    time(&now);
    time_stamp  = [NSString stringWithFormat:@"%ld", now];
    nonce_str	= [WXUtil md5:time_stamp];
    //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
    //package       = [NSString stringWithFormat:@"Sign=%@",package];
    package         = @"Sign=WXPay";
    //第二次签名参数列表
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject: APP_ID        forKey:@"appid"];
    [signParams setObject: nonce_str    forKey:@"noncestr"];
    [signParams setObject: package      forKey:@"package"];
    [signParams setObject: MCH_ID       forKey:@"partnerid"];
    [signParams setObject: time_stamp   forKey:@"timestamp"];
    [signParams setObject: model.yinLiaTN    forKey:@"prepayid"];
    //[signParams setObject: @"MD5"       forKey:@"signType"];
    //生成签名
    NSString *sign  = [[payRequsestHandler alloc] createMd5Sign:signParams];
 

    //添加签名
    [signParams setObject: sign         forKey:@"sign"];
   

    //   [debugInfo appendFormat:@"第二步签名成功，sign＝%@\n",sign];

    PayReq* req             = [[PayReq alloc] init];

    req.partnerId           = MCH_ID;
    req.prepayId            = model.yinLiaTN;
    req.package = @"Sign=WXPay";
    req.nonceStr            = nonce_str;
    req.timeStamp           = time_stamp.intValue;
    req.sign                = sign;
    
    NSLog(@"req === %@",req);

    [WXApi sendReq:req];

    
}






#pragma mark --ActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==actionSheet.cancelButtonIndex) {
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0: //打开照相机拍照
            [self takePhoto];
            break;
        case 1://打开本地相册
            [self localPhoto];
        default:
            break;
    }
}



#pragma mark --LocationDelegate;


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLGeocoder * geocoder =[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count >0) {
            CLPlacemark * placemark =[placemarks objectAtIndex:0];
            
//            NSLog(@"%@",placemark.name);
//            NSLog(@"%@",placemark.locality);
//            NSLog(@"%@",placemark.administrativeArea);
//            NSLog(@"%@",placemark.thoroughfare);
//            NSLog(@"%@",placemark.subLocality);
//            NSLog(@"%@",placemark.subThoroughfare);
//            NSLog(@"%@",placemark.areasOfInterest);
//            NSLog(@"%@",placemark.inlandWater);
//            NSLog(@"%@",placemark.country);
//            NSLog(@"%@",placemark.ISOcountryCode);
//            NSLog(@"%@",placemark.postalCode);
//            NSLog(@"%@",placemark.subAdministrativeArea);
//            NSLog(@"%@",placemark.ocean);
//            NSLog(@"%@",placemark.addressDictionary);
//            NSString * str  =[[placemark.addressDictionary objectForKey:@"FormattedAddressLines"]lastObject];
//            NSString * str1 =[placemark.addressDictionary objectForKey:@"Name"];
//            NSString * str2 =[placemark.addressDictionary objectForKey:@"State"];
//            NSString * str3 =[placemark.addressDictionary objectForKey:@"Street"];
//            NSString * str4 =[placemark.addressDictionary objectForKey:@"SubLocality"];
//            NSString * str5 =[placemark.addressDictionary objectForKey:@"SubThoroughfare"];
//            NSString * str6 =[placemark.addressDictionary objectForKey:@"Thoroughfare"];
//            NSLog(@"%@/n%@/n%@/n%@/n%@/n%@/n%@",str,str1,str2,str3,str4,str5,str6);

            NSString * tmpLoction  = [NSString stringWithFormat:@"$.Raw.CallBack(2,'%@,%@,%@,%@,%@')",placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.name];
            [_webView stringByEvaluatingJavaScriptFromString:tmpLoction];
        }
    }];
    [self stopLocation];
    [SVProgressHUD dismissWithSuccess:@"定位成功"];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLocation];
    [SVProgressHUD dismissWithError:@"定位失败"];

}

#pragma mark --WebViewDelegate;
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
    _reloading =NO;
    [_lv stopLoad];
    [SVProgressHUD dismiss];


//    NSString* path = [[NSBundle mainBundle] pathForResource:@"error_page" ofType:@"html"];
//    NSURL* url = [NSURL fileURLWithPath:path];
//    NSLog(@"%@",url);
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//    [webView loadRequest:request];

}

-(void)dealloc{
    [_ev removeFromSuperview];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    _reloading =YES;

    if (_isDownRefresh ==YES) {
        [SVProgressHUD show];
        return;
    }

    [_lv startLoad];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _isDownRefresh =NO;
    [SVProgressHUD dismiss];
    _reloading =NO;
    [_lv stopLoad];

    [_rv egoRefreshScrollViewDataSourceDidFinishedLoading:_webView.scrollView];

    //获取标签
    NSString * titleStr =[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text =titleStr;
    //获取页面url
    NSString * tmpUrl =[webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    self.currentUrl =[NSURL URLWithString:tmpUrl];
    
    //取消长按手势
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];

    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];

        NSString * str =[_webView stringByEvaluatingJavaScriptFromString:@"SendToRaw()"];
        NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];
        _currentDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",_currentDict);

        _mlbModel =[MLBModel makeModelWithDict:_currentDict];

        [self changeNavWithModel:_mlbModel];

        //当前页面是否需要刷新
        if (_mlbModel.isShowRefresh ==1) {
            [self createRefreshView];
        }else{
            [self removeRefreshView];
        }
        //当前页面是否需要定位
        NSLog(@"this is loction %ld",(long)_mlbModel.isLoction);
        if (_mlbModel.isLoction ==1) {
            [self useLocation];
        }


//    if ([[self.currentUrl absoluteString] rangeOfString:@"/Video/Index"].length !=0) {
//        app.isBack =NO;
//    }else if([[self.currentUrl absoluteString] rangeOfString:@"/Video/DailyLesson"].length !=0){
//        app.isBack =YES;
//    }

}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获得所有html界面所有源代码
    //@"document.getElementsByTagName('html')[0].innerHTML"
    //获取当前页面的html
    //@"document.documentElement.innerHTML"
    //获得body的所有代码
    //@"document.body.innerHTML"
    return YES;
}



#pragma mark --EGORrfreshDelegate

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    return _reloading;
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}

-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    _isDownRefresh =YES;
    [_webView loadRequest:[NSURLRequest requestWithURL:self.currentUrl]];
}


#pragma mark --UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_rv egoRefreshScrollViewWillBeginScroll:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_rv egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_rv egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --RequestDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [SVProgressHUD show];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [SVProgressHUD dismiss];
    [_backData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    [SVProgressHUD dismiss];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    [UMSocialSnsService presentSnsIconSheetView:self appKey:APP_KEY shareText:_mlbModel.shareTitle shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToSms,nil] delegate:self];
    //
    [UMSocialData defaultData].extConfig.wechatSessionData.url =_mlbModel.shareUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareImage =[UIImage imageWithData:_backData];

    [UMSocialData defaultData].extConfig.wechatTimelineData.url =_mlbModel.shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage =[UIImage imageWithData:_backData];

    [UMSocialData defaultData].extConfig.wechatFavoriteData.url =_mlbModel.shareUrl;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.shareImage =[UIImage imageWithData:_backData];

    [UMSocialData defaultData].extConfig.qqData.url =_mlbModel.shareUrl;
    [UMSocialData defaultData].extConfig.qqData.shareImage =[UIImage imageWithData:_backData];

    [UMSocialData defaultData].extConfig.qzoneData.url =_mlbModel.shareUrl;
    [UMSocialData defaultData].extConfig.qzoneData.shareImage =[UIImage imageWithData:_backData];

    //短信分享内容
    [UMSocialData defaultData].extConfig.smsData.shareImage =nil;
    NSString * tmpStr =[NSString stringWithFormat:@"%@ %@",_mlbModel.shareTitle,_mlbModel.shareUrl];
    [UMSocialData defaultData].extConfig.smsData.shareText =tmpStr;


}

#pragma mark --ShareDelegate
//第三方分享的回调
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [UMSocialSnsService handleOpenURL:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [UMSocialSnsService handleOpenURL:url];
}


#pragma mark --SpecialViewDelegate
-(void)popwithUrl:(NSURL *)url{
    self.currentUrl =url;

    NSURLRequest * reuqest =[NSURLRequest requestWithURL:self.currentUrl];
    [_webView loadRequest:reuqest];
}
@end
