import 'package:dio/dio.dart';
import 'package:flutter_application_6/constant/apiContants.dart';
import 'package:flutter_application_6/model/user_data.dart';
import 'package:flutter_application_6/model/user_model.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  List<GetUserPostModel> list = [];
  List<user_Data> userdatalist = [];

  var isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getApi();
    getPosts();
    gestUsers();
  }

  gestUsers() async {
    // isDataLoading(true);
    Dio dio = Dio();
    try {
      var response = await dio.get(getuser);

      response.data.forEach((e) {
        userdatalist.add(user_Data.fromJson(e));
      });
      update();
    } catch (error, stacktrace) {
      print("Exception occured: $error StackTrace: $stacktrace");
    }
    //return list;
  }

  getPosts() async {
    isDataLoading(true);
    Dio dio = Dio();
    try {
      var response = await dio.get(getUsersPost);

      response.data.forEach((e) {
        list.add(GetUserPostModel.fromJson(e));
      });
      update();
      isDataLoading(false);
    } catch (error, stacktrace) {
      print("Exception occured: $error StackTrace: $stacktrace");
    }
    //return list;
  }
}
