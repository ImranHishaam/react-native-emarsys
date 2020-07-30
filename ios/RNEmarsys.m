#import "RNEmarsys.h"
#import <React/RCTLog.h>
#import "EMSConfig.h"
#import "Emarsys.h"
#import "EMSCartItem.h"
#import <React/RCTConvert.h>

@implementation RNEmarsys

- (dispatch_queue_t)methodQueue
{
    return dispatch_queue_create("com.leciseau.RNEmarsys", DISPATCH_QUEUE_SERIAL);
}

+ (void)init:(NSString *)applicationCode contactFieldId:(NSNumber *)contactFieldId {
  EMSConfig *config = [EMSConfig makeWithBuilder:^(EMSConfigBuilder *builder) {
    [builder setMobileEngageApplicationCode:applicationCode];
    [builder setContactFieldId:contactFieldId];
  }];
  [Emarsys setupWithConfig:config];
}

+ (void)setPushToken:(NSData *)deviceToken
{
  const char *data = [deviceToken bytes];
  NSMutableString *stringToken = [NSMutableString string];
  for (NSUInteger i = 0; i < [deviceToken length]; i++) {
    [stringToken appendFormat:@"%02.2hhX", data[i]];
  }
  NSLog(@"RNEmarsys - Setting push token to : %@", stringToken);
  [Emarsys.push setPushToken:deviceToken completionBlock:^(NSError *error) {
    if (NULL != error) {
      RCTLogInfo(@"RNEmarsys - error setting push token: %@", [error localizedDescription]);
    }
  }];
}

+ (void)trackMessageOpenWithUserInfo:(NSDictionary *)userInfo
{
  RCTLogInfo(@"RNEmarsys - trackMessageOpenWithUserInfo");
  [Emarsys.push trackMessageOpenWithUserInfo:userInfo
    completionBlock:^(NSError *error) {
      if (NULL != error) {
        RCTLogInfo(@"RNEmarsys - error tracking open message: %@", [error localizedDescription]);
      }
    }
  ];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(requestPushAuth)
{
  RCTLogInfo(@"RNEmarsys - Requesting Push Authorisation");
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
      if(!error){
          [[UIApplication sharedApplication] registerForRemoteNotifications];
      }
  }];
}

RCT_EXPORT_METHOD(clearPushToken)
{
  [Emarsys.push clearPushTokenWithCompletionBlock:^(NSError *error) {
    if (NULL != error) {
      RCTLogInfo(@"RNEmarsys - error clearing push token: %@", [error localizedDescription]);
    }
  }];
}

RCT_EXPORT_METHOD(trackCustomEvent:(NSString *)eventName eventAttributes:(NSDictionary *)eventAttributes)
{
  RCTLogInfo(@"RNEmarsys - trackCustomEvent - %@", eventName);
  [Emarsys trackCustomEventWithName:eventName eventAttributes:eventAttributes completionBlock:^(NSError *error) {
    if (NULL != error) {
      RCTLogInfo(@"RNEmarsys - error tracking custom event: %@", [error localizedDescription]);
    }
  }];
}

RCT_EXPORT_METHOD(trackTag:(NSString *)tag attributes:(nullable NSDictionary *)attributes)
{
  RCTLogInfo(@"RNEmarsys - trackTag - %@", tag);
  [Emarsys.predict trackTag:tag withAttributes:attributes];
}


RCT_EXPORT_METHOD(setContact:(NSString *)contactValue)
{
    RCTLogInfo(@"RNEmarsys - setContact - %@", contactValue);
    [Emarsys setContactWithContactFieldValue:contactValue completionBlock:^(NSError *error) {
        if (NULL != error) {
         RCTLogInfo(@"RNEmarsys - error setting contact: %@", [error localizedDescription]);
        }
    }];
}

RCT_EXPORT_METHOD(clearContact)
{
    RCTLogInfo(@"RNEmarsys - clearContact");
    [Emarsys clearContactWithCompletionBlock:^(NSError *error) {
        if (NULL != error) {
          RCTLogInfo(@"RNEmarsys - error cleaning contact contact: %@", [error localizedDescription]);
        }
    }];
}

RCT_EXPORT_METHOD(trackCart:(NSArray <NSDictionary *> *)cartItems)
{
    RCTLogInfo(@"RNEmarsys - track cart");
    for (id object in cartItems) {
        [Emarsys.predict trackCartWithCartItems:@[
                [EMSCartItem itemWithItemId:[object objectForKey:@"item"] price:[[object objectForKey:@"price"] doubleValue] quantity:[[object objectForKey:@"quantity"] doubleValue]]
        ]];
    }
}

RCT_EXPORT_METHOD(trackPurchase:(NSString *)orderId items:(NSArray <NSDictionary *> *)items)
{
    RCTLogInfo(@"RNEmarsys - track purchase");
    for (id object in items) {
        [Emarsys.predict trackPurchaseWithOrderId:orderId items:@[
                [EMSCartItem itemWithItemId:[object objectForKey:@"item"] price:[[object objectForKey:@"price"] doubleValue] quantity:[[object objectForKey:@"quantity"] doubleValue]]
        ]];
    }
}

RCT_EXPORT_METHOD(trackItemView:(NSString *)itemId)
{
    RCTLogInfo(@"RNEmarsys - track item view");
    [Emarsys.predict trackItemViewWithItemId:itemId];
}

RCT_EXPORT_METHOD(trackCategoryView:(NSString *)categoryPath)
{
    RCTLogInfo(@"RNEmarsys - track category view");
    [Emarsys.predict trackCategoryViewWithCategoryPath:categoryPath];
}

RCT_EXPORT_METHOD(trackSearchTerm:(NSString *)searchTerm)
{
    RCTLogInfo(@"RNEmarsys - track category view");
    [Emarsys.predict trackSearchWithSearchTerm:searchTerm];
}


@end
