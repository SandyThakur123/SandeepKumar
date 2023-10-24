import 'dart:convert';
import 'package:simple_user_login/utils/NetworkUtil.dart';
import 'package:simple_user_login/Presenter/Comman_contact.dart';

class CommanPresenter {
  CommanContract _view;
  CommanPresenter(this._view) {}
  NetworkUtil _netUtil = new NetworkUtil();

  void fetchPostApiResponse(String? url,
      {Object? value1, String? value2}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    String params = jsonEncode(value1);
    //print("Param-->" + params);

    _netUtil.post(url!, body: params, headers: headers).then((dynamic res) {
      Map<String, dynamic> decoded = res;
      // print(decoded);
      var data = decoded;
      // print("object");
      print(res);
      if (decoded.isNotEmpty) {
        //print(res);
        /// String message = data['message'] == null ? '-' : data['message'];
        var success = data['data'] == null ? '-' : data['data'];

        if (success != null && success != '' && success != '-') {
          if (data['statusCode'] == 200) {
            print('Success full => $data');
            // print(data);

            _view.Succes(data);
          } else {
            _view.Failed();
          }
        } else {
          _view.Failed();
        }
      }
    });
  }
}
