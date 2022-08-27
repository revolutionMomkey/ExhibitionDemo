//
//  ViewController.m
//  ExhibitionDemo
//
//  Created by 杜俊楠 on 2022/8/26.
//


#import "ViewController.h"
#import "PLView.h"

@interface ViewController ()<PLViewDelegate>

@property (nonatomic, strong) PLView *plView;

@property (nonatomic, assign) bool isFirstExhibition;

@property (nonatomic, strong) UIView *showingPrintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.plView = [[PLView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.plView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _isFirstExhibition = true;
    
    self.plView.delegate = self;
    [self exhibition];
}

- (void)exhibition {
    
    PLRotation ro = PLRotationMake(0.0, 0.0, 0.0);
    [self.plView.camera resetCurrentC:ro Pitch:ro.pitch yaw:ro.yaw];
    NSObject<PLIPanorama> *panorama = nil;
    //尺寸必须符合
    //Spherical2 panorama example (supports up 4096x2048 texture)
    PLCubicPanorama *cubicPanorama = [PLCubicPanorama panorama];

    if(_isFirstExhibition) {

        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Front" ofType:@"jpg"]]] face:PLCubeFaceOrientationFront];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Back" ofType:@"jpg"]]] face:PLCubeFaceOrientationBack];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Left" ofType:@"jpg"]]] face:PLCubeFaceOrientationLeft];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Right" ofType:@"jpg"]]] face:PLCubeFaceOrientationRight];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Up" ofType:@"jpg"]]] face:PLCubeFaceOrientationUp];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r1_Down" ofType:@"jpg"]]] face:PLCubeFaceOrientationDown];
        panorama = cubicPanorama;
        //艺术点
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        PLHotspot *hotspot = [PLHotspot hotspotWithId:1011 texture:hotspotTexture atv:-5.3f ath:10.5f width:0.03f height:0.03f];
        [panorama addHotspot:hotspot];
        //行走点
        PLTexture *hotspotTexture_arrow = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot_arrow" ofType:@"png"]]];
        PLHotspot *hotspot_arrow = [PLHotspot hotspotWithId:2001 texture:hotspotTexture_arrow atv:-30.0f ath:-110.0f width:0.045f height:0.012f];
        [panorama addHotspot:hotspot_arrow];
        [self.plView setPanorama:panorama];
    }
    else {
        
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Front" ofType:@"jpg"]]] face:PLCubeFaceOrientationFront];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Back" ofType:@"jpg"]]] face:PLCubeFaceOrientationBack];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Left" ofType:@"jpg"]]] face:PLCubeFaceOrientationLeft];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Right" ofType:@"jpg"]]] face:PLCubeFaceOrientationRight];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Up" ofType:@"jpg"]]] face:PLCubeFaceOrientationUp];
        [cubicPanorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"r2_Down" ofType:@"jpg"]]] face:PLCubeFaceOrientationDown];
        panorama = cubicPanorama;
        //艺术点
        PLTexture *hotspotTexture = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot" ofType:@"png"]]];
        PLHotspot *hotspot1 = [PLHotspot hotspotWithId:1021 texture:hotspotTexture atv:-5.3f ath:52.5f width:0.03f height:0.03f];
        [panorama addHotspot:hotspot1];
        PLHotspot *hotspot2 = [PLHotspot hotspotWithId:1022 texture:hotspotTexture atv:-4.4f ath:61.0f width:0.03f height:0.03f];
        [panorama addHotspot:hotspot2];
        //行走点
        PLTexture *hotspotTexture_arrow = [PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"hotspot_arrow" ofType:@"png"]]];
        PLHotspot *hotspot_arrow = [PLHotspot hotspotWithId:2002 texture:hotspotTexture_arrow atv:-20.0f ath:-150.0f width:0.045f height:0.012f];
        [panorama addHotspot:hotspot_arrow];
        [self.plView setPanorama:panorama];
    }
}

- (UIView *)printShowWith:(NSString *)name withContent:(NSString *)content {
    
    UIView *backgroundPrintView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundPrintView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    backgroundPrintView.hidden = YES;
    backgroundPrintView.userInteractionEnabled = YES;
    
    UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    contentView.image = [UIImage imageNamed:name];
    contentView.center = CGPointMake(self.view.bounds.size.width/2, 200);
    [backgroundPrintView addSubview:contentView];
    
    UILabel *laber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    laber.center = CGPointMake(self.view.bounds.size.width/2, 340);
    laber.textColor = [UIColor whiteColor];
    laber.text = content;
    [backgroundPrintView addSubview:laber];
    
    [backgroundPrintView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(printViewDismiss)]];
    [self.view addSubview:backgroundPrintView];
    backgroundPrintView.hidden = NO;
    
    return backgroundPrintView;
}

- (void)printViewDismiss {
    if (self.showingPrintView) {
        [self.showingPrintView removeFromSuperview];
    }
}

//Hotspot event
-(void)view:(UIView<PLIView> *)pView didClickHotspot:(PLHotspot *)hotspot screenPoint:(CGPoint)point scene3DPoint:(PLPosition)position {
    NSLog(@"点了个点");
    switch (hotspot.identifier) {
        case 1011:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"<<该艺术品的名字>>" message:@"该艺术品的信息" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }break;
        case 1021:{
            self.showingPrintView = [self printShowWith:@"r2_demo1.jpg" withContent:@"此处是<<星空>>的若干说明........"];
        }break;
        case 1022:{
            self.showingPrintView = [self printShowWith:@"r2_demo2.jpg" withContent:@"此处是<<日出·映像>>的若干说明........"];
        }break;
        case 2001:{
            
        };
        case 2002:{
            [self changeExhibitionRoom];
        }break;
            
        default:
            break;
    }
}

- (void)changeExhibitionRoom {
    _isFirstExhibition = !_isFirstExhibition;
    [self exhibition];
}

@end
