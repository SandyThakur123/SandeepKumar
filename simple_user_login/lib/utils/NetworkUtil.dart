import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> post(String url,
      {required Map<String, String> headers, body, encoding}) {
    print('URL->' + url.toString());
    print('Param-->' + body.toString());

    return http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;

      return _decoder.convert(res);
    });
  }
}
