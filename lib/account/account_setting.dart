import 'package:flutter/material.dart';
import 'package:mockva_mobile_test/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../api_url.dart';


class AccountSetting extends StatefulWidget {
  // const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {


  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String sessionId;

  logout()async{

    final SharedPreferences prefs = await _sprefs;

    String id = prefs.getString('id');

    this.setState(() {
      sessionId = id;
    });

    String apiUrl = url_api+"/rest/auth/logout";

    var apiResult = await http.delete(
        apiUrl,
        headers: {
          '_sessionId' : id
        }
    );

    if(apiResult.statusCode != 400 || apiResult.statusCode != 500){
      print("Berhasil");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginApp()),
      );
    } else{
      print("Terjadi Kesalahan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Account',style: TextStyle(fontFamily: 'Raleway'),),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 50,
            child: RaisedButton(
              onPressed: (){

                _showAlertDialog(context);

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
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  constraints: BoxConstraints(minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => logout(),
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Apakah yakin ingin keluar aplikasi?"),
      actions: [
        cancelButton,
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
