import 'package:flutter/material.dart';
import 'package:mockva_mobile_test/history/service/transaction_history_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TransactionHistory extends StatefulWidget {
  // const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}


var dummyData = [
    "ID1",
    "ID2",
    "ID3",
    "ID4"
];

var dataHistory;

class _TransactionHistoryState extends State<TransactionHistory> {


  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  String sessionId;
  String AccountId;


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

    HistoryAccount.getHistoryAccount(sessionId, AccountId)
        .then((value) {
      dataHistory = value;
      this.setState(() {
        dataHistory = value;
        print(dataHistory);
      });
    });
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
        title: Text("History",style: TextStyle(fontFamily: 'Raleway'),),),
      body: ListView.builder(
          itemCount: dataHistory == [] ? Center(child: Text("Data Kosong"),) :  dataHistory['data'].length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Date :",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 12),),
                          Text(dataHistory['data'][index]['transactionTimestamp'] ?? "-" ,style: TextStyle(fontFamily: 'Raleway',fontSize: 12)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Amount :",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 12)),
                          Text(dataHistory['data'][index]['amount'].toString() ?? "-",style: TextStyle(fontFamily: 'Raleway',fontSize: 12) ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Ref :",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 12) ),
                          Text(dataHistory['data'][index]['clientRef'] ?? "-",style: TextStyle(fontFamily: 'Raleway',fontSize: 12) ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Destination :",style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 12)),
                          Text(dataHistory['data'][index]['accountDstId'] ?? "-",style: TextStyle(fontFamily: 'Raleway',fontSize: 12) ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1.5,
                      ),

                    ],
                  ),
                ),
              ),
            );

          }),
    );
  }
}
