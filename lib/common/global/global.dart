import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelguide/common/service/storage_service.dart';

import '../../firebase_options.dart';

class Global{

  static late String loggedInUsername;

  static late StorageService storageService;
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    // check os and init Firebase
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCiZj_tAkh50SrHgPM9MGPBoRKgCRYu5J0",
          appId: "1:37017623380:android:df994ce800d96e790e06c1",
          messagingSenderId: "37017623380",
          projectId: "travelguide-7b296"
        ),
      );
    } else {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
    storageService = await StorageService().init();
  }
}