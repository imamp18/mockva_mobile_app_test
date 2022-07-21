import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../api_url.dart';
import '../main_navigation.dart';


class LoginApp extends StatefulWidget {
  // const LoginApp({Key? key}) : super(key: key);

  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {

  //Service
  final String apiUrl = url_api+"/rest/auth/login";

  loginApp()async {

    final prefs = await SharedPreferences.getInstance();

    try {
      var res = await post(apiUrl,
          headers: {
            'Content-type' : 'application/json',
          },
          body: json.encode( {
        "username": userNameController.text,
        "password": passwordController.text,
          })
      );

      print('do login');
      print(userNameController.text);
      print(passwordController.text);


      if (res.statusCode == 200) {
        var response = json.decode(res.body);

        //Save Session Id
        prefs.setString('id', response['id']);
        prefs.setString('accountId', response['accountId']);
        print(response);

        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (_) {
          return new MainNavigation();
        }));
      }
      else {
        print('gagal login 1');
        _showAlertDialog(context, res.body);

      }
    } catch (e) {
      print(e);
    }

  }


  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mockva Mobile",style: TextStyle(fontFamily: 'Raleway',fontSize: 26,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 20,
                ),
                TextField(
                controller: userNameController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Username',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    onPressed: () {
                      loginApp();
                    },
                    shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      elevation: 0.0,
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [const Color(0xFF63a4ff), const Color(0xFF83eaf1)]),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),

                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context, String err) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => Navigator.pop(context),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(err),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
