//
//  EditVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "EditVC.h"

#import "UIImage+SGHelper.h"
#import "PhotoViewController.h"
#import "UIImage+Crop.h"

@interface EditVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nicknameField;
@property (strong, nonatomic) IBOutlet UITextField *zhifubaoField;
@property (strong, nonatomic) IBOutlet UILabel *telLab;
@property (strong, nonatomic) IBOutlet UILabel *headLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;

@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) NSData *imgData;
@property (nonatomic, strong)UIImagePickerController *pickerController;
@end

@implementation EditVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"编辑";
    
    [self initView];
    [self loadData];
}

- (void)initView{
    
    self.headImgView.userInteractionEnabled = YES;
    [self.headImgView zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self selectHeadImage];
    }];
    
    [self.headLab zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self selectHeadImage];
    }];
}

- (void)backToSuperView{
    
    DLog(@"%@-----%@",self.nicknameField.text,self.zhifubaoField.text);
    if (![self.userModel.realname isEqualToString:self.nicknameField.text] || ![self.userModel.alipay_account isEqualToString:self.zhifubaoField.text] || self.imgData) {
        [self updateData];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ---------------network ---------------------/
- (void)loadData{
    kSelfWeak;
    [UserModel getMineDataSuccess:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.userModel = statusModel.data;
            [strongSelf setUserData];
            
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }

    }];
}

- (void)setUserData{
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:kImageStringJoint(self.userModel.headimg)]];
    
    self.nicknameField.text = self.userModel.realname;
    self.zhifubaoField.text = self.userModel.alipay_account;
}

- (void)updateData{
    kSelfWeak;
    [UserModel updateUserInfoWithNickname:self.nicknameField.text alipayNum:self.zhifubaoField.text headImg:self.imgData success:^(StatusModel *statusModel) {
        kSelfStrong;
        [WSProgressHUD showImage:nil status:statusModel.message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark ---------------event ---------------------/
- (void)selectHeadImage{
    DLog(@"选择图片");
    [UIActionSheet actionSheetWithTitle:@"选择获取头像"
                      cancelButtonTitle:@"取消"
                 destructiveButtonTitle:nil
                           buttonTitles:@[@"相册"]
                             showInView:self.view
                              onDismiss:^(int buttonIndex, NSString *buttonTitle) {
                                  [self presentViewController:self.pickerController animated:YES completion:nil];
                              } onCancel:nil];
}


#pragma mark - photoViewControllerDelegate
- (void)imageCropper:(PhotoViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    editedImage = [UIImage imageWithImage:editedImage scaledToSize:CGSizeMake(200, 200)];
    self.headImgView.image = editedImage;
    self.imgData = UIImageJPEGRepresentation(editedImage, 0.7);
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageCropperDidCancel:(PhotoViewController *)cropperViewController{
    [cropperViewController.navigationController popViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate  上传头像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [UIImage fitScreenWithImage:image];
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.oldImage = image;
    //    photoVC.backImage = ;自定义返回按钮图片
    photoVC.mode = PhotoMaskViewModeSquare;
    photoVC.cropWidth = kScreenWidth-30*2;
    photoVC.cropHeight = kScreenWidth-30*2;
    photoVC.delegate = self;
    photoVC.lineColor = [UIColor whiteColor];
    [picker pushViewController:photoVC animated:YES];
}
#pragma mark ---------------lazy ---------------------/

- (UIImagePickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return _pickerController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
