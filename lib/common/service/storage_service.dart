import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelguide/common/values/constant.dart';

class StorageService{
  late final SharedPreferences preference;

  Future<StorageService> init() async {
    preference = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    // Store a boolean value in persistent storage
    return await preference.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    // Store a boolean value in persistent storage
    return await preference.setString(key, value);
  }

  bool getDeviceFirstOpen(){
    return preference.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME)??false;
  }
  
  bool getIsLoggedIn(){
    return preference.getString(AppConstants.STORAGE_USER_TOKEN_KEY)==null?false:true;
  }

  Future<void> setUserInfo(Map<String, dynamic> userInfo) async {
    final userInfoJson = jsonEncode(userInfo);
    await preference.setString(AppConstants.STORAGE_USER_PROFILE_KEY, userInfoJson);
  }

  Map<String, dynamic> getUserInfo() {
    final userProfileJson = preference.getString(AppConstants.STORAGE_USER_PROFILE_KEY);
    return userProfileJson != null ? jsonDecode(userProfileJson) : {};
  }

  Future<bool> remove(String key){
    return preference.remove(key);
  }

}