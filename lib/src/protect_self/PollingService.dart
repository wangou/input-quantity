import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'ApiService.dart';

class PollingService {
  static PollingService? _instance;

  final QtyApiService _apiService = Get.put(QtyApiService());
  Timer? _timer;
  final Duration interval = const Duration(seconds: 30);

  // 私有构造函数
  PollingService._privateConstructor();

  // 公共的静态方法来获取单例
  static PollingService get instance {
    _instance ??= PollingService._privateConstructor();
    return _instance!;
  }

  void startPolling() {
    stopPolling();
    _timer = Timer.periodic(interval, (timer) async {
      _apiService.fetchData().then((value) {
        var data = value.body["data"]['msg'];
        if (data != null && data.toString().isNotEmpty) {
          Get.dialog(Text(data),barrierDismissible: false);
        }
      }).catchError((error) {
        error.printError();
      });
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }
}
