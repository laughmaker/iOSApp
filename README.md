iOSApp
======

一个简易的iOS开发框架，简化iOS开发工作量。

### Lib
   * 为第三方类库，基本保持不变
   * 主要引入一些常用的第三方类库，可直接使用。
   * Category：常用的分类工具
   * FMDB：著名的OC版SQLite
   * MKNetworkKit：网络交互工具
   * SDWebImage：异步加载Image工具
   * Views：一些常用的第三方自定义的View，包括各种自定义特效的Label，单选按钮，复选框，alertView,状态栏消息通知，筛选控件等等。
   
### AppGeneral
   * AppConfig.h : 定义了项目的一些全局参数，如字体、UserDefaults关键字、全局通知等
   * MacroDefine.h :定义了通用的宏定义，可保持所有项目不变
   * NetworkAPI.h : 定义了网络请求接口，各自项目根据需要自行定义
   * Singleton.h : 单例宏定义模板
   
### AppEngine  
   * 定义了程序里一些通用的模板

##### Model
   * TableDataSource.h : 定义了TableView的DataSource模板，让控制器专注于数据处理
   * TableDelegate.h : 定义了TableView的相关代理，包括上下拉刷新的代理 模板
   * VCModel.h : 定义了控制器的Model，主要是相关网络请求接口，让Controller只需要调用的网络接口，传入参数值，即可得到返回数据，另外若有需要，可子类化该类，将数据在该子类中进行解析处理，然后由Controller来读取。
   * TableModel.h : 定义了可上下拉刷新的TableView的控制器的Model，为VCModel的子类。
   
##### TWUIKit 
   * 包含了程序里一些常用的View的子类。如TextField，在程序中通常会有相同的外观设置，如字体，背景等，可在TWTextField中设置好，然后项目中所有的TextField继承自TWTextField，则可实现统一的外观。还有如程序中的VC要设置背景、返回手势，则可在TWViewController中设置好，然后继承该类，则可统一实现相关的定制。等等，其它的类似。
   
### TWApp
   * 程序的实际功能模块，如Demo中的Setting、Login等，可在项目中创建对应的实体文件夹，方便管理。
