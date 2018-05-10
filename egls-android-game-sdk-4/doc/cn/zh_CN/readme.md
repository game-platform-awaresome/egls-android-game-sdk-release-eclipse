# EGLS-Android-Game-SDK-CN-4.X.X(Client-zhCN)
### 1. 简介
欢迎使用 EGLS Android Game SDK，这篇SDK对接文档说明适用于在**中国大陆**地区发行的游戏。<br/><br/>
注：从4.x.x版本起，我们采用了新的账号体系，所以并不兼容旧版（即同一个账号在登录后返回的uid与3.x.x版本的不一致）。如果您的游戏曾经接过旧版本的SDK，并且将要使用4.x.x版本的SDK时，请配合我们做游戏的强更及其他必要的更新操作（详情请咨询我方运营）。
### 2. 所需参数
#### 2.1 EGLS_APP_ID
由我方给游戏分配的应用id，一个游戏对应一个
#### 2.2 wx_app_id
在微信平台上分配的应用标识，用于微信登录及分享
#### 2.3 wx_secret
在微信平台上分配的秘钥，用于获取微信用户昵称
#### 2.4 alipay_app_id
在支付宝平台上分配的应用标识，用于支付宝支付
### 3. 环境搭建
#### 3.1 依赖关系
![image](https://github.com/sonicdjgh/egls-android-game-sdk-release-eclipse/blob/master/res/tw/S4TW000.png)<br/>
如上图所示：假设Demo为SDK对接完毕的安卓游戏工程，那么Demo引入“egls-agp-sdk-release”（以下简称AGP）；而AGP引入“egls-ags-sdk-release”（以下简称为AGS）；而AGS要引入“google-android-gms-sdk-release-11.0.1”。
#### 3.2 AGP lib 选择
针对于在港台地区发行的游戏，我们只需要如下图红框所示的lib文件：<br/>
![image](https://github.com/sonicdjgh/egls-android-game-sdk-release-eclipse/blob/master/res/tw/S4TW001.png)
#### 3.3 AGS lib 选择
针对于在港台地区发行的游戏，我们只需要如下图红框所示的lib文件：<br/>
![image](https://github.com/sonicdjgh/egls-android-game-sdk-release-eclipse/blob/master/res/tw/S4TW002.png)<br/>
MyCardPaySDK.jar -> 用于Mycard支付;<br/>
clientsdk_product_v2.jar -> 用于Gash支付。<br/>
#### 3.4 关于Unity的SDK接入
a. 首先使用Android IDE工具自建一个安卓项目工程后并完成SDK的接入工作；<br/><br/>
b. 请注意，游戏主Activity需要继承Unity的UnityPlayerActivity；<br/><br/>
c. 如果您是使用Unity生成安卓游戏包的操作方式，请完成下面的操作：<br/><br/>
(c1)将游戏主Activity打成jar包放入到Unity项目工程中；<br/><br/>
(c2)对于“google-android-gms-sdk-11.0.1”lib工程的资源引用，需要打一个对应R的jar文件：将自建安卓项目工程的package包名修改为“com.google.android.gms”，刷新后将该项目对应的“R.java”文件打成“jar”文件并加入到Unity项目工程中；<br/><br/>
(c3)请单独为AGS中的“com.android.vending.billing”打一个jar包加入到Unity项目工程中；<br/><br/>
(c4)将AGP、AGS中对应发行区所需要的lib文件和res文件整合后放入到Unity项目工程中；<br/><br/>
d. Google推荐对危险权限的使用有一定要求，需要加入申请权限的逻辑。但由于Unity会自动申请“AndroidManifest.xml”文件中所配置的危险权限，不便于逻辑控制。如果有需要，请在“AndroidManifest.xml”文件中的“application”标签内加入如下配置：
```Xml
<meta-data
    android:name="unityplayer.SkipPermissionsDialog"
    android:value="true" />
```
#### 3.5 其他
minSdkVersion = 14，targetSdkVersion >= 23
### 4. AndroidManifest.xml文件配置
#### 4.1 AGP Permission 配置
```Xml
<!-- EGLS Android Game Platform SDK begin -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<!-- EGLS Android Game Platform SDK end -->
```
#### 4.2 AGS Permission 配置
```Xml
<!-- EGLS Android Game Socialization SDK begin -->
<!-- 微信 begin -->
<!-- 如果使用微信登录或微信分享功能，请打开以下配置 -->
<!--
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
-->
<!-- 微信 end -->


<!-- 支付宝 begin -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<!-- 支付宝 end -->
<!-- EGLS Android Game Socialization SDK end -->
```
请注意：以上 Permission 配置中只打开了SDK基础功能相关的配置，如果使用到其他功能，请打开对应的 Permission 配置！
#### 4.3 Application相关配置
```Xml
<!-- 如果用Mycard支付功能，请在application标签内添加属性 android:name="tw.com.mycard.sdk.libs.PSDKApplication" -->
<application
    android:allowBackup="false"
    android:icon="@drawable/icon"
    android:label="AGSDK Demo"
    android:theme="@style/AppTheme" >
    <activity
        android:name="com.egls.platform.test.GameActivity"
        android:configChanges="fontScale|orientation|keyboardHidden|locale|navigation|screenSize|uiMode"
        android:screenOrientation="landscape"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen" >
        <intent-filter>
            <action android:name="android.intent.action.MAIN" />

            <category android:name="android.intent.category.LAUNCHER" />
        </intent-filter>
    </activity>
        
    <!-- EGLS Android Game Platform SDK begin -->
    <activity
        android:name="com.egls.platform.account.AGPIndexActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPAlreadyLoginActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPAgreementActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPIntelligenceActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPNewAccountActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPAccountLoginActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPForgetActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.account.AGPFindActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPUserCenterActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPAuthenticationActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPModifyActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPBindAccountActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPBindMobileActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.usercenter.AGPBindEmailActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.payment.AGPPaymentActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="com.egls.platform.payment.AGPPaymentCardActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <!-- 4.1.1 新增 end -->
    <activity
        android:name="com.egls.platform.account.AGPPermissionActivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="landscape"
        android:theme="@style/AGPTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <!-- 4.1.1 新增 end -->
    <activity
        android:name="com.egls.platform.net.AGPBrowserAcitivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    	
    <service android:name="com.egls.platform.backend.AGPNetworkCommunicationService" >
    </service>	
    
    <!-- 替换"MY_APP_ID"字样为SDK初始化所需的eglsAppId -->
    <meta-data 
        android:name="EGLS_APP_ID"
        android:value="\0MY_APP_ID"/>
	
    <!-- 替换"MY_SERVER_TYPE"字样为对应的服务类别码，详见"附表 - serverType" -->
    <meta-data 
        android:name="EGLS_SERVER_TYPE"
        android:value="MY_SERVER_TYPE"/>
	
    <!-- 替换"MY_PAY_CHANNEL"字样为对应的支付渠道码，详见"附表 - payChannel" -->
    <meta-data 
        android:name="EGLS_PAY_CHANNEL"
        android:value="MY_PAY_CHANNEL"/>
	
    <!-- 当没有特殊要求时，“EGLS_PAY_IS_SANDBOX”的参数值为"false"即可 -->	
    <meta-data 
        android:name="EGLS_PAY_IS_SANDBOX"
        android:value="false"/>
	
    <!-- 当没有特殊要求时，“EGLS_PAY_OTHER_PARAM”的参数值为""即可 -->
    <meta-data 
        android:name="EGLS_PAY_OTHER_PARAM"
        android:value=""/>
	
    <!-- 如果使用微信登录或微信分享功能，请打开以下配置 -->	
    <!-- 替换“MY_WX_APP_ID”字样为微信平台上分配的应用标识 -->
    <!--	
    <meta-data
        android:name="wx_app_id"
        android:value="MY_WX_APP_ID" />
    -->
	
    <!-- 如果使用微信登录或微信分享功能，请打开以下配置 -->	
    <!-- 替换“MY_WX_SECRET”字样为微信平台上分配的秘钥 -->
    <!--	
    <meta-data
        android:name="wx_secret"
        android:value="MY_WX_SECRET" />
    ->
    <!-- EGLS Android Game Platform SDK end -->


    <!-- EGLS Android Game Socialization SDK begin -->
    <activity
        android:name="com.egls.socialization.performance.AGSShareActivity"
        android:screenOrientation="landscape"
        android:theme="@style/AGSTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation" >
    </activity>
    <activity android:name="com.android.browser.BrowserActivity" >
    </activity>

    <!-- 微信 begin -->
    <!-- 如果使用微信登录或微信分享功能，请打开以下配置 -->
    <!-- 替换“MY_WX_APP_ID”字样为游戏的正式包名 -->	
    <!--	
    <activity
        android:name="MY_PACKAGE_NAME.wxapi.WXEntryActivity"
        android:exported="true"
        android:screenOrientation="portrait" >
    -->
    </activity>
    <!-- 微信 end -->
	

    <!-- 支付宝 begin -->
    <activity
        android:name="com.alipay.sdk.app.H5PayActivity"
        android:screenOrientation="portrait" >
    </activity>
    <!-- 支付宝 end -->
    <!-- EGLS Android Game Socialization SDK end -->
</application>
```
### 5. 基础方法实现（必接）
```Java 
@Override
protected void onResume() {
    super.onResume();
    AGPManager.onResume();
}
    
@Override
protected void onPause() {
    super.onPause();
    AGPManager.onPause();
}
	
@Override
protected void onDestroy() {
    super.onDestroy();
    AGPManager.onDestory();
}
	
@Override
protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    AGPManager.onNewIntent(intent);
}
	
@Override
public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    AGPManager.onRequestPermissionsResult(this, requestCode, permissions, grantResults);
}
	
@Override
protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    AGPManager.onActivityResult(requestCode, resultCode, data);
}
```
### 6. SDK初始化（必接）
```Java
@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    String versionCode = "1";
    try {
	versionCode = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionCode + "";
    } catch (NameNotFoundException e) {
	e.printStackTrace();
    }
    AGPManager.initSDK(this, versionCode, new AGPInitProcessListener() {// SDK初始化回调

	@Override
	public void onInitSDK(int code, String msg) {
	    if (code == 0) {// 当SDK初始化成功后再做后续的事情
	    	AGPManager.setOpenChannelShare(true,new OnAGSShareCallback() {// 打开分享功能并设置分享回调
								
	            @Override
	            public void onShare(int requestCode, int resultCode, String msg) {
	            }
	    	});
	    } else {// 否则关闭游戏
	        finish();
	    }
    	}
    });
}
```
### 7. SDK登录（必接）
```Java
boolean isOpenAutoLogin = false;// 韩国地区发行的游戏请传true
AGPManager.eglsLogin(isOpenAutoLogin, new AGPLoginProcessListener() {

    @Override
    public void onTokenFailure() {
	// token失效回调，这里需实现游戏返回到登录页面的逻辑
    }

    @Override
    public void onLoginProcess(int code, String token, String uid, String msg) {
	// 登录结果回调，只有当code=0时，示为登录成功
	// msg = "0"时，表示游客账号登录
	// msg = "1"时，表示EGLS账号登录
	// msg = "2"时，表示Google账号登录
	// msg = "3"时，表示Facebook账号登录
    }

    @Override
    public void onLoginCancel() {
	// 登录取消回调
    }
});
```
### 8. SDK支付（必接）
```Java
String amount = "1";// 总金额
String productId = "PDT001";// 档位id
String productName = "钻石";// 档位名称
String cpOrderInfo = "2SDF34DF12GH0S23234GAER5";// CP订单信息，由接入方生成
AGPManager.eglsPay(amount, productId, productName, cpOrderInfo, new AGPClientPayProcessListener(){
	
    @Override
    public void onClientPayFinish(String message) {
	// 客户端支付完成回调
	// 客户端的支付完成并不能够完全代表支付操作成功，请以服务器的通知为准
    }

    @Override
    public void onClientPayError() {
    	// 客户端支付错误回调
    }

    @Override
    public void onClientPayCancel() {
	// 客户端支付取消回调
    }
});
```
### 9. onEnterGame接口调用（必接）
```Java
//当玩家登录进入到游戏服务器之后，请务必调用该方法
AGPManager.onEnterGame();
```
### 10. SDK分享功能（选接）
```Java
String contentTitle = "分享";// 分享标题
String contentText = "文本内容";// 文本内容
String contentImage = "分享图像文件地址";//分享本地图像文件的绝对地址
String contentUrl = null; //分享的链接url
Bundle shareBundle = new Bundle();
shareBundle.putString(Key.CONTENT_TITLE, contentTitle);
shareBundle.putString(Key.CONTENT_TEXT, contentText);
shareBundle.putString(Key.CONTENT_IMAGE, contentImage);
shareBundle.putString(Key.CONTENT_URL, contentUrl);
AGPManager.shareInTW(true, true, shareBundle);
```
### 11. 关于微信功能的使用
SDK集成了“微信登录”功能及“微信分享”功能，除了添加相关的AndroidManifest.xml文件配置之外，还需要在项目工程中添加一个以“正式包名.wxapi”的package（以Demo为例，则添加的package为“com.egls.demo.wxapi”），并且在该package中添加一个名为“WXEntryActivity”的Activity类，这个类必须继承SDK中的“com.egls.socialization.wechat.WeChatEntryActivity”类，例如：
```java
package 正式包名.wxapi;

import com.egls.socialization.wechat.WeChatEntryActivity;

public class WXEntryActivity extends WeChatEntryActivity {

}
```
### 12. 其他注意事项
1. 凡是游戏项目工程为Android Studio工程，并且在Gradle里配置了productFlavor来控制打包流程的，请务必在调用“AGPManager.initSDK()”接口前，写上如下逻辑代码：
```Java
AGPManager.addFlavorsBasePackage(BuildConfig.class.getPackage().getName());
```
2. Google推荐的审核中，会对游戏首次运行时所使用的必要“危险权限”的申请和使用进行检查。SDK会主动申请“android.permission.WRITE_EXTERNAL_STORAGE”权限，但如果游戏还另需申请其他的“危险权限”，可以在调用“AGPManager.initSDK()”接口前，使用“addNecessaryPermission()”接口。例如：
```Java
AGPManager.addNecessaryPermission(Manifest.permission.READ_PHONE_STATE);
AGPManager.addNecessaryPermission(Manifest.permission.RECORD_AUDIO);
```
### 附表 - serverType
serverType | value
---|---
中国大陆 | 1
港台地区 | 2
韩国 | 3
日本 | 4
美国 | 5

### 附表 - payChannel
payChannel | value
---|---
Google Play | 2
Mycard | 3
OneStore | 4
Gash | 5
