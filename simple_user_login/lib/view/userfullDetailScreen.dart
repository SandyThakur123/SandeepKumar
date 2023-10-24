import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_user_login/Models/userFullDetails.dart';
import 'package:simple_user_login/Presenter/Comman_contact.dart';
import 'package:simple_user_login/Presenter/Comman_presenter.dart';
import 'package:simple_user_login/utils/network_constants.dart';

class userFulldetail extends StatefulWidget {
  final int? id;
  userFulldetail({super.key, this.id});

  @override
  State<userFulldetail> createState() => _userFulldetailState();
}

class _userFulldetailState extends State<userFulldetail>
    implements CommanContract {
  String? userEmail;
  late CommanPresenter _presenter;
  TextEditingController name = TextEditingController();
  TextEditingController job = TextEditingController();
  _userFulldetailState() {
    _presenter = CommanPresenter(this);
  }
  void initState() {
    setState(() {
      _getUserDetail(widget.id!);
      getEmail();
    });

    super.initState();
  }

  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    userEmail = prefs.getString('user_email');
    return userEmail;
  }

  bool _isFirstLoadRunning = false;
  user_fullData? user_full_data;
  final _baseUrl = NetworkConstant.getUserFullDetail;
  userFullDetails? items;
  Support? support_link;

  void _getUserDetail(int id) async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      print('${_baseUrl.replaceAll('id', id.toString())}');
      final res = await http
          .get(Uri.parse(_baseUrl.replaceAll('id', id.toString())), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      setState(() {
        Map<String, dynamic> decoded = json.decode(res.body);

        // print(data['data'].length);

        items = userFullDetails.fromJson(decoded);
        user_full_data = items!.userfull_data;
        support_link = items!.support;
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
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.04,
                              top: MediaQuery.of(context).size.height * 0.04),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.23,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                "${user_full_data == null ? "" : user_full_data!.avatar}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${user_full_data!.firstName == null ? '' : user_full_data!.firstName}  ${user_full_data!.lastName == null ? '' : user_full_data!.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: Text(
                      '${user_full_data!.email == null ? '' : user_full_data!.email} ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.04),
                    child: Text(
                      '${support_link == null ? '' : support_link!.url} ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: 'name',
                          labelText: 'name',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          errorStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0)),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: job,
                      decoration: const InputDecoration(
                        hintText: 'Job',
                        labelText: 'Job',
                        prefixIcon: Icon(
                          Icons.work,
                        ),
                        errorStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.all(
                              Radius.circular(9.0),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          if (name.text.isNotEmpty || job.text.isNotEmpty)
                            _presenter.fetchPostApiResponse(
                                NetworkConstant.addNewUser,
                                value1: {
                                  'name': name.text,
                                  'job': job.text,
                                });
                        },
                        child: const Text(
                          'Add User',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  void Failed() {}

  @override
  void Succes(Map<String, dynamic> data) {
    print({data});
  }
}
