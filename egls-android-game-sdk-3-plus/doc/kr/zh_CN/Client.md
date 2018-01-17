# EGLS-Android-Game-SDK-S3KR-zhCN(Client)
### 1. 简介
    欢迎使用 EGLS Android Game SDK，这篇SDK对接文档说明适用于在**韩国**发行的游戏。
### 2. 所需参数
#### 2.1 eglsAppId
由我方给游戏分配的应用id，一个游戏对应一个
#### 2.2 CHANNEL_GOOGLE_PUBLIC_KEY
在Goole Play后台生成的支付公钥。
#### 2.3 CHANNEL_SERVER_CLIENT_ID
在Google API后台“OAuth 2.0 客户端 ID”配置的列表中，关于“Web Client”项对应的“Client ID”参数值。
#### 2.4 com.facebook.sdk.ApplicationId
在Facebook后台生成的应用id。
#### 2.5 CHANNEL_ONESTORE_APP_ID
在OneStore后台生成的应用id。
### 3. 环境搭建
#### 3.1 依赖关系
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3KR/blob/master/res/S3KR008.png)<br/>
如上图所示：假设Demo为SDK对接完毕的安卓游戏工程，那么Demo引入“egls-agp-sdk-release”（以下简称AGP）；而AGP引入“egls-ags-sdk-release”（以下简称为AGS）；而AGS要引入“google-android-gms-sdk-release-11.0.1”和“naver-android-cafe-sdk-2.4.3”。
#### 3.2 AGP lib 选择
针对于在韩国地区发行的游戏，我们只需要如下图红框所示的lib文件：<br/>
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3KR/blob/master/res/S3KR009.png)
#### 3.3 AGS lib 选择
针对于在韩国地区发行的游戏，我们只需要如下图红框所示的lib文件：<br/>
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3KR/blob/master/res/S3KR010.png)<br/>
iap_plugin_v16.03.00_20161123.jar -> 用于OneStore支付。<br/>
#### 3.4 关于Unity的SDK接入
a. 首先使用Android IDE工具自建一个安卓项目工程后并完成SDK的接入工作；<br/>
b. 请注意，游戏主Activity需要继承Unity的UnityPlayerActivity；<br/>
c. 然后将游戏主Activity打成jar包放入到Unity项目工程中；<br/>
d. 对于“google-android-gms-sdk-release-11.0.1”lib工程的资源引用，需要打一个对应R的jar文件：首先请完成上述中的a项操作（如果还需要添加其他第三方带资源文件的SDK，也请引入并对接到自建的安卓项目工程中）；然后修改自建安卓项目工程的package包名为“com.google.android.gms”，之后执行“Clean”操作来刷新“gen”目录下对应包名的“R.java”文件；最后将该“R.java”文件打成“jar”文件(同理，“naver-android-cafe-sdk-2.4.3”也需要这样做，其package为“com.naver.glink.android.sdk”)；<br/>
e. 请单独为AGS中的“com.android.vending.billing”打一个jar包加入到Unity项目工程中；<br/>
f. 之后要将AGP、AGS中对应发行区所需要的lib文件和res文件整合后放入到Unity项目工程中；<br/>
g. Google推荐对危险权限的使用有一定要求，需要加入申请权限的逻辑。但由于Unity会自动申请“AndroidManifest.xml”文件中所配置的危险权限，不便于逻辑控制。如果有需要，请在“AndroidManifest.xml”文件中的“application”标签内加入如下配置：
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

<!-- IGAW begin -->
<!-- IGAW为韩国地区所使用的统计功能，其他地区发行的游戏请不要使用 -->
<!-- 替换“MY_PACKAGE_NAME”字样为正式包名 -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.GET_TASKS" />
<permission
    android:name="MY_PACKAGE_NAME.permission.C2D_MESSAGE"
    android:protectionLevel="signature" />
<uses-permission android:name="MY_PACKAGE_NAME.permission.C2D_MESSAGE" />
<uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
<!-- IGAW end -->
<!-- EGLS Android Game Platform SDK end -->
```
#### 4.2 AGS Permission 配置
```Xml
<!-- EGLS Android Game Socialization SDK begin -->
<!-- Google Play begin -->
<!-- 如果使用Google Play支付功能，请打开以下配置 -->
<!--
<uses-permission android:name="com.android.vending.BILLING" />
<uses-feature
    android:name="android.hardware.camera"
    android:required="false" />
<uses-feature
    android:name="android.hardware.camera.autofocus"
    android:required="false" />
<uses-feature
    android:name="android.hardware.telephony"
    android:required="false" />
<uses-feature
    android:name="android.hardware.microphone"
    android:required="false" />
-->
<!-- Google Play end -->


<!-- FaceBook begin -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<!-- FaceBook end -->


<!-- NaverCafeSDK begin -->
<!-- 如果使用NaverCafe论坛，请打开以下配置 -->
<!--
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
-->
<!-- NaverCafeSDK end -->


<!-- OneStore begin -->
<!-- 如果使用OneStore支付，请打开以下配置 -->
<!--
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
-->
<!-- OneStore end -->
<!-- EGLS Android Game Socialization SDK end -->
```
请注意：以上 Permission 配置中只打开了SDK基础功能相关的配置，如果使用到其他功能，请打开对应的 Permission 配置！
#### 4.3 Application相关配置
```Xml
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
        <!-- DeepLink begin -->
        <!-- DeepLink配置为韩国IGAW统计功能所使用 -->
        <!-- 替换“MY_PACKAGE_NAME”字样为正式包名 -->
        <intent-filter>
            <data
                android:host="MY_PACKAGE_NAME"
                android:scheme="egls" />

            <action android:name="android.intent.action.VIEW" />

            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
        </intent-filter>
        <!-- DeepLink end -->
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
    <activity
        android:name="com.egls.platform.net.AGPBrowserAcitivity"
        android:configChanges="locale|keyboardHidden|orientation|screenSize"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
        android:windowBackground="@null"
        android:windowSoftInputMode="adjustPan" >
    </activity>

    <!-- SDK3.7.5版本及以上请使用如下配置 -->
    <!--	
    <service android:name="com.egls.platform.backend.AGPNetworkCommunicationService" >
    </service>	
    -->
	
    <!-- SDK3.7.4版本及以下请使用如下配置 -->
    <!--
    <service android:name="com.egls.platform.components.AGPNetworkCommunicationService" >
    </service>
    -->	

    <!-- IGAW begin -->
    <!-- IGAW为韩国地区所使用的统计功能，其他地区发行的游戏请不要使用 -->
    <!-- 替换“MY_PACKAGE_NAME”字样为正式包名 -->
    <!-- 替换“MY_APP_KEY”字样为IGAW后台配置的appKey -->
    <!-- 替换“MY_HASH_KEY”字样为IGAW后台配置的hashKey -->
    <receiver
        android:name="com.igaworks.IgawReceiver"
        android:exported="true" >
        <intent-filter>
            <action android:name="com.android.vending.INSTALL_REFERRER" />
        </intent-filter>
    </receiver>
    <receiver
        android:name="com.igaworks.liveops.pushservice.LiveOpsGCMBroadcastReceiver"
        android:permission="com.google.android.c2dm.permission.SEND" >
        <intent-filter>
            <action android:name="com.google.android.c2dm.intent.RECEIVE" />

            <category android:name="MY_PACKAGE_NAME" />
        </intent-filter>
    </receiver>
    <service
        android:name="com.igaworks.liveops.pushservice.GCMIntentService"
        android:enabled="true" />
    <receiver
        android:name="com.igaworks.liveops.pushservice.LiveOpsReceiver"
        android:permission="MY_PACKAGE_NAME.permission.C2D_MESSAGE" >
        <intent-filter>
            <action android:name="com.igaworks.liveops.pushservice.CLIENT_PUSH_RECEIVE" />
        </intent-filter>
    </receiver>
    <activity
        android:name="com.igaworks.liveops.pushservice.IgawLiveOpsPushMessageLauncherActivity"
        android:noHistory="true"
        android:permission="MY_PACKAGE_NAME.permission.C2D_MESSAGE" />
    <meta-data
        android:name="igaworks_app_key"
        android:value="MY_APP_KEY" />
    <meta-data
        android:name="igaworks_hash_key"
        android:value="MY_HASH_KEY" />
    -->
    <!-- IGAW end -->
	
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
    <!-- 当使用OneStore支付功能进行测试时，“EGLS_PAY_IS_SANDBOX”的参数值请设为"true"；测试完毕后，其正式包中对应的参数值要改为"false" -->
    <meta-data 
        android:name="EGLS_PAY_IS_SANDBOX"
        android:value="false"/>
    <!-- 当没有特殊要求时，“EGLS_PAY_OTHER_PARAM”的参数值为""即可 -->
    <meta-data 
        android:name="EGLS_PAY_OTHER_PARAM"
        android:value=""/>
    <!-- EGLS Android Game Platform SDK end -->


    <!-- EGLS Android Game Socialization SDK begin -->
    <activity
        android:name="com.egls.socialization.performance.AGSShareActivity"
        android:screenOrientation="landscape"
        android:theme="@style/AGSTheme.Translucent.NoTitleBar.Fullscreen.NoAnimation" >
    </activity>
    <activity android:name="com.android.browser.BrowserActivity" >
    </activity>

    <!-- Google SignIn begin -->
    <!-- 替换“MY_SERVER_CLIENT_ID”字样为在Google API后台“OAuth 2.0 客户端 ID”配置的列表中，关于“Web Client”项对应的“Client ID”参数值 -->
    <activity
        android:name="com.egls.socialization.google.signin.GoogleSignInActivity"
        android:configChanges="fontScale|orientation|keyboardHidden|locale|navigation|screenSize|uiMode"
        android:screenOrientation="landscape"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />
    <activity
        android:name="com.google.android.gms.auth.api.signin.internal.SignInHubActivity"
        android:excludeFromRecents="true"
        android:exported="false"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />
    <activity
        android:name="com.google.android.gms.common.api.GoogleApiActivity"
        android:exported="false"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />

    <service
        android:name="com.google.samples.quickstart.signin.signin.RevocationBoundService"
        android:exported="true"
        android:permission="com.google.android.gms.auth.api.signin.permission.REVOCATION_NOTIFICATION" />

    <meta-data
        android:name="com.google.android.gms.version"
        android:value="@integer/google_play_services_version" />
        
    <meta-data 
        android:name="CHANNEL_SERVER_CLIENT_ID"
        android:value="MY_SERVER_CLIENT_ID"/>
    <!-- Google SignIn end -->
	

    <!-- Google Play Game begin -->
    <!-- 如果使用Google Play Game成就功能，请打开以下配置 -->	
    <!-- 替换“MY_GAMES_APP_ID”字样为"MY_SERVER_CLIENT_ID"的第一处"-"左边的纯数字部分 -->
    <!--
    <meta-data
        android:name="com.google.android.gms.games.APP_ID"
        android:value="\0MY_GAMES_APP_ID" />
    -->
    <!-- Google Play Game end -->


    <!-- Google Play begin -->
    <!-- 如果使用Google Play支付功能，请打开以下配置 -->	
    <!-- 替换“MY_PUBLIC_KEY”字样为Google Play后台配置的publicKey -->
    <!--
    <activity
        android:name="com.egls.socialization.google.play.BillingActivity"
        android:configChanges="fontScale|orientation|keyboardHidden|locale|navigation|screenSize|uiMode"
        android:screenOrientation="landscape"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />

    <meta-data
        android:name="CHANNEL_GOOGLE_PUBLIC_KEY"
        android:value="MY_PUBLIC_KEY" />
    -->
    <!-- Google Play end -->
    

    <!-- Facebook begin -->
    <!-- 替换“MY_APPLICATION_ID”字样为Facebook后台配置的applicationId -->
    <activity
        android:name="com.egls.socialization.facebook.FacebookSignInActivity"
        android:configChanges="fontScale|orientation|keyboardHidden|locale|navigation|screenSize|uiMode"
        android:screenOrientation="landscape"
        android:theme="@android:style/Theme.NoTitleBar" >
    </activity>
    <activity
        android:name="com.facebook.FacebookActivity"
        android:screenOrientation="landscape"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />

    <provider
        android:name="com.facebook.FacebookContentProvider"
        android:authorities="com.facebook.app.FacebookContentProviderMY_APPLICATION_ID"
        android:exported="true" />

    <receiver android:name="com.egls.socialization.facebook.FacebookReceiver" >
        <intent-filter>
            <action android:name="com.facebook.platform.AppCallResultBroadcast" />
        </intent-filter>
    </receiver>

    <meta-data
        android:name="com.facebook.sdk.ApplicationId"
        android:value="\0MY_APPLICATION_ID" />
	
    <!--如果游戏需要开启Facebook的“USER_FRIEND”权限，请打开以下配置 --> 
    <!--
    <meta-data
            android:name="CNANNEL_PERMISSION_USER_FRIEND"
            android:value="true"/>
    -->
    <!-- Facebook end  -->
    
    
    <!-- NaverCafeSDK begin -->
    <!-- 如果使用NaverCafe论坛，请打开以下配置 -->
    <!-- 替换“MY_CLIENT_ID”字样为Naver后台配置的clientId -->
    <!-- 替换“MY_CLIENT_SECRET”字样为Naver后台配置的clientSecret -->
    <!-- 替换“MY_CAFE_ID”字样为NaverCafe后台配置的cafeId -->
    <!--
    <activity
        android:name="com.naver.glink.android.sdk.ui.VideoPlayActivity"
        android:screenOrientation="sensorLandscape"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
    <activity
        android:name="com.nhn.android.naverlogin.ui.OAuthLoginActivity"
        android:screenOrientation="sensorLandscape"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />
    <activity
        android:name="com.nhn.android.naverlogin.ui.OAuthLoginInAppBrowserActivity"
        android:label="OAuth2.0 In-app"
        android:screenOrientation="sensorLandscape" />
    <meta-data
        android:name="naver_login_client_id"
        android:value="MY_CLIENT_ID" />
    <meta-data
        android:name="naver_login_client_secret"
        android:value="MY_CLIENT_SECRET" />
    <meta-data
        android:name="naver_cafe_id"
        android:value="\0MY_CAFE_ID" /> 
    -->
    <!-- NaverCafeSDK end -->


    <!-- OneStore begin -->
    <!-- 如果使用OneStore支付功能，请打开以下配置 -->	
    <!-- 替换“MY_APP_ID”字样为OneStore后台配置的appId -->
    <!--
    <meta-data
        android:name="iap:api_version"
        android:value="4" />
    <activity
        android:name="com.skplanet.dodo.IapWeb"
        android:configChanges="fontScale|orientation|keyboardHidden|locale|navigation|screenSize|uiMode"
        android:excludeFromRecents="true"
        android:windowSoftInputMode="stateHidden" >
    </activity>
    <meta-data
        android:name="CHANNEL_ONESTORE_APP_ID"
        android:value="MY_APP_ID"/>
    -->
    <!-- OneStore end -->
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
    if (Build.VERSION.SDK_INT >= 23) {
	super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }
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
	    	// 打开第三方登录功能
	    	AGPManager.setOpenChannelLogin(new boolean[] {true, true});
	        // 打开分享功能并设置分享回调
	    	AGPManager.setOpenChannelShare(true,new OnAGSShareCallback() {
								
	            @Override
	            public void onShare(int requestCode,int resultCode, String msg) {
	            }
	    	});
	    } else {// 否则关闭游戏
	        finish();
	    }
    	}
    });
    onNewIntent(getIntent());// 在韩国发行的游戏必须加入此代码
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
String cpOrderInfo = "2SDF34DF12GH0S23234GAER5";// CP订单号
AGPManager.eglsPay(amount, productId, productName, cpOrderInfo, new AGPClientPayProcessListener(){
	
    @Override
    public void onClientPayFinish() {
	// 客户端支付完成回调
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
shareBundle.putString(AGPConstants.KEY_CONTENT_TITLE, contentTitle);
shareBundle.putString(AGPConstants.KEY_CONTENT_TEXT, contentText);
shareBundle.putString(AGPConstants.KEY_CONTENT_IMAGE, contentImage);
shareBundle.putString(AGPConstants.KEY_CONTENT_URL, contentUrl);
AGPManager.shareInKR(true, true, shareBundle);
```
### 11. IGAW数据统计（必接）
IGAW主要用于韩服地区发行的游戏的数据统计，启用该功能的做法，首先要按照上面所提到的，在AndroidManifest.xml文件中打开对应的配置。对于IGAW统计功能的相关接口调用，其相关初始化部分的逻辑已经嵌入进SDK当中，因此开发者无需关心较为复杂的初始化步骤，只需根据需求，调用对应的接口即可。
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3KR/blob/master/res/S3KR100.png)<br/>
#### 11.1 eventIgawSplashImage()（根据情况接入）
    如果游戏有闪屏动画（或首次启动的游戏动画），请在开始播放动画时调用该方法
#### 11.2 eventIgawCharacterSelect()（必接）
    请在玩家选择游戏角色后调用该方法（对于首次进入游戏的情况，请在创建角色后调用）
#### 11.3 eventIgawCharacterName()（必接）
    请在玩家创建角色并完成角色命名后调用该方法
#### 11.4 eventIgawTutorialStart()（根据情况接入）
    如果游戏有新手教学阶段，请在新手教学开始时调用该接口
#### 11.5 eventIgawtutorialComplete()（根据情况接入）
    如果游戏有新手教学阶段，请在新手教学结束时调用该接口
#### 11.6 eventIgawRoleLevelUp(int level)（必接）
    角色升级时调用该接口（当创建角色后，不必调用该接口）
#### 11.7 eventIgawVIPLevelUp(int level)（必接）
    玩家VIP等级提升时调用该接口
#### 11.8 eventIgawVisitShop()（必接）
    玩家打开游戏内的商店（指需要玩家真实付费购买的商店）页面时，请调用该接口
#### 11.9 eventIgawFansite()（根据情况接入）
    如果在游戏中有加入对Naver论坛的访问链接，请在打开Naver论坛时调用该接口（目前SDK已集成NaverCafeSDK，可以选择不自行添加Naver论坛的访问链接）

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
