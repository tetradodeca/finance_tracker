import 'package:finance_tracker/ui/cryptoList.dart';
import 'package:finance_tracker/ui/home_view.dart';
import 'package:finance_tracker/ui/stockList.dart';
import 'package:flutter/material.dart';
import 'placeholder_widget.dart';

class DashBoard extends StatefulWidget {
  DashBoard({key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeView(),
    CryptoList(),
    StockList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.blue,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors
                          .yellow))), // sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
            unselectedItemColor: Colors.white70,
            selectedItemColor: Colors.orangeAccent,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on),
                label: 'Crypto',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: 'Stocks',
              ),
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
