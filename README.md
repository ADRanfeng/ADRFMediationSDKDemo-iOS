# ADRFMediationSDK iOS接入文档 v3.7.9.10303


## 修订历史

[SDK版本更新日志](http://adssp.ranfenghd.com/doc/pages/e8597f/)
<div STYLE="page-break-after: always;"></div>



## 1.1 概述

尊敬的开发者朋友，欢迎您使用然峰广告SDK。通过本文档，您可以在几分钟之内轻松完成广告的集成过程。

操作系统： iOS 10.0 及以上版本

运行设备：iPhone （iPad上可能部分广告正常展示，但是存在填充很低或者平台不支持等问题，建议不要在iPad上展示广告，穿山甲等平台开屏广告iPad端展示异常）

- `ADRFMediationSDK Objective-C Demo地址`[[ADRFMediationSDK Objective-C Demo]](https://github.com/ADRanfeng/adrfmediation-sdk-ios)
- `ADRFMediationSDK Swift Demo地址`[[ADRFMediationSDK Swift Demo]](https://github.com/ADRanfeng/adrfmediation-sdk-swift)



## 1.2 ADRFMediationSDK&三方广告平台适配器版本(以日志输出为准)
| Name         | 版本号      |  
|--------------|-------------|           
| ADRFMediationSDK | 3.7.9.10303 |    
| rfads | 2.1.0.1.11271 |
| tianmu | 2.1.0.1.11271 |    
| baidu | 5.324.08141 |    
| gdt | 4.14.45.08142 |    
| ksad | 3.3.53.08141 |       
| toutiao | 5.7.0.7.10303 |        


## 2.1 采用cocoapods进行SDK的导入

推荐使用pod命令

```ruby
// 挑选在托管的平台导入项目，请不要导入全部，如果不清楚需要哪些平台可以咨询我们

pod 'ADRFMediationSDK','~> 3.7.9.10303' # 主SDK 必选
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/tianmu'     # 天目 必选
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/rfads'      # 然峰Ads
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/gdt'        # 优量汇(广点通）
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/bu'         # 穿山甲(头条)
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/ks'         # 快手
pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/baidu'      # 百度
```

### 2.1.1 注意事项

`pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/xxxx'` 默认集成了一个固定版本的三方SDK，如果因为项目中也使用了相同的三方广告SDK而发生冲突，可通过以下方法尝试避免或解决；


- 通过 Pod 我们的 __xxx-without__ 依赖，该方式没有绑定三方广告SDK，开发者可自行集成三方广告SDK，但是需要注意，我们的AdapterSdk是基于三方广告SDK某个版本开发的，如果自行集成三方广告SDK，需要承担三方广告SDK版本不一致可能引起的兼容性和其他不可预知问题；



    ```
    # 例如：
    
    pod 'ADRFMediationSDK/ADRFMediationSDKPlatforms/gdt-without'        # 优量汇(广点通）
    
    ```




<div STYLE="page-break-after: always;"></div>


## 2.2 手动导入SDK方式

[点击进入SDK下载地址](https://oss-saas-developer.oss-cn-beijing.aliyuncs.com/sdk_files/ADRFMediationSDK_iOS_37910303_744a8cfb490099ee0cf1bc9278df2880.zip)下载各SDK拖入到工程中

若有KSAdSDK，打开项目的 app target，查看 General 中的 Frameworks, Libraries, and Embedded Content 选项，将KSAdSDK置为Embed & Sign

若需要在模拟器运行，打开项目的 app target，查看 Build Settings选项，设置Excluded Architectures下的 Any iOS Simulator SDK 值为 arm64

手动方式导入,需要添加如下依赖库:

```obj-c
AdSupport.framework
CoreLocation.framework
QuartzCore.framework
SystemConfiguration.framework
CoreTelephony.framework
libz.tbd
libc++.tbd
libresolv.9.tbd
WebKit.framework (Optional)
libxml2.tbd
Security.framework
StoreKit.framework
AVFoundation.framework
CoreMedia.framework
```

头条还需要添加依赖库：

```obj-c
DeviceCheck.framework
Accelerate.framework
AudioToolbox.framework
CoreGraphics.framework
CoreImage.framework
CoreMotion.framework
CoreText.framework
ImageIO.framework
JavaScriptCore.framework
MapKit.framework
MediaPlayer.framework
MobileCoreServices.framework
UIKit.framework
libbz2.tbd
libiconv.tbd
libsqlite3.tbd
libc++abi.tbd
```

<div STYLE="page-break-after: always;"></div>

<div STYLE="page-break-after: always;"></div>




## 3.1 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 
3. 苹果公司在iOS9中升级了应用网络通信安全策略，默认推荐开发者使用HTTPS协议来进行网络通信，并限制HTTP协议的请求。为了避免出现无法拉取到广告的情况，我们推荐开发者在info.plist文件中增加如下配置来实现广告的网络访问：（信任HTTP请求）

```obj-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

4. SDK 不会主动获取应用位置权限，当应用本身有获取位置权限逻辑时，需要在应用的 info.plist 添加相应配置信息，避免 App Store 审核被拒：

```obj-c
Privacy - Location When In Use Usage Description
Privacy - Location Always and When In Use Usage Description
Privacy - Location Always Usage Description
```

5. Info.plist 添加获取本地网络权限字段
    ```obj-c
    <key>Privacy - Local Network Usage Description</key>
    <string>广告投放及广告监测归因、反作弊</string>
    <key>Bonjour services</key>
    <array>
        <string>_apple-mobdev2._tcp.local</string>
   </array>
    ```

6. Info.plist推荐设置白名单，可提高广告收益

```obj-c
<key>LSApplicationQueriesSchemes</key>
    <array>
        <!--  电商及生活   -->
        <string>com.suning.SuningEBuy</string> <!--  苏宁  -->
        <string>openapp.jdmobile</string> <!--  京东  -->  
        <string>openjd</string> <!--  京东  --> 
        <string>jdmobile</string> <!--  京东  --> 
        <string>vmall</string>
        <string>vipshop</string>  <!--  维品汇  -->  
        <string>suning</string> <!--  苏宁  --> 
        <string>yohobuy</string> <!--  有货  --> 
        <string>kaola</string> <!--  网易考拉  --> 
        <string>yanxuan</string> <!--  网易严选  --> 
        <string>wbmain</string>  <!--  58同城  --> 
        <string>dianping</string>  <!--  大众点评  --> 
        <string>imeituan</string>  <!--  美团  --> 
        <string>beibeiapp</string> <!--  贝贝  --> 
        <string>taobao</string> <!--  淘宝  --> 
        <string>tmall</string>  <!--  天猫  --> 
        <string>wireless1688</string> <!--  阿里巴巴1688  --> 
        <string>tbopen</string> <!--  淘宝  --> 
        <string>taobaolite</string> <!-- 淘特   --> 
        <string>taobaoliveshare</string> <!--  淘宝直播  --> 
        <string>koubei</string> <!--  口碑  --> 
        <string>eleme</string> <!--  饿了么  --> 
        <string>alipays</string> <!--  支付宝  --> 
        <string>kfcapplinkurl</string> <!--  KFC  --> 
        <string>pddopen</string> <!--  拼多多  --> 
        <string>pinduoduo</string> <!--  拼多多  --> 
        <string>mogujie</string> <!--  蘑菇街  --> 
        <string>lianjiabeike</string> <!--  链家贝壳  --> 
        <string>lianjia</string> <!--  链家  --> 
        <string>openanjuke</string> <!--  安居客  --> 
        <string>zhuanzhuan</string> <!--  转转  --> 
        <string>farfetchCN</string> <!--  发发奇全球时尚购物  --> 
        <!--  社交社区  --> 
        <string>weibo</string> <!--  微博  --> 
        <string>xhsdiscover</string> <!--  小红书  --> 
        <string>uclink</string> <!--  uc浏览器  --> 
        <string>momochat</string> <!--  陌陌  --> 
        <string>blued</string> <!--  Blued  --> 
        <string>zhihu</string> <!--  知乎  --> 
        <string>baiduboxapp</string> <!--  手机百度  --> 
        <string>yidui</string> <!--  伊对  --> 
        <!--  资讯及阅读  -->    
        <string>sinanews</string> <!--  新浪新闻  --> 
        <string>snssdk141</string> <!--  今日头条  --> 
        <string>newsapp</string> <!--  网易新闻  --> 
        <string>igetApp</string> <!--  得到  -->  
        <string>kuaikan</string> <!--  快看漫画  --> 
        <!--  短视频及音乐  -->         
        <string>youku</string> <!--  优酷  --> 
        <string>snssdk1128</string> <!--  抖音  --> 
        <string>gifshow</string> <!--  快手  --> 
        <string>snssdk1112</string> <!--  火山  --> 
        <string>miguvideo</string> <!--  咪咕视频  --> 
        <string>iqiyi</string> <!--  爱奇艺  --> 
        <string>bilibili</string> <!--  B站  -->   
        <string>tenvideo</string> <!--  腾讯视频  --> 
        <string>baiduhaokan</string> <!--  百度好看  --> 
        <string>yykiwi</string> <!--  虎牙直播  --> 
        <string>qqmusic</string> <!--  qq音乐  -->  
        <string>orpheus</string> <!--  网易云音乐  --> 
        <string>kugouURL</string> <!--  酷狗  -->   
        <string>qmkege</string> <!--  全民K歌  -->  
        <string>changba</string> <!--  唱吧  --> 
        <string>iting</string> <!--  喜马拉雅  --> 
        <!--  出行  -->                 
        <string>ctrip</string> <!--  携程  --> 
        <string>QunarAlipay</string> <!--  去哪儿旅行  --> 
        <string>diditaxi</string> <!--  滴滴出行  --> 
        <string>didicommon</string> <!--  滴滴出行  --> 
        <string>taobaotravel</string> <!--  飞猪  --> 
        <string>OneTravel</string> <!--  海南航空  --> 
        <string>kfhxztravel</string> <!--  花小猪  --> 
        <!--  医美  -->             
        <string>gengmei</string> <!--  更美  --> 
        <string>app.soyoung</string> <!--  新氧医美  --> 
    </array>
```



## 3.2 iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。敬请知悉。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 升级ADRFMediationSDK 3.6.0及以上版本；
3. 设置SKAdNetwork和IDFA权限；



### 3.2.1 获取App Tracking Transparency授权（弹窗授权获取IDFA）

从 iOS 14 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 更新 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。

   弹窗小字文案建议：

   - `获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`
   - `获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。`

```objective-c
<key>NSUserTrackingUsageDescription</key>
<string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭</string>
```

2. 向用户申请权限。

```objective-c
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
...
- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    // 无需对授权状态进行处理
  }];
}
// 建议启动App用户同意协议后就获取权限或者请求广告前获取
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
         // 针对iOS15中不弹窗被拒解决方案，方案1：经测试可能无效
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),             dispatch_get_main_queue(), ^{
            // 用户同意协议后获取
                      //[self requestIDFA];
        //});
}
// 方案2：根据官方文档调整权限申请时机
// 根据官方开发文档选择在此方法中进行权限申请
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 用户同意协议后获取
      [self requestIDFA];
}
// 建议方案1与2一起使用，可正常通过审核。
```

<div STYLE="page-break-after: always;"></div>



### 3.2.2 SKAdNetwork

SKAdNetwork 是接收iOS端营销推广活动归因数据的一种方法。

1. 将下列SKAdNetwork ID（供参考，需以穿山甲官网为准）添加到 info.plist 中，以保证 SKAdNetwork 的正确运行。根据对接平台添加相应SKAdNetworkID，若无对接平台SKNetworkID则无需添加。

```xml
<key>SKAdNetworkItems</key>
  <array>
    // 穿山甲广告（ADRFMediationBU）
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>x2jnk7ly8j.skadnetwork</string>
    </dict>
  </array>
```

<div STYLE="page-break-after: alway;"></div>

## 4.1 集合SDK的初始化

`申请的appid必须与您的包名一一对应`


```obj-c
// ADRFMediationSDK 初始化, 需在主线程初始化(忽略提示)
[ADRFMediationSDK initWithAppId:@"3283986" completionBlock:^(NSError * _Nonnull error) {
    if (error) {
        NSLog(@"SDK 初始化失败：%@", error.localizedDescription);
    }
}];
```

用户日志输出等级

```obj-c
添加头文件
#import <ADRFMediationKit/ADRFMediationKitLogging.h>

// 设置日志输出等级
[ADRFMediationSDK setLogLevel:ADRFMediationKitLogLevelDebug];
```

获取ADRFMediationSDK版本号

```obj-c
//获取SDK版本号
NSString *sdkVersion = [ADRFMediationSDK getSDKVersion];
```

<div STYLE="page-break-after: always;"></div>


## 4.2 个性化开关

ADRFMediation的个性化开关可统一控制第三方广告SDK的个性化开关接口，目前支持天目、穿山甲、优量汇、百度、快手;

```obj-c
// 是否开启个性化广告；默认YES，建议初始化SDK之前设置
ADRFMediationSDK.enablePersonalAd = NO;
```

<div STYLE="page-break-after: always;"></div>


## 4.3 开屏广告 - ADRFMediationSDKSplashAd

开屏广告会在您的应用开启时加载展示，拥有固定展示时间，展示完毕后自动关闭并进入您的应用主界面。

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费。

推荐在 `AppDelegate`的 `didFinishLaunchingWithOptions`方法的 `return YES`之前调用开屏。

`OC请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-ios/blob/master/ADRFMediationSDKDemo-iOS/AppDelegate.m)

`Swift请求开屏代码示例：`[[开屏代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/AppDelegate.swift)

**ADRFMediationSDKSplashAd**: 开屏广告的加载类
| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADRFMediationSDKSplashAdDelegate> | 委托对象 |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id（可选）  |
| backgroundColor | UIColor | 开屏的默认背景色,或者启动页,为nil则代表透明  |
| userId | NSString | 用户id （用户在App内的userID，用于激励视频服务器验证，如无需服务器验证可不传）  |
| extra | NSString | 其他信息 （服务器端验证回调中包含的可选自定义奖励字符串，可选）  |
| tolerateTimeout | NSInteger | 开屏请求总超时时间 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| setBottomSplashWithRfPosid: platformListId: platform: appId: appKey: platformPosid: renderType: | 设置保底开屏 <br>支持平台：穿山甲、优量汇、快手、百度（可选） |
| loadAndShowInWindow: | 加载并展示开屏广告 |
| loadAndShowInWindow: withBottomView: | 加载并展示开屏广告；底部logo视图, 高度不能超过屏幕的25%，可传nil |
| loadAdInWindow: | 加载开屏广告 |
| loadAdInWindow: withBottomView: | 加载开屏广告；底部logo视图, 高度不能超过屏幕的25%，可传nil |
| showAdInWindow: | 展示开屏广告 |
| rewardAdCanServerVerrify | 开屏广告是否支持服务端验证<br>支持平台：优量汇 |


**ADRFMediationSDKSplashAdDelegate**：开屏代理方法
| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| ADRFMediation_splashAdSuccessToLoadAd: | 开屏加载成功  |
| ADRFMediation_splashAdSuccessToPresentScreen: | 开屏展示成功  |
| ADRFMediation_splashAdFailToPresentScreen: | 开屏展示失败  |
| ADRFMediation_splashAdEffective: | 开屏曝光  |
| ADRFMediation_splashAdClicked: | 开屏点击  |
| ADRFMediation_splashAdClosed: | 开屏关闭  |
| ADRFMediation_splashAdCloseLandingPage: | 开屏关闭落地页  |
| ADRFMediation_splashAdDidRewardEffective: info: | 开屏达到激励条件 （开启服务器验证后请使用服务端验证判断是否达到条件，无需使用本回调做激励达成判断）  |
| ADRFMediation_splashAdDidRewardEffective: info: | 开屏达到激励条件 （开启服务器验证后请使用服务端验证判断是否达到条件，无需使用本回调做激励达成判断） 备注：仅支持优量汇平台 |

```obj-c
特殊说明
/** 
 开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
 开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
 1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
 2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
 */

```

Swift请求开屏广告代码示例：[[开屏代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/AppDelegate.swift)

OC请求开屏广告代码示例：

```obj-c
#import <ADRFMediationSDK/ADRFMediationSDKSplashAd.h>
#import <ADRFMediationKit/ADRFMediationKit.h>

/*
 * 推荐在AppDelegate中的最后加载开屏广告
 * 其他的接入方式会有需要特殊注意的方式，遇到过的相关问题在SDK相关问题的文档中有提到
 * 不建议在开屏展示过程中做控制器的切换（如：开屏广告关闭回调时切换当前window的根控制器或者present另外一个控制器）
 */

- (void)loadSplashAd{
    // 1、初始化开屏广告实例对象
    self.splashAd = [[ADRFMediationSDKSplashAd alloc]init];
    self.splashAd.delegate = self;
    self.splashAd.controller = _window.rootViewController;
    // 2、设置开屏的广告位id
    self.splashAd.posId = @"88d136b3d8c8da294e";
    /**
    开屏请求总超时时间:所有平台轮询的请求等待总时长（不包括图片渲染时间），单位秒，推荐设置为4s，最小值为3s
    开屏各平台分配逻辑:(目前只有开屏需要分配时间，并且理论上分配给到各平台的超时时间不会完全耗尽)
    1、3<=tolerateTimeout<=4:轮询首位平台的超时时间为(tolerateTimeout-1)s，次位为2s，如果后续还有平台统一为1s;
    2、tolerateTimeout>=5:轮询首位平台的超时时间为(tolerateTimeout-2)s，次位为3s，如果后续还有平台统一为2s;
    */
    self.splashAd.tolerateTimeout = 4;
    // 3、设置默认启动图(一般设置启动图的平铺颜色为背景颜色，使得视觉效果更加平滑)
    self.splashAd.backgroundColor = [UIColor ADRFMediation_getColorWithImage:[UIImage imageNamed:@"750x1334.png"] withNewSize:[UIScreen mainScreen].bounds.size];
    
    // 4、开屏广告机型适配
    CGFloat bottomViewHeight;
    if (kADRFMediationCurveScreen) { // 刘海屏
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height * 0.15;
    } else {
        bottomViewHeight = [UIScreen mainScreen].bounds.size.height - [UIScreen mainScreen].bounds.size.width * (960 / 640.0);
    }
    
    // 5、底部视图设置，非必选项
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, bottomViewHeight);
    UIImageView *logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ADRFMediation_Logo.png"]];
    logoImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-135)/2, (bottomViewHeight-46)/2, 135, 46);
    [bottomView addSubview:logoImageView];
    
    // 6、加载开屏广告
    [self.splashAd loadAndShowInWindow:_window withBottomView:bottomView];
}

// 7、代理回调
#pragma mark - ADRFMediationSDKSplashAdDelegate
/**
 开屏展现成功
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdSuccessToPresentScreen:(ADRFMediationSDKSplashAd *)splashAd{

}

/**
 开屏展现失败
 
 @param splashAd 广告实例
 @param error 具体错误信息
 */
- (void)adrf_splashAdFailToPresentScreen:(ADRFMediationSDKSplashAd *)splashAd failToPresentScreen:(ADRFMediationAdapterErrorDefine *)error{
    _splashAd = nil;
}

/**ADRFMediationSDK
 开屏广告点击
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdClicked:(ADRFMediationSDKSplashAd *)splashAd{
    
}

/**
 开屏被关闭
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdClosed:(ADRFMediationSDKSplashAd *)splashAd{
    _splashAd = nil;
}

/**
 开屏展示
 
 @param splashAd 广告实例
 */
- (void)adrf_splashAdEffective:(ADRFMediationSDKSplashAd *)splashAd{
    
}

```

<div STYLE="page-break-after: always;"></div>


## 4.4 Banner横幅广告 - ADRFMediationSDKBannerAdView

Banner广告(横幅广告)位于app顶部、中部、底部任意一处，横向贯穿整个app页面；当用户与app互动时，Banner广告会停留在屏幕上，并可在一段时间后自动刷新。

`OC请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-ios/blob/master/ADRFMediationSDKDemo-iOS/RFMediationAds/BannerAd/ADRFMediationBannerViewController.m)

`Swift请求横幅代码示例：`[[横幅代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/BannerAd/ADRFMediationBannerViewController.swift)

**ADRFMediationSDKBannerAdView**: 横幅广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADRFMediationSDKBannerAdViewDelegate> | 委托对象  |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id（可选）  |
| refershTime | NSInteger | banner刷新时间间隔，30-120s之间；默认不刷新；<br>支持平台：穿山甲、百度、优量汇 |
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAndShow | 加载并展示广告 |
| loadAndShowWithError: | 加载并展示广告,已废弃请使用loadAndShow代替 |

**ADRFMediationSDKBannerAdViewDelegate**：横幅代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| adrf_bannerViewDidReceived: | 横幅广告加载成功 |
| adrf_bannerViewFailToReceived:errorModel: | 横幅广告加载失败 |
| adrf_bannerViewDidPresent: | 横幅广告展示 |
| adrf_bannerViewExposure: | 横幅广告曝光 |
| adrf_bannerViewClicked: | 横幅广告点击 |
| adrf_bannerViewClose: | 横幅广告关闭 |
| adrf_bannerAdCloseLandingPage: | 横幅广告关闭落地页 |

Swift请求横幅代码示例：[[横幅代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/BannerAd/ADRFMediationBannerViewController.swift)

OC请求横幅广告请求示例：

```obj-c
#import <ADRFMediationSDK/ADRFMediationSDKBannerAdView.h>

- (void)loadBannerWithRate:(CGFloat)rate posId:(NSString *)posId {
    [self.bannerView removeFromSuperview];
    self.bannerView.delegate = nil;
    self.bannerView = nil;
    
    // 1、初始化banner视图，并给定frame值，rate取值根据banner的尺寸
    self.bannerView = [[ADRFMediationSDKBannerAdView alloc] initWithFrame:CGRectMake(0, 250, kADRFMediationScreenWidth, kADRFMediationScreenWidth / rate)];
    self.bannerView.delegate = self;
    // 2、设置控制器，用来弹出落地页，重要
    self.bannerView.controller = self;
    // 3、设置广告位id，重要 测试可使用posId： 8caaf541ebc0f0b87e
    self.bannerView.posId = posId;
    self.bannerView.refershTime = 30;
    // 4、可先展示再请求
    [self.view addSubview:self.bannerView];
    self.bannerView.backgroundColor = [UIColor redColor];
    // 5、加载并展示
    [self.bannerView loadAndShow];
}

// 5、代理回调
#pragma mark - ADRFMediationSDKBannerAdViewDelegate
/**
 广告获取成功
 
 @param bannerView banner实例
 */
- (void)adrf_bannerViewDidReceived:(ADRFMediationSDKBannerAdView *)bannerView{
    
}

/**
 广告拉取失败
 
 @param bannerView banner实例
 @param errorModel 错误描述
 */
- (void)adrf_bannerViewFailToReceived:(ADRFMediationSDKBannerAdView *)bannerView errorModel:(ADRFMediationAdapterErrorDefine *)errorModel{
    NSLog(@"ADRFMediation_bannerViewFailToReceived:%@, %@",errorModel.errorDescription, errorModel.errorDetailDict);
    [_bannerView removeFromSuperview];
    _bannerView = nil;
}

/**
 广告点击
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewClicked:(ADRFMediationSDKBannerAdView *)bannerView{
    
}

/**
 广告关闭
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewClose:(ADRFMediationSDKBannerAdView *)bannerView{
    _bannerView = nil;
}

/**
 广告展示
 
 @param bannerView 广告实例
 */
- (void)adrf_bannerViewExposure:(ADRFMediationSDKBannerAdView *)bannerView{
    
}
```

<div STYLE="page-break-after: always;"></div>


## 4.5 信息流广告 - ADRFMediationSDKNativeAd

信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应。**请务必确保自渲染类型广告渲染时包含广告创意素材（至少包含一张图片）、平台logo、广告标识、关闭按钮；模板广告不得被遮挡。** **注意，信息流广告点击关闭时，开发者需要在- (void)adrf_nativeAdClose:回调中将广告视图隐藏或移除，避免如穿山甲渠道点击关闭后视图依旧存在问题**

`OC请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-ios/blob/master/ADRFMediationSDKDemo-iOS/RFMediationAds/NativeAd/ADRFMediationNativeViewController.m)

`Swift请求信息流广告代码示例：`[[信息流广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/NativeAd/ADRFMediationNativeViewController.swift)

**ADRFMediationSDKNativeAd**: 信息流广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADRFMediationSDKNativeAdDelegate> | 委托对象  |
| controller | UIViewController | [必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController  |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| muted | BOOL | 是否静音播放视频 默认YES <br>支持平台：天目、然峰广告、优量汇、百度、快手<br/> 特殊平台：穿山甲（需在穿山甲后台广告位配置处设置） |
| detailPageVideoMuted | BOOL | 是否静音播放详情页视频 默认YES <br>支持平台：优量汇 |
| autoPlay | BOOL | 信息流自动播放，默认WiFi自动播放 开启后WiFi/4G自动播放  |
| status | ADRFMediationSDKNativeAdStatus | 开发者可通过状态值来判断当前广告对象是否正在加载广告  |
| insets | UIEdgeInsets | 模板信息流内边距  默认（16，16，12，16）（部分平台支持，其余需后台设置）  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| load: | 加载广告,建议区间 1~5, 超过可能无法拉取到 |

**ADRFMediationSDKNativeAdDelegate**：信息流代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| ADRFMediation_nativeAdSucessToLoad:adViewArray: | 信息流广告加载成功 |
| ADRFMediation_nativeAdFailToLoad:errorModel | 信息流广告加载失败 |
| ADRFMediation_nativeAdViewRenderOrRegistSuccess: | 信息流广告渲染成功 |
| ADRFMediation_nativeAdViewRenderOrRegistFail: | 信息流广告渲染失败 |
| ADRFMediation_nativeAdExposure:adView: | 信息流广告曝光 |
| ADRFMediation_nativeAdClicked:adView: | 信息流广告点击 |
| ADRFMediation_nativeAdClose:adView: | 信息流广告关闭 |
| ADRFMediation_nativeAdCloseLandingPage:adView: | 信息流广告关闭落地页 |
| ADRFMediation_nativeAd:adView:playerStatusChanged: | 视频类型信息流广告player 播放状态更新回调 |


Swift请求信息流广告代码示例：[[信息流广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/NativeAd/ADRFMediationNativeViewController.swift)

OC请求信息流广告请求示例：

```obj-c
#import <ADRFMediationSDK/ADRFMediationSDKNativeAd.h>

if(!_nativeAd) {
   // 1、信息流广告初始化 建议将高度设置为0；信息流会根据传入的宽度返回相应比例的高度
   _nativeAd = [[ADRFMediationSDKNativeAd alloc] initWithAdSize:CGSizeMake(self.tableView.frame.size.width, 0)];
   // 2、传入posId，重要 测试可使用posId:0ee1184a15a310284e
   _nativeAd.posId = self.posId;
   _nativeAd.delegate = self;
   _nativeAd.controller = self;
}
// 3、加载信息流广告
[_nativeAd load:1];

// 4、代理回调
#pragma mark - ADRFMediationSDKNativeAdDelegate
- (void)adrf_nativeAdSucessToLoad:(ADRFMediationSDKNativeAd *)nativeAd
                      adViewArray:(NSArray<__kindof UIView<ADRFMediationAdapterNativeAdViewDelegate> *> *)adViewArray {
    for (UIView<ADRFMediationAdapterNativeAdViewDelegate> *adView in adViewArray) {
        // 4、判断信息流广告是否为自渲染类型
        if(adView.renderType == ADRFMediationAdapterRenderTypeNative) {
            // 4.1、如果是自渲染类型则可样式自定义
            [self setUpUnifiedNativeAdView:adView];
        }
        // 5、注册，自渲染：注册点击事件，模板：render，重要
        [adView ADRFMediation_registViews:@[adView]];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

// 渲染成功回调
- (void)adrf_nativeAdViewRenderOrRegistSuccess:(UIView<ADRFMediationAdapterNativeAdViewDelegate> *)adView {
    // 6、注册或渲染成功，此时高度正常，可以展示
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i ++) {
            [self.items addObject:[NSNull null]];
        }
        [self.items addObject:adView];
        [self.tableView reloadData];
    });
}

- (void)adrf_nativeAdClose:(ADRFMediationSDKNativeAd *)nativeAd
                    adView:(__kindof UIView<ADRFMediationAdapterNativeAdViewDelegate> *)adView {
    for (id item in _items) {
        if(item == adView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [adView ADRFMediation_unRegistView];
                [self.items removeObject:adView];
                [self.tableView reloadData];
            });
        }
    }
}
```

<div STYLE="page-break-after: always;"></div>


## 4.6 激励视频广告 - ADRFMediationSDKRewardvodAd

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景。

`OC请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-ios/blob/master/ADRFMediationSDKDemo-iOS/RFMediationAds/RewardVodAd/ADRFMediationRewardvodViewController.m)

`Swift请求激励视频代码示例：`[[激励视频广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/RewardAd/ADRFMediationRewardViewController.swift)

**ADRFMediationSDKRewardvodAd**: 激励视频广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADRFMediationSDKRewardvodAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| userId | NSString | 用户id （用户在App内的userID，用于激励视频服务器验证，如无需服务器验证可不传）  |
| rewardName | NSString | 奖励名称 （用于激励视频服务器验证参数，可选）  |
| rewardAmount | NSString | 奖励数量 （用于激励视频服务器验证参数，可选）  |
| extraInfo | NSString | 其他信息 （服务器端验证回调中包含的可选自定义奖励字符串，可选）|
| tolerateTimeout | NSInteger | 请求超时时间,默认为4s,需要设置3s及以上  |
| isMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇，快手 |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadRewardvodAd | 加载激励视频广告 |
| showRewardvodAd | 展示激励视频广告 |
| rewardvodAdIsValid | 激励视频广告物料是否有效 |
| rewardvodAdIsReady | 激励视频广告是否准备好 |
| rewardvodAdCanServerVerrify | 激励视频广告是否支持服务端验证 <br>支持平台：穿山甲、优量汇、百度、快手|

**ADRFMediationSDKRewardvodAdDelegate**：激励视频代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| ADRFMediation_rewardvodAdLoadSuccess: | 激励视频广告加载成功 |
| ADRFMediation_rewardvodAdFailToLoad:errorModel: | 激励视频广告加载失败 |
| ADRFMediation_rewardvodAdReadyToPlay: | 激励视频广告准备好播放 |
| ADRFMediation_rewardvodAdPlaying:errorModel: | 激励视频广告播放时错误回调 |
| ADRFMediation_rewardvodAdVideoLoadSuccess: | 视频数据下载成功回调，已经下载过的视频会直接回调 |
| ADRFMediation_rewardvodAdWillVisible: | 激励视频广告播放页即将展示 |
| ADRFMediation_rewardvodAdDidVisible: | 激励视频广告曝光 |
| ADRFMediation_rewardvodAdDidRewardEffective: | 激励视频广告达到激励条件 |
| ADRFMediation_rewardvodAdServerDidSucceed: | 激励视频服务验证成功（需等待服务器返回结果后判断是否激励生效） |
| ADRFMediation_rewardvodAdServerDidSucceed:info: | 激励视频服务验证成功（需等待服务器返回结果后判断是否激励生效）,并携带服务验证三方返回的相关参数 |
| ADRFMediation_rewardvodAdServerDidFailed:errorModel: | 激励视频服服务验证失败 |
| ADRFMediation_rewardvodAdDidPlayFinish: | 激励视频广告播放完成 |
| ADRFMediation_rewardvodAdDidClick: | 激励视频广告点击 |
| ADRFMediation_rewardvodAdDidClose: | 激励视频广告关闭 |
| ADRFMediation_rewardvodAdCloseLandingPage: | 激励视频广告关闭落地页 |


Swift请求激励视频代码示例：[[激励视频广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/RewardAd/ADRFMediationRewardViewController.swift)

OC请求激励视频代码示例：

```obj-c
#import <ADRFMediationSDK/ADRFMediationSDKRewardvodAd.h>

- (void)loadRewardvodAd{
    // 1、初始化激励视频广告
    self.rewardvodAd  = [[ADRFMediationSDKRewardvodAd alloc]init];
    self.rewardvodAd.delegate = self;
    self.rewardvodAd.tolerateTimeout = 5;
    self.rewardvodAd.controller = self;
    self.rewardvodAd.posId = @"a2b2644e75983ae44d";
      // 以下参数如不需服务端验证可不传
      self.rewardvodAd.userId = @"xxx";
    self.rewardvodAd.extraInfo = @"这是一个激励视频生效验证";
    self.rewardvodAd.rewardName = @"看视频得金币";
    self.rewardvodAd.rewardAmount = [NSNumber numberWithInt:2];
    
    // 2、加载激励视频广告
    [self.rewardvodAd loadRewardvodAd];
}

/**
 激励视频广告准备好被播放
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdReadyToPlay:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    // 3、推荐在准备好被播放回调中展示激励视频广告
    if ([self.rewardvodAd rewardvodAdIsReady]) {
        [self.rewardvodAd showRewardvodAd];
    }
}

/**
 视频播放页关闭回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdDidClose:(ADRFMediationSDKRewardvodAd *)rewardvodAd{
    // 4、广告内存回收
    _rewardvodAd = nil;
}

/**
 视频广告请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adrf_rewardvodAdFailToLoad:(ADRFMediationSDKRewardvodAd *)rewardvodAd errorModel:(ADRFMediationAdapterErrorDefine *)errorModel{
    // 4、广告内存回收
    _rewardvodAd = nil;
}

/**
 视频广告发送服务端验证成功回调
 
 @param rewardvodAd 广告实例
 */
- (void)adrf_rewardvodAdServerDidSucceed:(ADRFMediationSDKRewardvodAd *)rewardvodAd {
    
}

/**
 视频广告发送服务端验证请求失败回调
 
 @param rewardvodAd 广告实例
 @param errorModel 具体错误信息
 */
- (void)adrf_rewardvodAdServerDidFailed:(ADRFMediationSDKRewardvodAd *)rewardvodAd errorModel:(ADRFMediationAdapterErrorDefine *)errorModel {
    
}


```

<div STYLE="page-break-after: always;"></div>


## 4.7 插屏广告 - ADRFMediationSDKIntertitialAd

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，访问其目标网址，也可以将其关闭并返回应用。在应用执行流程的自然停顿点，适合投放这类广告。

<font color='red'>**注意：穿山甲插屏广告禁止App启动即请求，建议在首页控制器viewDidLoad方法中2~3s后请求展示，否则会有明显数据影响，将会存在约50%数据异常。** </font>

`OC请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-ios/blob/master/ADRFMediationSDKDemo-iOS/RFMediationAds/InterstitialAd/ADRFMediationInterstitialViewController.m)

`Swift请求插屏广告代码示例：`[[插屏广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/InterstitialAd/ADRFMediationInterstitialViewController.swift)

**ADRFMediationSDKIntertitialAd**: 插屏广告的加载类

| <center>属性</center> | <center>类型</center>  | <center>说明</center>|
|:-----------|:--|:--------|
| delegate | id\<ADRFMediationSDKIntertitialAdDelegate> | 委托对象  |
| controller | UIViewController | 开发者需传入用来弹出目标页的ViewController，一般为当前ViewController |
| posId | NSString | 广告位id  |
| scenesId | NSString | 场景id  |
| tolerateTimeout | NSTimeInterval | 请求超时时间,默认为4s,需要设置3s及以上  |
| isMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇，快手<br/> 特殊平台：穿山甲（需在穿山甲后台广告位配置处设置） |
| detailPageVideoMuted | BOOL | 是否静音，默认静音 <br>支持平台：优量汇  |

| <center>接口</center> | <center>说明</center>|
|:-----------|:--------|
| loadAdData | 加载插屏广告 |
| show | 展示插屏广告 |

**ADRFMediationSDKIntertitialAdDelegate**：插屏代理方法

| <center>回调函数</center> | <center>回调说明</center>|
|:-----------|:--------|
| ADRFMediation_interstitialAdSuccedToLoad: | 插屏广告加载成功 |
| ADRFMediation_interstitialAdFailedToLoad:error: | 插屏广告加载失败 |
| ADRFMediation_interstitialAdDidPresent: | 插屏广告展示成功 |
| ADRFMediation_interstitialAdFailedToPresent:error: | 插屏广告展示失败 |
| ADRFMediation_interstitialAdExposure: | 插屏广告曝光 |
| ADRFMediation_interstitialAdDidClick: | 插屏广告点击 |
| ADRFMediation_interstitialAdDidClose: | 插屏广告关闭 |
| ADRFMediation_interstitialAdCloseLandingPage: | 插屏广告关闭落地页 |


Swift请求插屏代码示例：[[插屏广告代码示例]](https://github.com/ADRanfeng/adrfmediation-sdk-swift/blob/master/ADRFMediationSDKDemo-iOS-Swift/RFMediationAds/InterstitialAd/ADRFMediationInterstitialViewController.swift)

OC请求插屏代码示例：

```obj-c
#import <ADRFMediationSDK/ADRFMediationSDKIntertitialAd.h>

- (void)loadInterstitialAd{
    // 1、初始化插屏广告
    self.intertitialAd = [ADRFMediationSDKIntertitialAd new];
    self.intertitialAd.controller = self;
    self.intertitialAd.posId = @"75dc0e44ed48bc2a62";
    self.intertitialAd.delegate = self;
    self.intertitialAd.tolerateTimeout = 4;
    // 2、加载插屏广告
    [self.intertitialAd loadAdData];
}

#pragma mark - ADRFMediationSDKIntertitialAdDelegate
/**
 ADRFMediationSDKIntertitialAd请求成功回调
 
 @param interstitialAd 插屏广告实例对象
*/
- (void)adrf_interstitialAdSuccedToLoad:(ADRFMediationSDKIntertitialAd *)interstitialAd{
    // 3、展示插屏广告
    [self.intertitialAd show];
}
/**
 ADRFMediationSDKIntertitialAd请求失败回调

 @param interstitialAd 插屏广告实例对象
 @param error 失败原因
*/
- (void)adrf_interstitialAdFailedToLoad:(ADRFMediationSDKIntertitialAd *)interstitialAd error:(ADRFMediationAdapterErrorDefine *)error{
    // 4、内存回收
    _intertitialAd = nil;
}
/**
 ADRFMediationSDKIntertitialAd关闭回调

 @param interstitialAd 插屏广告实例对象
*/
- (void)adrf_interstitialAdDidClose:(ADRFMediationSDKIntertitialAd *)interstitialAd{
    // 4、内存回收
    _intertitialAd = nil;
}

```

<div STYLE="page-break-after: always;"></div>