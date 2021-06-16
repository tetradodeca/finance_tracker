import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoPage extends StatefulWidget {
  String name;

  CryptoPage(this.name);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  var data = {};

  Future<void> getCrypto(name) async {
    final response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/coins/${widget.name}'));

    setState(() {
      if (response.body != null) {
        this.data = jsonDecode(response.body);
        print(data);
      }
    });
    return;
  }

  @override
  void initState() {
    getCrypto(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(data['symbol']!.toUpperCase()),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            SizedBox(height: 100),
            Text(
              '${data['id']!.toUpperCase()}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Text(
              'Price: \$${data['market_data']['current_price']['usd']}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'ATH: \$${data['market_data']['ath']['usd']}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
                'ATH Change: ${data['market_data']['ath_change_percentage']['usd'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color: (data['market_data']['ath_change_percentage']
                                ['usd'] >=
                            0)
                        ? Colors.green
                        : Colors.red,
                    fontSize: 20)),
            Text(
              '24H Price Change: \$${data['market_data']['price_change_24h_in_currency']['usd'].toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
                '24H Change: ${data['market_data']['price_change_percentage_24h'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color: (data['market_data']
                                ['price_change_percentage_24h'] >=
                            0)
                        ? Colors.green
                        : Colors.red,
                    fontSize: 20)),
            Text(
                '7d Change: ${data['market_data']['price_change_percentage_7d'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color:
                        (data['market_data']['price_change_percentage_7d'] >= 0)
                            ? Colors.green
                            : Colors.red,
                    fontSize: 20)),
            Text(
                '14d Change: ${data['market_data']['price_change_percentage_14d'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color: (data['market_data']
                                ['price_change_percentage_14d'] >=
                            0)
                        ? Colors.green
                        : Colors.red,
                    fontSize: 20)),
            Text(
                '30d Change: ${data['market_data']['price_change_percentage_30d'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color: (data['market_data']
                                ['price_change_percentage_30d'] >=
                            0)
                        ? Colors.green
                        : Colors.red,
                    fontSize: 20)),
            Text(
                '60d Change: ${data['market_data']['price_change_percentage_60d'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color: (data['market_data']
                                ['price_change_percentage_60d'] >=
                            0)
                        ? Colors.green
                        : Colors.red,
                    fontSize: 20)),
            Text(
                '1Y Change: ${data['market_data']['price_change_percentage_1y'].toStringAsFixed(2)}%',
                style: TextStyle(
                    color:
                        (data['market_data']['price_change_percentage_1y'] >= 0)
                            ? Colors.green
                            : Colors.red,
                    fontSize: 20)),
          ]),
        ),
      ),
    );
  }
}
