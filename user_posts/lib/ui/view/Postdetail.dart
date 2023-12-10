import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_6/themes/color_theme.dart';

import 'package:get/get.dart';

import '../controller/post_detail_controller.dart';

class PostdetilScreen extends StatefulWidget {
  const PostdetilScreen({Key? key}) : super(key: key);

  @override
  State<PostdetilScreen> createState() => _PostdetilScreenState();
}

class _PostdetilScreenState extends State<PostdetilScreen> {
  PostDetailContoller PostDetail = Get.put(PostDetailContoller());

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Post Detail',
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => PostDetail.isDataLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Title : ',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          TextSpan(
                            text: '${PostDetail.Posts_Details[2]}',
                            style: const TextStyle(
                                color: ThemeColor.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    RichText(
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      softWrap: true,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Heading : ',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          TextSpan(
                            text: '${PostDetail.Posts_Details[3]}',
                            style: const TextStyle(
                                color: ThemeColor.primaryGreen, fontSize: 18),
                          ),
                          // TextSpan(
                          //   text: 'Geeks',
                          //   style: TextStyle(
                          //       color: ThemeColor.white, fontSize: 18),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
        ));
  }
}
