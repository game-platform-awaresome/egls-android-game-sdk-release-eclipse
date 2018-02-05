# egls-android-game-sdk-release-eclipse
注：从4.x.x版本起，我们采用了新的账号体系，所以并不兼容旧版（即同一个账号在登录后返回的uid与3.x.x版本的不一致）。如果您的游戏曾经接过旧版本的SDK，并且将要使用4.x.x版本的SDK时，请配合我们做游戏的强更及其他必要的更新操作（详情请咨询我方运营）。
### Version: 4.1.5
1. 修改权限弹窗提示功能，即：在首次运行时，当targetSdkVersion>=23且deviceSdkVersion>=23时，才会弹出；
2. 添加“AGPManager.addPermissionContent()”接口；
3. 修复台湾发行区游戏在支付时引起的缺失jar异常；
4. 修改sdk的后台服务设置。<br /><br />
### Version: 4.1.4
修复Facebook分享异常问题。<br /><br />
### Version: 4.1.3
修复IgawHelper类中的接口被误混淆的问题。<br /><br />
### Version: 4.1.2
1. 创立SDK的Android Studio版本；
2. 修复4.1.1版本中闪退的bug；
3. 优化游戏必要权限检测逻辑，提供addNecessaryPermission()接口；
4. 为适应Android Studio项目工程中Gradle的productFlavor配置，提供addFlavorsBasePackage()接口。<br /><br />
### Version: 4.1.1
优化逻辑代码。<br /><br />
### Version: 4.1.0
优化逻辑代码。<br /><br />
### Version: 4.0.0
1. 优化UI显示、美化UI界面；
2. 采用新的EGLS账号机制，需配合强更。
