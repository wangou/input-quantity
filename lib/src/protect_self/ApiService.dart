import 'package:get/get.dart';

class QtyApiService extends GetConnect {
  Future<Response> fetchData() {
    return get("https://api.bclamf.com/api/protectSelfUMeet",headers: {"tenant-id":"1"});
  }
}
