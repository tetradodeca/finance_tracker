import 'package:finance_tracker/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  AddView({key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
    "binancecoin",
    "cardano",
    "dogecoin",
    "ripple",
    "polkadot",
    "uniswap",
    "litecoin"
  ];

  String dropDownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: dropDownValue,
          onChanged: (String? value) {
            setState(() {
              dropDownValue = value!;
            });
          },
          items: coins.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextFormField(
            controller: _amountController,
            decoration: InputDecoration(
              labelText: "Coin Amount",
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
            onPressed: () async {
              await addCoin(dropDownValue, _amountController.text);
              Navigator.of(context).pop();
            },
            child: Text("Add"),
          ),
        ),
      ]),
    );
  }
}
