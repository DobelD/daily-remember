import 'package:flutter/material.dart';

import 'firebase_api.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  final FirebaseApi _firebaseApi;

  AppLifecycleObserver(this._firebaseApi);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Aplikasi kembali ke latar depan
      _firebaseApi.appForeground = true;
    } else {
      // Aplikasi pindah ke latar belakang
      _firebaseApi.appForeground = false;
    }
  }
}
