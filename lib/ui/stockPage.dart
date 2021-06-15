import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockPage extends StatefulWidget {
  String ticker;

  StockPage(this.ticker);

  static const financialModelApi = '5f80b5f5c878b03ce7c90747ff583321';

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  List _quote = [
    {
      'name': '',
      'price': 0.00,
      'open': 0.00,
      'previousClose': 0.00,
      'priceAvg50': 0.00,
      'priceAvg200': 0.00,
      'changesPercentage': 0.00,
      'change': 0.00,
      'dayLow': 0.00,
      'dayHigh': 0.00,
      'yearLow': 0.00,
      'yearHigh': 0.00,
      'marketCap': 0.00,
      'volume': 0.00,
      'eps': 0.00,
      'pe': 0.00
    }
  ];

  Future<void> getQuote(ticker) async {
    final response = await http.get(Uri.parse(
        'https://financialmodelingprep.com/api/v3/quote/${widget.ticker}?apikey=${StockPage.financialModelApi}'));

    setState(() {
      if (response.body != null) {
        this._quote = jsonDecode(response.body);
        print(_quote);
      }
    });
    return;
  }

  @override
  void initState() {
    getQuote(widget.ticker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.ticker),
        ),
        body: ListView.builder(
          itemCount: _quote.length,
          itemBuilder: (context, i) {
            return Container(
                child: Column(
              children: [
                Text(
                  '${_quote[0]['name']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                Text(
                  'Price: \$${_quote[0]['price'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Open: \$${_quote[0]['open'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Previous Close: \$${_quote[0]['previousClose'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  '50 Day Avg: \$${_quote[0]['priceAvg50'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  '200 Day Avg: \$${_quote[0]['priceAvg200'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Change: ${_quote[0]['changesPercentage'].toStringAsFixed(2)}%',
                  style: TextStyle(
                      color: (_quote[0]['changesPercentage'] >= 0)
                          ? Colors.green
                          : Colors.red,
                      fontSize: 20),
                ),
                Text(
                  'Change: \$${_quote[0]['change'].toStringAsFixed(2)}',
                  style: TextStyle(
                      color: (_quote[0]['change'] >= 0)
                          ? Colors.green
                          : Colors.red,
                      fontSize: 20),
                ),
                Text(
                  'Day Low: \$${_quote[0]['dayLow'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Day High: \$${_quote[0]['dayHigh'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Year Low: \$${_quote[0]['yearLow'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Year High: \$${_quote[0]['yearHigh'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Market Cap: \$${_quote[0]['marketCap'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Volume: ${_quote[0]['volume']}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'EPS: ${_quote[0]['eps'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'PE: ${_quote[0]['pe'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ));
          },
        ));
  }
}
