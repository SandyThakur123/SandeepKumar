import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_user_login/Models/userdetail.dart';
import 'package:simple_user_login/utils/network_constants.dart';
import 'package:simple_user_login/view/userfullDetailScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String? userEmail;
  final _baseUrl = NetworkConstant.getUserDetail;

  List<Data>? data = [];
  userDetail? items;
  bool _isFirstLoadRunning = false;

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    userEmail = prefs.getString('user_email');
    return userEmail;
  }

  @override
  void initState() {
    setState(() {
      _getUserDetail();
      getEmail();
    });

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _getUserDetail() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse(_baseUrl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      setState(() {
        Map<String, dynamic> decoded = json.decode(res.body);

        // print(data['data'].length);

        items = userDetail.fromJson(decoded);
        data = items!.user_data;
      });
    } catch (err) {
      print('Something went wrong');
    }

    _isFirstLoadRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          '${userEmail == null ? '' : userEmail}',
          style: const TextStyle(
              color: Colors.blue, overflow: TextOverflow.visible),
        ),
      ),
      body: SingleChildScrollView(
        child: _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data == null ? 0 : data!.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => userFulldetail(
                                id: data![index].id,
                              )),
                    );
                  },
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.height * 0.03,
                          bottom: MediaQuery.of(context).size.height * 0.018),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.23,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    "${data!.isEmpty ? "" : data![index].avatar}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.05,
                                    left: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.52,
                                  child: Text(
                                    '${data![index].firstName == null ? '' : data![index].firstName}  ${data![index].lastName == null ? '' : data![index].lastName}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.visible,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01),
                            child: Text(
                              '${data![index].email == null ? '' : data![index].email} ',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
