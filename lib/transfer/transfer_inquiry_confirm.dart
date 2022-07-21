import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mockva_mobile_test/transfer/transfer_inquiry.dart';
import 'package:mockva_mobile_test/transfer/transfer_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../api_url.dart';


class TransferInquiryConfirm extends StatefulWidget {

  const TransferInquiryConfirm(
      {Key key,
        @required this.inquiryId,
        @required this.accountSrcId,
        @required this.accountDstId,
        @required this.accountSrcName,
        @required this.accountDstName,
        @required this.amount,

      })
      : super(key: key);

  final String inquiryId,accountSrcId,accountDstId,accountSrcName,accountDstName;
  final int amount;


  @override
  _TransferInquiryConfirmState createState() => _TransferInquiryConfirmState();
}

class _TransferInquiryConfirmState extends State<TransferInquiryConfirm> {


  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String sessionId;
  String AccountId;

  TextEditingController accountsrcController = TextEditingController();
  TextEditingController accountdstController = TextEditingController();
  TextEditingController accountsrcNameController = TextEditingController();
  TextEditingController accountdstNameController = TextEditingController();
  TextEditingController ammountController = TextEditingController();



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


    setState(() {
      accountsrcController =  new TextEditingController(text: widget.accountSrcId);
      accountdstController =  new TextEditingController(text: widget.accountDstId);
      accountsrcNameController =  new TextEditingController(text: widget.accountSrcName);
      accountdstNameController =  new TextEditingController(text: widget.accountDstName);
      ammountController =  new TextEditingController(text: widget.amount.toString());
    });
  }

  transferConfirm() async {

    String url_confirm = url_api + "/rest/account/transaction/transfer" ;

    var apiResult = await http.post(
        url_confirm,
        headers: {
          '_sessionId' : sessionId,
          'Content-type' : 'application/json',
        },
        body: json.encode( {
          "accountSrcId": widget.accountSrcId,
          "accountDstId": widget.accountDstId,
          "amount" : widget.amount,
          "inquiryId" : widget.inquiryId,
        })
    );

    if(apiResult.statusCode == 200){
      print("benar masuk");
      var response = json.decode(apiResult.body);
      print(response);

      print("berhasil dikirim");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransferStatus(

            accountSrcId : response['accountSrcId'],
            accountDstId : response['accountDstId'],
            amount : response['amount'],
            transactionTimestamp : response['transactionTimestamp'].toString(),
            clientRef : response['clientRef'],
            accountSrcName : widget.accountSrcName,
            accountDstName : widget.accountDstName



        )),
      );
    } else {
      _showAlertDialog(context, "Gagal");
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
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              tooltip: 'Transfer',
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return TransferInquiry();
                  },
                ));
              },
            ),
            Text("Transfer")
          ],
        ),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Account Source"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountsrcController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Account Source',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Account Source Name"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountsrcNameController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Account Source Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Account Destination"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountdstController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Account Destination',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Account Destination Name"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: accountdstNameController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Account Destination Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Ammount"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ammountController,
                autofocus: false,
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
                  transferConfirm();
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
                      "Confirm",
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
