package com.leciseau.RNEmarsys;

import android.content.Intent;
import android.util.Log;

import androidx.annotation.Nullable;

import com.emarsys.Emarsys;
import com.emarsys.predict.api.model.CartItem;
import com.emarsys.predict.api.model.PredictCartItem;
import com.emarsys.config.EmarsysConfig;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.ReadableType;
import com.facebook.react.bridge.ReadableArray;

import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;

public class RNEmarsysModule extends ReactContextBaseJavaModule {

  private static final String TAG = "RNEmarsys";

  public RNEmarsysModule(ReactApplicationContext reactContext) {
    super(reactContext);
    Log.i(TAG, "RNEmarsysModule");
  }

  /*
  public void init(String applicationCode) {
    Log.i(TAG, "init: " + applicationCode);

    EmarsysConfig config = new EmarsysConfig.Builder()
      .application(getCurrentActivity().getApplication())
      .mobileEngageApplicationCode(applicationCode)
      .contactFieldId(12)
      .build();
    Emarsys.setup(config);
  }


  @ReactMethod
  public void setPushToken(String pushToken) {
    Log.i(TAG, "setPushToken");
    Emarsys.getPush().setPushToken(pushToken);
  }
  */

  @ReactMethod
  public void trackCustomEvent(String eventName, @Nullable ReadableMap eventAttributes) {
    Log.i(TAG, "trackCustomEvent");
    if (eventAttributes == null) {
        Emarsys.trackCustomEvent(eventName, null);
        return;
    }
    Map<String, String> eventAttributesMap = new HashMap<String, String>();
    ReadableMapKeySetIterator iterator = eventAttributes.keySetIterator();
    while (iterator.hasNextKey()) {
      String key = iterator.nextKey();
      ReadableType type = eventAttributes.getType(key);
      switch (type) {
        case String:
          eventAttributesMap.put(key, eventAttributes.getString(key));
          break;
        default:
          throw new IllegalArgumentException("Could not convert object with key: " + key + ".");
      }
    }
    Emarsys.trackCustomEvent(eventName, eventAttributesMap);
  }

  @ReactMethod
  public void trackTag(String tag, @Nullable ReadableMap attributes) {
    Log.i(TAG, "trackTag");
    if (attributes == null) {
        Emarsys.getPredict().trackTag(tag, null);
        return;
    }
    Map<String, String> eventAttributesMap = new HashMap<String, String>();
    ReadableMapKeySetIterator iterator = attributes.keySetIterator();
    while (iterator.hasNextKey()) {
      String key = iterator.nextKey();
      ReadableType type = attributes.getType(key);
      switch (type) {
        case String:
          eventAttributesMap.put(key, attributes.getString(key));
          break;
        default:
          throw new IllegalArgumentException("Could not convert object with key: " + key + ".");
      }
    }
    Emarsys.getPredict().trackTag(tag, eventAttributesMap);
  }

  @ReactMethod
  public void setContact(String contactFieldValue) {
      Log.i(TAG, "setContact");
      Emarsys.setContact(contactFieldValue);
  }

  @ReactMethod
  public void clearContact() {
      Log.i(TAG, "clearContact");
      Emarsys.clearContact();
  }

  @ReactMethod
  public void trackCart(ReadableArray items) {
      Log.i(TAG, "trackCart");
      List<CartItem> itemsList = new ArrayList<CartItem>();
      for (int i = 0; i < items.size(); i++) {
          ReadableMap item = items.getMap(i);
          String name = item.getString("item");
          String quantity = item.getString("quantity");
          String price = item.getString("price");
          itemsList.add(new PredictCartItem(name, Double.parseDouble(price), Double.parseDouble(quantity)));
      }
      Emarsys.getPredict().trackCart(itemsList);
  }

  @ReactMethod
  public void trackPurchase(String orderId, ReadableArray items) {
      Log.i(TAG, "trackPurchase");
      List<CartItem> itemsList = new ArrayList<CartItem>();
      for (int i = 0; i < items.size(); i++) {
          ReadableMap item = items.getMap(i);
          String name = item.getString("item");
          String quantity = item.getString("quantity");
          String price = item.getString("price");
          itemsList.add(new PredictCartItem(name, Double.parseDouble(price), Double.parseDouble(quantity)));
      }
      Emarsys.getPredict().trackPurchase(orderId, itemsList);
  }

  @ReactMethod
  public void trackItemView(String itemId) {
      Log.i(TAG, "trackItemView");
      Emarsys.getPredict().trackItemView(itemId);
  }

  @ReactMethod
  public void trackCategoryView(String categoryPath) {
      Log.i(TAG, "trackCategoryView");
      Emarsys.getPredict().trackCategoryView(categoryPath);
  }

  @ReactMethod
  public void trackSearchTerm(String searchTerm) {
      Log.i(TAG, "trackSearchTerm");
      Emarsys.getPredict().trackSearchTerm(searchTerm);
  }

  @ReactMethod
  public void trackMessageOpen(Intent intent) {
    Log.i(TAG, "trackMessageOpen");
    Emarsys.getPush().trackMessageOpen(intent);
  }

  @Override
  public String getName() {
    return TAG;
  }
}
