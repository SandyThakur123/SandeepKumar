import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/constant/route_constant.dart';
import 'package:flutter_application_6/ui/controller/home_controller.dart';
import 'package:flutter_application_6/ui/view/Postdetail.dart';

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.put(DataController());

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Post',
        ),
        centerTitle: true,
      ),
      body: Obx(() => dataController.isDataLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataController.list.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RouteConstant.PostDetailScreen,
                          arguments: dataController.list[index].id,
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: height * 0.01),
                          // height: height * 0.2,
                          width: width * 0.98,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: width * 0.9,
                                    child: Text(
                                      dataController.list[index].title!,
                                      style: const TextStyle(
                                          overflow: TextOverflow.visible,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.02),
                                    child: SizedBox(
                                      width: width * 0.9,
                                      child: Text(
                                          dataController.list[index].body!,
                                          style: const TextStyle(
                                              overflow: TextOverflow.visible,
                                              color: Colors.grey,
                                              fontSize: 18)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      textAlign: TextAlign.end,
                                      textDirection: TextDirection.rtl,
                                      softWrap: true,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Author : ',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20),
                                          ),
                                          TextSpan(
                                            text:
                                                '${dataController.userdatalist.where((element) => element.id == dataController.list[index].userId).first.name}',
                                            style: const TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              })),
    );
  }
}
