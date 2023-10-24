import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_user_login/view/HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isHidden = true;
  var imgHidden;

  _hiddenImage() {
    if (_isHidden == true) {
      return imgHidden = 'assets/images/eyeicon.png';
    }
    if (_isHidden == false) {
      return imgHidden = 'assets/images/disable.png';
    }
  }

  adduserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', email.text);

    print({prefs.getString('user_email')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 213, 212, 212),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.blueGrey)),
                    child: Center(
                        child: Text(
                      'Welcome Back',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                  controller: email,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Enter email address'),
                                    EmailValidator(
                                        errorText:
                                            'Please correct email filled'),
                                  ]),
                                  decoration: const InputDecoration(
                                      hintText: 'Email',
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        //color: Colors.green,
                                      ),
                                      errorStyle: TextStyle(fontSize: 18.0),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(9.0)))))),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              controller: password,
                              obscureText: _isHidden,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter Password'),
                                MinLengthValidator(6,
                                    errorText:
                                        'Password must be atlist 6 digit'),
                                MaxLengthValidator(
                                    errorText:
                                        'Password can upto 10 digit only',
                                    10),
                                PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                    errorText:
                                        'Password must be atlist one special character')
                              ]),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Colors.green,
                                ),
                                suffixIcon: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Image.asset(
                                      _hiddenImage(),
                                      alignment: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                                errorStyle: const TextStyle(fontSize: 18.0),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(9.0))),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    adduserEmail();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const Homescreen()));
                                  }
                                },
                              ),
                            ),
                          ),
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
