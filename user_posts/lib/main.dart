import 'package:flutter/material.dart';
import 'package:flutter_application_6/constant/route_constant.dart';
import 'package:flutter_application_6/ui/view/home_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'constant/get_pages_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      getPages: getPages,
      title: 'Posts',
      initialRoute: RouteConstant.homeScreen,
      home: const HomeScreen(),
    );
  }
}
