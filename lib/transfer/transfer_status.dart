import 'package:flutter/material.dart';

import '../main_navigation.dart';


class TransferStatus extends StatefulWidget {
  const TransferStatus(
      {Key key,
        @required this.accountSrcId,
        @required this.accountDstId,
        @required this.accountSrcName,
        @required this.accountDstName,
        @required this.clientRef,
        @required this.transactionTimestamp,
        @required this.amount,

      })
      : super(key: key);

  final String accountSrcId,accountDstId,accountSrcName,accountDstName,clientRef,transactionTimestamp;
  final int amount;

  @override
  _TransferStatusState createState() => _TransferStatusState();
}

class _TransferStatusState extends State<TransferStatus> {
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
                    return MainNavigation();
                  },
                ));
              },
            ),
            Text("Transfer")
          ],
        ),),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Account Source",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.accountSrcId ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Account Source Name",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.accountSrcName ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Account Destination",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.accountDstId ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Account Destination Name",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.accountDstName ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Amount",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.amount.toString() ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Reference Number",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.clientRef ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Transaction Timestamp",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),
              Text(widget.transactionTimestamp ?? "-",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600,fontSize: 18)),
              SizedBox(
                height: 15,
              ),
              Text("Status",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 14)),
              SizedBox(
                height: 5,
              ),

              Text("SUCCESS",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blueAccent)),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
