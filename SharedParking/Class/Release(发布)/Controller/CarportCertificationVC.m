//
//  CarportCertificationVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportCertificationVC.h"
#import "ReleaseModel.h"
@interface CarportCertificationVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *equityImgView;
@property (strong, nonatomic) IBOutlet UIButton *equityBtn;
@property (strong, nonatomic) IBOutlet UIImageView *carportImgView;
@property (strong, nonatomic) IBOutlet UIButton *carportBtn;
@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) IBOutlet UILabel *infoLab;

@property (nonatomic, strong)UIImagePickerController *pickerController;
@property (nonatomic , assign) BOOL isCarport;
@end

@implementation CarportCertificationVC
- (instancetype)initWithType:(CarportRentType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    self.scrollView.contentSize = CGSizeMake(0, self.confirmBtn.bottom + 100);
    self.bgView.height = self.confirmBtn.bottom + 100;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView{
    self.title = @"车位认证";
    
    [self.equityBtn lc_imageTitleVerticalAlignmentWithSpace:25];
    [self.carportBtn lc_imageTitleVerticalAlignmentWithSpace:25];
    self.equityBtn.userInteractionEnabled = NO;
    self.carportBtn.userInteractionEnabled = NO;
  
    self.equityImgView.userInteractionEnabled = YES;
    self.carportImgView.userInteractionEnabled = YES;

    [self.equityImgView zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        self.isCarport = NO;
        [self addPhoto];
    }];
    
    [self.carportImgView zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        self.isCarport = YES;
        [self addPhoto];
    }];
    
    
    self.infoLab.text = @"温馨提示：\n1.为了确保您的车位顺利审核，请提交正确的车位信息。\n2.审核过程中，客服人员将会与您核对车位信息，请您保持电话畅通。\n3.车位注册成功后可自由管理车位。";

}

#pragma mark ---------------network ---------------------/
- (void)releaseShortData{
    NSData *equityData = UIImageJPEGRepresentation(self.equityImgView.image, 1);
    NSData *carportData = UIImageJPEGRepresentation(self.carportImgView.image, 1);
    
    kSelfWeak;
    self.confirmBtn.userInteractionEnabled = NO;
    [WSProgressHUD show];
    [ReleaseModel releaseShortWithParkId:self.model.park_id parkNum:self.model.parking_number carType:self.model.parking_cheweitype object:self.model.parking_obj remark:self.model.remark carImg:equityData carportImg:carportData success:^(StatusModel *statusModel) {
        kSelfStrong;
        strongSelf.confirmBtn.userInteractionEnabled = YES;
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf backToSuperView];
        }
    }];
}

- (void)releaseLongData{
    NSData *equityData = UIImageJPEGRepresentation(self.equityImgView.image, 1);
    NSData *carportData = UIImageJPEGRepresentation(self.carportImgView.image, 1);
    
    kSelfWeak;
    self.confirmBtn.userInteractionEnabled = NO;
    [WSProgressHUD show];
    [ReleaseModel releaseLongWithTitle:self.model.parking_title parkId:self.model.park_id parkNum:self.model.parking_number price:self.model.parking_fee telNum:self.model.user_mobile carType:self.model.parking_cheweitype object:self.model.parking_obj remark:self.model.remark carImg:equityData carportImg:carportData success:^(StatusModel *statusModel) {
        kSelfStrong;
        strongSelf.confirmBtn.userInteractionEnabled = YES;
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf backToSuperView];
        }
    }];
}

#pragma mark ---------------event ---------------------/
- (void)addPhoto{
    [UIActionSheet actionSheetWithTitle:@"添加产权证明"
                      cancelButtonTitle:@"取消"
                 destructiveButtonTitle:nil
                           buttonTitles:@[@"拍照",@"相册"]
                             showInView:self.view
                              onDismiss:^(int buttonIndex, NSString *buttonTitle) {
                                  if (buttonIndex == 0) {//相机
                                      NSLog(@"支持相机");
                                      [self makePhoto];
                                     
                                  }else if (buttonIndex == 1){//相片
                                      NSLog(@"支持相册");
                                      [self choosePicture];
                                  }
                              } onCancel:nil];
}

- (IBAction)confirmAction:(id)sender {
    DLog(@"111");
    if (!self.equityImgView.image) {
        [WSProgressHUD showImage:nil status:@"请上传产权证明图"];
        return;
    }
    
    if (!self.carportImgView.image) {
        [WSProgressHUD showImage:nil status:@"请上传车位图片"];
        return;
    }
    
    if (self.type == CarportShortRentType) {
        [self releaseShortData];
    }else{
        [self releaseLongData];
    }
}


#pragma mark - photoViewControllerDelegate
//跳转到imagePicker里
- (void)makePhoto{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"支持相机");
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
        [alert show];
    }
    
}
//跳转到相册
- (void)choosePicture{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        NSLog(@"支持相册");
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"我知道了", nil];
        [alert show];
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate  上传头像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    if (self.isCarport) {
        self.carportImgView.image = image;
        self.carportBtn.hidden = YES;
    }else{
        self.equityImgView.image = image;
        self.equityBtn.hidden = YES;
    }

    //当image从相机中获取的时候存入相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//这个地方只做一个提示的功能
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        DLog(@"保存失败");
    }else{
        DLog(@"保存成功");
    }
}


#pragma mark ---------------lazy ---------------------/
- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
        _pickerController.view.backgroundColor = [UIColor orangeColor];
        _pickerController.delegate = self;
    }
    return _pickerController;
}

@end
