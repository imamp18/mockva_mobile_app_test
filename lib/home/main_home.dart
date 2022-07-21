import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mockva_mobile_test/home/service/detail_account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../api_url.dart';


class MainHome extends StatefulWidget {
  // const MainHome({Key? key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

var dataresponDetail;

class _MainHomeState extends State<MainHome> {

   TextEditingController accountNumberController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController balanceController = TextEditingController();

   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




   Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String sessionId;
  String AccountId;
  String errorString;

  @override
  Future<Null> getData() async {
    final SharedPreferences prefs = await _sprefs;

    String id = prefs.getString('id');
    String accountId = prefs.getString('accountId');
    String errorInvalid =  prefs.getString('errorinvalid');

    this.setState(() {
      sessionId = id;
      AccountId = accountId;
      errorString = errorInvalid;

    });
    print(id);

    DetailAccount.getDetailAccount(sessionId, AccountId)
        .then((value) {
          print(value.toString());
      dataresponDetail = value;
      this.setState(() {
        dataresponDetail = value;
        print(dataresponDetail);

        loadText();
      });
    });

  }

  loadText()async{
    //Set to
    setState(() {
      accountNumberController =  new TextEditingController(text: dataresponDetail['id']);
      nameController =  new TextEditingController(text: dataresponDetail['name']);
      balanceController =  new TextEditingController(text: dataresponDetail['balance'].toString());
    });

  }

   showError (context,errorResult) {
     return Scaffold.of(context).showSnackBar(
         SnackBar(
           content: Text(errorResult),
           duration: Duration(seconds: 2),
         )
     );
   }



  @override
  void initState() {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Mockva Mobile",style: TextStyle(fontFamily: 'Raleway'),),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Account Number",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: accountNumberController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Account Number',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Name",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Balance",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: balanceController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: '0',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              SizedBox(
                height: 15,
              ),

            ],
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
