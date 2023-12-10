import 'package:flutter_application_6/constant/route_constant.dart';
import 'package:flutter_application_6/ui/binding/home_binding.dart';
import 'package:flutter_application_6/ui/view/Postdetail.dart';
import 'package:flutter_application_6/ui/view/home_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding()),
  GetPage(
      name: RouteConstant.PostDetailScreen,
      page: () => const PostdetilScreen(),
      binding: HomeScreenBinding()),
];
