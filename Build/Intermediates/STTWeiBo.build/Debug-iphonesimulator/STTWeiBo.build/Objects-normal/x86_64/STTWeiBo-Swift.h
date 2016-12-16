// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.8 clang-703.0.31)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import Foundation;
@import CoreGraphics;
@import ObjectiveC;
@import AFNetworking;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC8STTWeiBo11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface AppDelegate (SWIFT_EXTENSION(STTWeiBo))
@end


@interface AppDelegate (SWIFT_EXTENSION(STTWeiBo))
@end


@interface NSBundle (SWIFT_EXTENSION(STTWeiBo))
@property (nonatomic, readonly, copy, getter=namespace) NSString * _Nonnull namespace_;
@end


@interface UIBarButtonItem (SWIFT_EXTENSION(STTWeiBo))

/// 创建UIBarButtonItem  便利构造函数
///
/// <code> 创建UIBarButtonItem  构造函数
///  
///  - parameter title:    title
///  - parameter fontSize: fontSize 默认 16
///  - parameter target:   target
///  - parameter action:   action
///  - parameter isBack:   是否是返回按钮 如果是加上箭头
///  
///  - returns: UIBarButtonItem
/// 
/// </code>
- (nonnull instancetype)initWithTitle:(NSString * _Nonnull)title fontSize:(CGFloat)fontSize target:(id _Nullable)target action:(SEL _Null_unspecified)action isBack:(BOOL)isBack;
@end

@class UITableView;
@class UIRefreshControl;
@class UINavigationBar;
@class UINavigationItem;
@class NSCoder;


/// 所有主控制器的基类控制器
SWIFT_CLASS("_TtC8STTWeiBo20WBBaseViewController")
@interface WBBaseViewController : UIViewController

/// 访客视图字典信息
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable visitorInfoDictionary;

/// 表格视图 - 如果用户没有登录,就不创建
@property (nonatomic, strong) UITableView * _Nullable tableView;

/// 刷新控件
@property (nonatomic, strong) UIRefreshControl * _Nullable refreshControl;

/// 上拉刷新标记
@property (nonatomic) BOOL isPullup;

/// 自定义导航条   因为是使航条渲染所以自定义
@property (nonatomic, strong) UINavigationBar * _Nonnull navigationBar;

/// 自定义的导航条目 -- 以后设置导航栏内容 统一使用 navitem
@property (nonatomic, strong) UINavigationItem * _Nonnull navItem;
- (void)viewDidLoad;

/// 重写 title 的 didSet
@property (nonatomic, copy) NSString * _Nullable title;

/// 加载数据 具体的实现由子类负责
- (void)loadData;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBBaseViewController (SWIFT_EXTENSION(STTWeiBo))
@end

@class NSIndexPath;
@class UITableViewCell;

@interface WBBaseViewController (SWIFT_EXTENSION(STTWeiBo)) <UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource>
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;

/// 在显示最后一行的时候 做上拉刷新
///
/// \param tableView <#tableView description#>
///
/// \param cell <#cell description#>
///
/// \param indexPath <#indexPath description#>
- (void)tableView:(UITableView * _Nonnull)tableView willDisplayCell:(UITableViewCell * _Nonnull)cell forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


@interface WBBaseViewController (SWIFT_EXTENSION(STTWeiBo))

/// 设置表格视图 只有用户登录之后 执行（子类重写此方法）因为子类不需要关心用户登录之前的逻辑
- (void)setupTableView;
@end


SWIFT_CLASS("_TtC8STTWeiBo20WBDemoViewController")
@interface WBDemoViewController : WBBaseViewController
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBDemoViewController (SWIFT_EXTENSION(STTWeiBo))
- (void)setupTableView;
@end


SWIFT_CLASS("_TtC8STTWeiBo24WBDiscoverViewController")
@interface WBDiscoverViewController : WBBaseViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8STTWeiBo20WBHomeViewController")
@interface WBHomeViewController : WBBaseViewController

/// 加载数据
- (void)loadData;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBHomeViewController (SWIFT_EXTENSION(STTWeiBo))

/// 重写父类方法
- (void)setupTableView;
@end


@interface WBHomeViewController (SWIFT_EXTENSION(STTWeiBo))
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


SWIFT_CLASS("_TtC8STTWeiBo20WBMainViewController")
@interface WBMainViewController : UITabBarController
- (void)viewDidLoad;

/// 使用代码控制设备的方向  好处 可以在需要横屏的时候 单独处理 设置支持的方向之后 当前的控制器以及子控制器都会遵守这个方向 如果播放视频 通常是通过 model 展现的
///
/// \returns  支持的方向   Portrait 竖屏 landscape 横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBMainViewController (SWIFT_EXTENSION(STTWeiBo)) <UITabBarControllerDelegate>

/// 将要选择 tabBarItem
///
/// \param tabBarController tabBarController
///
/// \param viewController 目标控制器
///
/// \returns  是否切换到目标控制器
- (BOOL)tabBarController:(UITabBarController * _Nonnull)tabBarController shouldSelectViewController:(UIViewController * _Nonnull)viewController;
@end


@interface WBMainViewController (SWIFT_EXTENSION(STTWeiBo))
@end


@interface WBMainViewController (SWIFT_EXTENSION(STTWeiBo))
@end


SWIFT_CLASS("_TtC8STTWeiBo23WBMessageViewController")
@interface WBMessageViewController : WBBaseViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC8STTWeiBo22WBNavigationController")
@interface WBNavigationController : UINavigationController
- (void)viewDidLoad;

/// 重写push方法
///
/// \param viewController 是被 push 的控制器 设置它的在右侧按钮作为返回按钮
///
/// \param animated true
- (void)pushViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated;
- (nonnull instancetype)initWithNavigationBarClass:(Class _Nullable)navigationBarClass toolbarClass:(Class _Nullable)toolbarClass OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRootViewController:(UIViewController * _Nonnull)rootViewController OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class WBUserAccount;
@class NSURL;
@class NSURLSessionConfiguration;


/// 网络管理工具 封装 AFN 的
SWIFT_CLASS("_TtC8STTWeiBo16WBNetworkManager")
@interface WBNetworkManager : AFHTTPSessionManager
+ (WBNetworkManager * _Nonnull)shared;
@property (nonatomic, strong) WBUserAccount * _Nonnull userAccount;

/// 用户登录标记(计算型属性)
@property (nonatomic, readonly) BOOL userLogon;
- (nonnull instancetype)initWithBaseURL:(NSURL * _Nullable)url sessionConfiguration:(NSURLSessionConfiguration * _Nullable)configuration OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBNetworkManager (SWIFT_EXTENSION(STTWeiBo))

/// 加载 授权 accessToken
///
/// \param code 授权码
///
/// \param completion 完成回调[是否成功]
- (void)loadAccessToken:(NSString * _Nonnull)code completion:(void (^ _Nonnull)(BOOL isSuccess))completion;
@end


@interface WBNetworkManager (SWIFT_EXTENSION(STTWeiBo))

/// 加载微博数据字典数组
///
/// \param since _id:   返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
///
/// \param max _id:     返回ID小于或等于max_id的微博，默认为0
///
/// \param completion 完成回调[list:微博字典数组，是否成功]
- (void)statusList:(int64_t)since_id max_id:(int64_t)max_id completion:(void (^ _Nonnull)(NSArray<NSDictionary<NSString *, id> *> * _Nullable list, BOOL isSuccess))completion;

/// 返回微博的未读数量 定时刷新 不需要提示是否失败
- (void)unreadCount:(void (^ _Nonnull)(NSInteger count))completion;
@end



/// 通过webView加载新浪微博授权页面
SWIFT_CLASS("_TtC8STTWeiBo21WBOAuthViewController")
@interface WBOAuthViewController : UIViewController
- (void)loadView;
- (void)viewDidLoad;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWebView;
@class NSURLRequest;

@interface WBOAuthViewController (SWIFT_EXTENSION(STTWeiBo)) <UIWebViewDelegate>

/// webView 将要加载请求
///
/// \param webView webView
///
/// \param request 要加载的请求
///
/// \param navigationType 导航类型
///
/// \returns  是否加载 request
- (BOOL)webView:(UIWebView * _Nonnull)webView shouldStartLoadWithRequest:(NSURLRequest * _Nonnull)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView * _Nonnull)webView;
- (void)webViewDidFinishLoad:(UIWebView * _Nonnull)webView;
@end


SWIFT_CLASS("_TtC8STTWeiBo23WBProfileViewController")
@interface WBProfileViewController : WBBaseViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end



/// 微博数据模型
SWIFT_CLASS("_TtC8STTWeiBo8WBStatus")
@interface WBStatus : NSObject

/// Int 类型 在64位的机器是 64 位 在 32 为 机器是 32位 如果不写 Int64 在Ipad 2、iPhone 5、5c、4s、4 都无法正常运行
@property (nonatomic) int64_t id;

/// 微博信息内容
@property (nonatomic, copy) NSString * _Nullable text;

/// 重写 description 的计算型属性
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class NSDate;


/// 用户账户信息
SWIFT_CLASS("_TtC8STTWeiBo13WBUserAccount")
@interface WBUserAccount : NSObject
@property (nonatomic, copy) NSString * _Nullable access_token;
@property (nonatomic, copy) NSString * _Nullable uid;
@property (nonatomic) NSTimeInterval expires_in;
@property (nonatomic, strong) NSDate * _Nullable expiresDate;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;

/// 保存用户数据到json
- (void)saveAccount;
@end

@class UIButton;


/// 访客视图
SWIFT_CLASS("_TtC8STTWeiBo13WBVisitorView")
@interface WBVisitorView : UIView

/// 注册按钮
@property (nonatomic, strong) UIButton * _Nonnull registerButton;

/// 登录按钮
@property (nonatomic, strong) UIButton * _Nonnull loginButton;

/// 访客视图的信息字典 [imageName / message] 如果是首页 imageName == ""
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable visitorInfo;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBVisitorView (SWIFT_EXTENSION(STTWeiBo))
- (void)setupUI;
@end

#pragma clang diagnostic pop
