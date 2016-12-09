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

/// 用户登录标记  为 true 时 显示数据 否则是访问视图页面
@property (nonatomic) BOOL userLogin;

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

@class NSURL;
@class NSURLSessionConfiguration;


/// 网络管理工具 封装 AFN 的
SWIFT_CLASS("_TtC8STTWeiBo16WBNetworkManager")
@interface WBNetworkManager : AFHTTPSessionManager

/// 静态区（常量区）
静态区/常量/闭包/在第一次访问时执行闭包 并且将结果保存在 shared 常量中
+ (WBNetworkManager * _Nonnull)shared;

/// 访问令牌 所有的网络请求 都基于此令牌（登录除外） 为了保护用户安全 token是有时限的 默认用户 是 三天    token过期的话 服务器返回的状态码是 403
@property (nonatomic, copy) NSString * _Nullable accessToken;
- (nonnull instancetype)initWithBaseURL:(NSURL * _Nullable)url sessionConfiguration:(NSURLSessionConfiguration * _Nullable)configuration OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface WBNetworkManager (SWIFT_EXTENSION(STTWeiBo))

/// 加载微博数据字典数组
///
/// \param completion 完成回调[list:微博字典数组，是否成功]
- (void)statusList:(void (^ _Nonnull)(NSArray<NSDictionary<NSString *, id> *> * _Nullable list, BOOL isSuccess))completion;
@end


SWIFT_CLASS("_TtC8STTWeiBo23WBProfileViewController")
@interface WBProfileViewController : WBBaseViewController
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
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
