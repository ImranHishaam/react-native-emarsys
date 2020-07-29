# @leciseau/react-native-emarsys

## 1. Install the React Native Emarsys plugin

`$ npm install @leciseau/react-native-emarsys --save`

OR

`$ yarn add @leciseau/react-native-emarsys`

## 2 Install the native SDK

#### iOS (Cocoapods)

1. Go to `/ios`
2. If you don't have a Podfile yet run `pod init`
3. Run `pod install`
4. You should now open your project with the `.xcworkspace` instead of the `.xcodeproj`

#### Android (Gradle)

1. Go to `src/app/build.gradle`
2. In `dependencies` add

```gradle
dependencies {
  ...
  implementation 'com.emarsys:emarsys-sdk:2.5.4'
  ...
}
```

## 3 Init SDK

#### iOS

1. Go to `AppDelegate.m`
2. Add

```objective-c
...
#import "EMSConfig.h"
#import "Emarsys.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ...
    EMSConfig *config = [EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
        [builder setMobileEngageApplicationCode:<applicationCode: NSString>];
        [builder setContactFieldId:<contactFieldId: NSNumber>];
        [builder setMerchantId:<predictMerchantId: NSString>];
    }];
    [Emarsys setupWithConfig:config];
    ...
}
```

#### Android

1. Go to `MainApplication.java`
2. Add

```java
...
import com.emarsys.Emarsys;
import com.emarsys.config.EmarsysConfig;

@Override
public void onCreate() {
  super.onCreate();
  ...
  EmarsysConfig config = new EmarsysConfig.Builder()
    .application(this)
    .mobileEngageApplicationCode(<applicationCode:String?>)
    .contactFieldId(<contactFieldId: Integer>)
    .predictMerchantId(<predictMerchantId:String?>)
    .inAppEventHandler(getInAppEventHandler())
    .notificationEventHandler(getNotificationEventHandler())
    .build();

    Emarsys.setup(config);
}
```

## Usage
```javascript
import RNEmarsys from '@leciseau/react-native-emarsys';
// or
import {
    trackCustomEvent,
    trackTag,
    setContact,
    clearContact,
    trackCart,
    trackPurchase,
    trackItemView,
    trackCategoryView,
    trackSearchTerm,
} from '@leciseau/react-native-emarsys';

RNEmarsys.trackCustomEvent('myEvent', { toto: "titi" });
RNEmarsys.trackTag('myTag', { toto: "titi" });
RNEmarsys.setContact('userId');
RNEmarsys.clearContact();
RNEmarsys.trackCart([{
    item: 'myItem',
    quantity: '1',
    price: '12.34',
}]);
RNEmarsys.trackPurchase('idPurchase', [{
    item: 'myItem',
    quantity: '1',
    price: '12.34',
}]);
RNEmarsys.trackItemView('myItemId');
RNEmarsys.trackCategoryView('myCategoryPath');
RNEmarsys.trackSearchTerm('mySearchTerm');
```
