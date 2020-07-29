// eslint-disable-next-line import/no-unresolved
import { NativeModules } from 'react-native';

const {
    RNEmarsys,
} = NativeModules;

// IOS ONLY
export const requestPushAuth = () =>
    RNEmarsys.requestPushAuth();
export const clearPushToken = () =>
    RNEmarsys.clearPushToken();


export const trackCustomEvent = (eventName, eventAttributes = null) =>
    RNEmarsys.trackCustomEvent(eventName, eventAttributes);
export const trackTag = (tag, attributes = null) =>
    RNEmarsys.trackTag(tag, attributes);
export const setContact = contactValue =>
    RNEmarsys.setContact(contactValue);
export const clearContact = () =>
    RNEmarsys.clearContact();
export const trackCart = cartItems =>
    RNEmarsys.trackCart(cartItems);
export const trackPurchase = (orderId, items) =>
    RNEmarsys.trackPurchase(orderId, items);
export const trackItemView = itemId =>
    RNEmarsys.trackItemView(itemId);
export const trackCategoryView = categoryPath =>
    RNEmarsys.trackCategoryView(categoryPath);
export const trackSearchTerm = searchTerm =>
    RNEmarsys.trackSearchTerm(searchTerm);

export default {
    requestPushAuth,
    clearPushToken,
    trackCustomEvent,
    trackTag,
    setContact,
    clearContact,
    trackCart,
    trackPurchase,
    trackItemView,
    trackCategoryView,
    trackSearchTerm,
};
