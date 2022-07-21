import 'package:flutter/material.dart';
import 'package:mockva_mobile_test/transfer/transfer_inquiry.dart';

import 'account/account_setting.dart';
import 'history/transaction_history.dart';
import 'home/main_home.dart';



class MainNavigation extends StatefulWidget {
  // const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {


  int _selectedIndex = 0;


  List<Widget> _widgetOptions = <Widget>[
    MainHome(),
    TransferInquiry(),
    TransactionHistory(),
    AccountSetting()
  ];


  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // fixedColor: Colors.deepOrange,
        //unselectedItemColor: Colors.black,
        type:BottomNavigationBarType.fixed,
        // showSelectedLabels: true,
        // showUnselectedLabels: false,
        //selectedItemColor: Colors.deepOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            title: Text('Transfer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
