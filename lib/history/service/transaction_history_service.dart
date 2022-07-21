import 'dart:convert';

import 'package:flutter/material.dart';

import '../../api_url.dart';
import 'package:http/http.dart' as http;



class HistoryAccount {
  static getHistoryAccount(String id,String accountId) async {
    String apiUrl = url_api+"/rest/account/transaction/log";

    Uri uri = Uri.parse(apiUrl);

    Map<String, String> queryParams = {
      'accountSrcId': accountId,
    };

    final finalUri = uri.replace(queryParameters: queryParams);
    print(finalUri);

    var apiResult = await http.get(
        finalUri,
        headers: {
          '_sessionId' : id
        }
    );

    var jsonObject = json.decode(apiResult.body);
    print(jsonObject);

    return jsonObject;
  }
}