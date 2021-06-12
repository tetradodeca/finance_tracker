import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoList extends StatefulWidget {
  CryptoList({key}) : super(key: key);

  @override
  _CryptoListState createState() => _CryptoListState();
}

class _CryptoListState extends State<CryptoList> {
  List _cryptoList = [];
  Future<void> getCryptoPrices() async {
    print('getting crypto prices');
    String _apiURL =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"; //url to get data
    http.Response response = await http.get(_apiURL);
    setState(() {
      this._cryptoList =
          jsonDecode(response.body); 
      print(_cryptoList);
    });
    return;
  }

  @override
  void initState() {
    //override creation of state so that we can call our function
    getCryptoPrices(); //this function is called which then sets the state of our app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Cryptocurrency"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            )
          ],
        ),
        body: Column(children: [
          Container(
              padding: EdgeInsets.all(10),
              color: Colors.black87,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "#",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "USD \$",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "% + -",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                ],
              )),
          Expanded(
            child: new ListView.builder(
              itemCount: _cryptoList.length,
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height / 12,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${_cryptoList[i]['market_cap_rank']}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "${_cryptoList[i]['id']}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "\$${_cryptoList[i]['current_price'].toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "\$${_cryptoList[i]['price_change_24h'].toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${_cryptoList[i]['price_change_percentage_24h'].toStringAsFixed(2)}%",
                          style: TextStyle(
                            color: (_cryptoList[i]
                                        ['price_change_percentage_24h'] >=
                                    0)
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ]));
  }
}
