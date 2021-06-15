import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'stockPage.dart';

class StockList extends StatefulWidget {
  StockList({key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  List _stockList = [];
  // static const baseUrl = 'https://finnhub.io';
  // static const finnhubApiKey = 'c30iociad3i9gms5t1v0';
  static const financialModelApi = '5f80b5f5c878b03ce7c90747ff583321';

  Future<void> getStockPrices() async {
    final response = await http.get(
      Uri.parse(
          'https://financialmodelingprep.com/api/v3/stock/list?apikey=$financialModelApi'),
    );
    setState(() {
      this._stockList = jsonDecode(response.body);
      print(_stockList);
    });
    return;
  }

  @override
  void initState() {
    getStockPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Name',
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
                    'USD \$',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _stockList.length,
                  itemBuilder: (context, i) {
                    return Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StockPage('${_stockList[i]['symbol']}')));
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Text(
                                  '${_stockList[i]['name']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${_stockList[i]['symbol']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '\$${_stockList[i]['price']}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
