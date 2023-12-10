import 'package:dio/dio.dart';
import 'package:flutter_application_6/constant/apiContants.dart';
import 'package:flutter_application_6/model/postdetails_model.dart';

import 'package:get/get.dart';

class PostDetailContoller extends GetxController {
  var postId = Get.arguments;
  List<dynamic> Posts_Details = [];
  Map<String, dynamic>? detalslist;

  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // getApi();
    getPostdetail(postId);
  }

  getPostdetail(int id) async {
    isDataLoading(true);
    Dio dio = Dio();
    try {
      var response =
          await dio.get(post_details.replaceFirst('id', id.toString()));
      print('${response.data}');

      detalslist = response.data;
      Posts_Details = detalslist!.values.toList();
      print('postdetail==>${detalslist!.values.toList()}');
      update();
      isDataLoading(false);
    } catch (error, stacktrace) {
      print("Exception occured: $error StackTrace: $stacktrace");
    }
    //return list;
  }
}
