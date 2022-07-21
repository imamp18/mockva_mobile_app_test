import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api_url.dart';


class DetailAccount {
  static getDetailAccount(String id,String accountId) async {
    String apiUrl = url_api+"/rest/account/detail";

    Uri uri = Uri.parse(apiUrl);

    Map<String, String> queryParams = {
      'id': accountId,
    };

    final finalUri = uri.replace(queryParameters: queryParams);
    print(finalUri);

    var apiResult = await http.get(
        finalUri,
        headers: {
          '_sessionId' : id
        }
    );

    print(apiResult.statusCode);
    print(apiResult.body);


    var jsonObject = json.decode(apiResult.body);
    print(jsonObject);

    return jsonObject;
  }



}