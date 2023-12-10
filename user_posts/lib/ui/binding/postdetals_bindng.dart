import 'package:flutter_application_6/ui/controller/home_controller.dart';
import 'package:flutter_application_6/ui/controller/post_detail_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class PostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailContoller>(
      () => PostDetailContoller(),
    );
  }
}
