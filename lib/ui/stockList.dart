import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockList extends StatefulWidget {
  StockList({key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List _stockList = [];
  static const baseUrl = 'https://finnhub.io';
  static const apiKey = 'c30iociad3i9gms5t1v0';

  Future<void> getStockPrices() async {
    final response = await http.get(
      Uri.parse(
          'https://finnhub.io/api/v1/stock/symbol?exchange=US&token=$apiKey'),
    );
    setState(() {
      this._stockList = jsonDecode(response.body);
      print(_stockList);
    });
    return;
  }

  @override
  void initState() {
    //override creation of state so that we can call our function
    getStockPrices(); //this function is called which then sets the state of our app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Stocks"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.black87,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Ticker',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
