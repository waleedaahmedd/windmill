import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:windmill_general_trading/modals/modals_exporter.dart';

class SmsRequest {
  static var header = {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
  };
  Future sendSMS(String message) async {
    String key = "cy0344cAnYaUc2ZA5lj1mg==";
    try {
      String _url =
          "https://japi.instaalerts.zone/httpapi/QueryStringReceiver?ver=1.0&key=${key}==&encrpt=0&dest=971569928261&send=WNDMLLCELLR&text=${message}";
      Uri url = Uri.parse(_url);
      http.get(url, headers: {"value": _base64Encoded(key)}).then(
          (value) => {print("---done" + value.body.toString())});
    } catch (e) {
      throw (e);
    }
  }
  Future sendSMSOrderCompletion(OrderModal order,String message) async {
    String key = "cy0344cAnYaUc2ZA5lj1mg==";
    try {
      String _url =
          "https://japi.instaalerts.zone/httpapi/QueryStringReceiver?ver=1.0&key=${key}==&encrpt=0&dest=${order.billing.phone}&send=WNDMLLCELLR&text=${message}";
      Uri url = Uri.parse(_url);
      http.get(url, headers: {"value": _base64Encoded(key)}).then(
              (value) => {print("---done" + value.body.toString())});
    } catch (e) {
      throw (e);
    }
  }

  String _base64Encoded(key) {
    String credentials = "windmill:${key}";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded =
        stringToBase64Url.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
    // String decoded = stringToBase64Url.decode(encoded);
    return encoded;
  }
}
