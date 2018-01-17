# EGLS-Android-Game-SDK-S3TW-koKR(Client)
### 1. 소개
    EGLS Android Game SDK를 사용해 주셔서 진심으로 감사드립니다,이SDK문서는 **대만/홍콩** 퍼블리싱게임에적용합니다
### 2. Key/ID
#### 2.1 eglsAppId
EGLS 에서 세팅한 앱 아이디입니다
#### 2.2 CHANNEL_GOOGLE_PUBLIC_KEY
Goole Play관리자 페이지에서 생성한 PUBLIC KEY입니다.
#### 2.3 CHANNEL_SERVER_CLIENT_ID
Google API 관리자 페이지 “OAuth 2.0 클라이인트 ID”리스트중，“Web Client”에 해당하는 “Client ID” 수치.
#### 2.4 com.facebook.sdk.ApplicationId
Facebook앱 아이디입니다.
### 3. 개발환경
#### 3.1 관계도
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3TW/blob/master/res/S3TW008.png)<br/>
Demo 가 SDK 연동을 완료한 프로젝트라면,Demo를egls-agp-sdk-release로 복사합니다（이하AGP）.AGP를egls-ags-sdk-release에복사합니다（이하AGS）.而AGS要引入“google-android-gms-sdk-release-11.0.1”.
#### 3.2 AGP lib 선택
대만/홍콩 에서 퍼블리싱 하는 게임은,아래 빨간색 표식한Lib파일만 필요합니다.<br/>
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3TW/blob/master/res/S3TW009.png)
#### 3.3 AGS lib 선택
대만/홍콩 에서 퍼블리싱 하는 게임은,아래 빨간색 표식한Lib파일만 필요합니다.<br/>
![image](https://github.com/sonicdjgh/EGLS-Android-Game-SDK-S3TW/blob/master/res/S3TW010.png)<br/>
MyCardPaySDK.jar ->Mycard결제용<br/>
clientsdk_product_v2.jar -> Gash결제용<br/>
#### 3.4 UnitySDK연동
a. 먼저Android IDE Tool를사용하여 안드로이드 프로젝트를 세팅후SDK 연동을 합니다<br/>
b. 주의사항:게임 MainActivity 는 Unity 와 UnityPlayerActivity 를 사용합니다<br/>
c. 다음,게임 MainActivity 를 jar 패키지 형식으로 Unity 프로젝트에 복사합니다<br/>
d. 对于“Google Android GMS V11.0.1”lib工程的资源引用，需要打一个对应R的jar文件：首先请完成上述中的a项操作（如果还需要添加其他第三方带资源文件的SDK，也请引入并对接到自建的安卓项目工程中）；然后修改自建安卓项目工程的package包名为“com.google.android.gms”，之后执行“Clean”操作来刷新“gen”目录下对应包名的“R.java”文件；最后将该“R.java”文件打成“jar”文件；<br/>
e. 请单独为AGS中的“com.android.vending.billing”打一个jar包加入到Unity项目工程中；<br/>
f. 다음,AGP、AGS중 퍼블리싱에 필요한 lib 파일과 res 파일을정리후 Unity 프로젝트로 복사합니다<br/>
g. Google推荐对危险权限的使用有一定要求，需要加入申请权限的逻辑。但由于Unity会自动申请“AndroidManifest.xml”文件中所配置的危险权限，不便于逻辑控制。如果有需要，请在“AndroidManifest.xml”文件中的“application”标签内加入如下配置：<br/>
```Xml
<meta-data
    android:name="unityplayer.SkipPermissionsDialog"
    android:value="true" />
```
#### 3.5 기타
minSdkVersion = 14，targetSdkVersion >= 23
### 4. AndroidManifest.xml설정
#### 4.1 AGP Permission 설정
```Xml
<!-- EGLS Android Game Platform SDK begin -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

<!-- AppsFlyer begin -->
<!-- AppsFlyer홍콩,대만에서 사용하는 통계삽입 기능 -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<!-- 현재 연동하는 안드로이드패키지가 Google Play외의 기타 엡스토어에 사용하면,이 권한에 대해 반드시 설명해야 합니다,아니면 이 설명권한을 삭제해야 합니다 -->
<!-- <uses-permission android:name="android.permission.READ_PHONE_STATE" /> -->
<!-- AppsFlyer end -->
<!-- EGLS Android Game Platform SDK end -->
```
#### 4.2 AGS Permission 설정
```Xml
<!-- EGLS Android Game Socialization SDK begin -->
<!-- Google  begin -->
<uses-permission android:name="com.android.vending.BILLING" />
<!-- 일부 디바이스가google play에 앱 다운로드안되는 문제 해결,필수 사용이 아니라는것을 설명해야 합니다 -->
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
<!-- Google  end -->


<!-- FaceBook begin -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<!-- FaceBook end -->


<!-- Mycard begin -->
<!--
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.FLASHLIGHT" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MOUNT_UNMOUNT_FILESYSTEMS" />
<uses-permission android:name="android.permission.READ_LOGS" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
-->
<!-- Mycard end -->
<!-- EGLS Android Game Socialization SDK end -->
```
주의사항：이상 Permission 설정중SDK의 기본기능만 오픈합니다,만약 기타 기능이필요하면,관련된 Permission 설정을 해주세요.
#### 4.3 Application설정
```Xml
<!-- Mycard결제 사용시,application 에 아래 내용을 추가합니다android:name="tw.com.mycard.sdk.libs.PSDKApplication" -->
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
        <!-- DeepLink대만 지역으로 설정하면 LINE 보상형 설치 기능 사용 가능 -->
        <!-- “MY_PACKAGE_NAME”을 정식용 패키지명으로 수정 -->
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

    <!-- AppsFlyer begin -->
    <!-- AppsFlyer홍콩,대만지역에서 사용하는 통계 기능 -->
    <!-- 모든Install Referrer이 시스템에서 플레이하는referrer내용을 인지하기 위해서,AndroidManifest.xml에서 AppsFlyer기능이 반드시첫번째 순위에 있어야 하며,receiver tag가application tag에 있어야 합니다 -->
    <receiver
        android:name="com.appsflyer.MultipleInstallBroadcastReceiver"
        android:exported="true" >
        <intent-filter>
            <action android:name="com.android.vending.INSTALL_REFERRER" />
        </intent-filter>
    </receiver>
    <!-- AppsFlyer end -->
	
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
    <!-- “MY_SERVER_CLIENT_ID”를 Google API 관리자 페이지 “OAuth 2.0 클라이인트 ID”리스트중，“Web Client”에 해당하는 “Client ID” 수치 로 수정해야합니다 -->
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
    
        
    <!-- Google Play 결제 begin -->
    <!-- 如果使用Google Play支付功能，请打开以下配置 -->
    <!-- “MY_PUBLIC_KEY”를Google Play관리자 페이지에 있는 publicKey로 수정합니다 -->
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
    <!-- Google Play 결제 end -->
    

    <!-- Facebook begin -->
    <!-- “MY_APPLICATION_ID”를Facebook관라자 페이지의 설정applicationId -->
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


    <!-- Mycard 결제설정 begin -->
    <!-- 如果使用Mycard支付功能，请打开以下配置 -->	
    <!--
    <activity
        android:name="soft_world.mycard.paymentapp.ui.SplashActivity"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="soft_world.mycard.paymentapp.ui.MainActivity"
        android:screenOrientation="portrait"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity
        android:name="soft_world.mycard.paymentapp.ui.TrainActivity"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="com.google.zxing.CaptureActivity"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="tw.com.mycard.paymentsdk.PSDKActivity"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="soft_world.mycard.paymentapp.ui.billing.BillingWebViewActivity"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Dialog" >
    </activity>
    <activity
        android:name="soft_world.mycard.paymentapp.Ecom.ATMMenuActivity"
        ndroid:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="com.xmobilepay.xpaymentlibs.XCardTypeForm"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="com.xmobilepay.xpaymentlibs.PaymentErrResultForm"
        android:screenOrientation="portrait" >
    </activity>
    <activity
        android:name="com.fet.iap.activity.FetLoginActivity"
        android:configChanges="keyboardHidden|orientation|screenSize"
        android:theme="@android:style/Theme.Translucent.NoTitleBar"
        android:windowSoftInputMode="adjustPan" >
    </activity>
    <activity android:name="com.cht.iap.api.ChtRegMainActivity" />
    <activity android:name="com.cht.iap.api.ChtPhoneNumPayConfirmActivity" />
    <activity android:name="com.cht.iap.api.ChtRegEInvoiceInfo" />
    <activity android:name="com.cht.iap.api.ChtRegVerifyOTP" />
    <activity android:name="com.cht.iap.api.ChtRegHNDataTabActivity" />
    <activity android:name="com.cht.iap.api.ChtRegHNAccountActivity" />
    <activity android:name="com.cht.iap.api.ChtRegMobileAuth" />
    <activity android:name="com.cht.iap.api.ChtRegMobileHNData" />
    <activity android:name="com.cht.iap.api.ChtTransactionAuth" />
    <activity android:name="com.cht.iap.api.ChtRegVerifyMessage" />
    <activity
        android:name="com.softmobile.ui.PayPageActivity"
        android:configChanges="orientation"
        android:screenOrientation="portrait" />
    <activity
        android:name="com.payeasenet.token.lib.ui.TokenPayTypeCheckUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.CardTypeCheckUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
         android:name="com.payeasenet.token.lib.ui.TokenCreateUI"
         android:screenOrientation="portrait"
         android:theme="@android:style/Theme.Light.NoTitleBar" >
    </activity>
    <activity
        android:name="com.payeasenet.token.lib.ui.TokenCreateResultUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.TokenPayUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEPayRelUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.TokenIntroductionUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" >
    </activity>
    <activity
        android:name="com.payeasenet.token.lib.ui.TokenUnBindedUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" >
    </activity>
    <activity
        android:name="com.payeasenet.token.lib.ui.MoreAboutUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEQuickPayUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEUpmpPayUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEVisaPayUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEVisaInfoUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEVisaBillInfoUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEDebitBillInfoUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEQuickInfoUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    <activity
        android:name="com.payeasenet.token.lib.ui.PEUpmpInfoUI"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Light.NoTitleBar" />
    -->
    <!-- Mycard 결제설정 end -->
    
    
    <!-- Gash begin -->
    <!-- 如果使用Gash支付功能，请打开以下配置 -->
    <!--
    <activity
        android:name="com.gashpoint.gpclientsdk.SdkActivity"
	android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
        android:exported="true"
        android:screenOrientation="portrait"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
    -->
    <!-- Gash end -->
    <!-- EGLS Android Game Socialization SDK end -->
</application>
```
### 5. 기본설정（필수）
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
### 6. SDK초기화（필수）
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
    int serverType = 2;// initSDK방법중serverType를유의해 주세요,자세한 설명은 “첨부 파일 - serverType”를 참고해 주세요
    AGPManager.initSDK(this, versionCode, new AGPInitProcessListener() {// SDK初始化回调

	@Override
	public void onInitSDK(int code, String msg) {
	    if (code == 0) {// SDK초기화완료후 계속 진행
	    	// 로그인 버튼 화면	
	    	AGPManager.setOpenChannelLogin(new boolean[] {true, true});
	        // 공유 기능 오픈 및 오픈 Return key 설정 
	    	AGPManager.setOpenChannelShare(true,new OnAGSShareCallback() {
								
	            @Override
	            public void onShare(int requestCode,int resultCode, String msg) {
	            }
	    	});
	    } else {// 아니면 게임 종료
	        finish();
	    }
    	}
    });
}
```
### 7. SDK결제（필수）
```Java
boolean isOpenAutoLogin = false;// 한국 퍼블리싱 게임은true로 설정
AGPManager.eglsLogin(isOpenAutoLogin, new AGPLoginProcessListener() {

    @Override
    public void onTokenFailure() {
	// tokenReturn key 인증실패,게임 메인 로그인 화면으로 돌아가는 기능 개발
    }

    @Override
    public void onLoginProcess(int code, String token, String uid, String msg) {
	// 로그인 결과 값 Return，code=0이면 로그인 성공
	// msg = "0"时，表示游客账号登录
	// msg = "1"时，表示EGLS账号登录
	// msg = "2"时，表示Google账号登录
	// msg = "3"时，表示Facebook账号登录
    }

    @Override
    public void onLoginCancel() {
	// 로그인 Return key 실패
    }
});
```
### 8. SDK결제（필수）
```Java
String amount = "1";// 총금액
String productId = "PDT001";// 상품id
String productName = "다이아";// 상품이름
String cpOrderInfo = "2SDF34DF12GH0S23234GAER5";// CP주문번호
AGPManager.eglsPay(amount, productId, productName, cpOrderInfo, new AGPClientPayProcessListener(){
	
    @Override
    public void onClientPayFinish() {
	// 클라이언트 결제 return 성공
	// 客户端的支付完成并不能够完全代表支付操作成功，请以服务器的通知为准
    }

    @Override
    public void onClientPayError() {
    	// 클라이언트결제 return 실패
    }

    @Override
    public void onClientPayCancel() {
	// 클라이언트결제 return 취소
    }
});
```
### 9. onEnterGame설정（필수）
```Java
//유저가 서버에 로그인후,아래 내용을 반드시 사용해 주세요
AGPManager.onEnterGame();
```
### 10.SDK공유기능（선택）
```Java
String contentTitle = "공유";// 공유제목
String contentText = "텍스트내용";// 텍스트내용
String contentImage = "공유이미지";// 공유 이미지 파일의주소
String contentUrl = null; //공유링크url
Bundle shareBundle = new Bundle();
shareBundle.putString(AGPConstants.KEY_CONTENT_TITLE, contentTitle);
shareBundle.putString(AGPConstants.KEY_CONTENT_TEXT, contentText);
shareBundle.putString(AGPConstants.KEY_CONTENT_IMAGE, contentImage);
shareBundle.putString(AGPConstants.KEY_CONTENT_URL, contentUrl);
AGPManager.shareInTW(true, true, shareBundle);
```
### 첨부 - serverType
serverType | value
---|---
중국 | 1
홍콩,대만 | 2
한국 | 3
일본 | 4
미국 | 5

### 첨부 - payChannel
payChannel | value
---|---
Google Play | 2
Mycard | 3
OneStore | 4
Gash | 5
