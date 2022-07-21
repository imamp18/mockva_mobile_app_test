import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mockva_mobile_test/transfer/transfer_inquiry_confirm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../api_url.dart';


class TransferInquiry extends StatefulWidget {
  // const TransferInquiry({Key? key}) : super(key: key);

  @override
  _TransferInquiryState createState() => _TransferInquiryState();
}


class _TransferInquiryState extends State<TransferInquiry> {


  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String sessionId;
  String AccountId;

  List<dynamic> list;



  final TextEditingController accountDestController = TextEditingController();
  final TextEditingController ammountController = TextEditingController();


  //get data dari shared preference
  @override
  Future<Null> getData() async {
    final SharedPreferences prefs = await _sprefs;

    String id = prefs.getString('id');
    String accountId = prefs.getString('accountId');

    this.setState(() {
      sessionId = id;
      AccountId = accountId;

    });
    print(id);

  }


  transferInquiry() async {

    String url_tfi = url_api + "/rest/account/transaction/transferInquiry" ;

    var apiResult = await http.post(
        url_tfi,
        headers: {
          '_sessionId' : sessionId,
          'Content-type' : 'application/json',
        },
        body: json.encode( {
          "accountSrcId": AccountId,
          "accountDstId": accountDestController.text,
          "amount" : ammountController.text
        })
    );

    if(apiResult.statusCode == 200){
      print("benar masuk");
      var response = json.decode(apiResult.body);
      print(response);


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransferInquiryConfirm(
          inquiryId : response['inquiryId'],
          accountSrcId : response['accountSrcId'],
          accountDstId : response['accountDstId'],
          accountSrcName : response['accountSrcName'],
          accountDstName : response['accountDstName'],
          amount : response['amount'],

        )),
      );
    } else {

      _showAlertDialog(context, apiResult.body);
    }

  }


  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Transfer"),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Account Destination",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: accountDestController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Destination',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Ammount",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ammountController,
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ammount',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: (){
                transferInquiry();
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
                    "Transfer",
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
