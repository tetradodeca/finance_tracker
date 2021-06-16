import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/net/api_methods.dart';
import 'package:finance_tracker/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_view.dart';

class HomeView extends StatefulWidget {
  HomeView({key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  double binanceCoin = 0.0;
  double cardano = 0.0;
  double dogeCoin = 0.0;
  double ripple = 0.0;
  double polkadot = 0.0;
  double uniswap = 0.0;
  double litecoin = 0.0;
  double totalCrypto = 0.0;

  @override
  void initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    binanceCoin = await getPrice("binancecoin");
    cardano = await getPrice("cardano");
    dogeCoin = await getPrice("dogecoin");
    ripple = await getPrice("ripple");
    polkadot = await getPrice("polkadot");
    uniswap = await getPrice("uniswap");
    litecoin = await getPrice("litecoin");
    setState(() {});
  }

  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else if (id == "tether") {
        return (tether * amount).toStringAsFixed(2);
      } else if (id == "binancecoin") {
        return (binanceCoin * amount).toStringAsFixed(2);
      } else if (id == "cardano") {
        return (cardano * amount).toStringAsFixed(2);
      } else if (id == "dogecoin") {
        return (dogeCoin * amount).toStringAsFixed(2);
      } else if (id == "ripple") {
        return (ripple * amount).toStringAsFixed(2);
      } else if (id == "polkadot") {
        return (polkadot * amount).toStringAsFixed(2);
      } else if (id == "uniswap") {
        return (uniswap * amount).toStringAsFixed(2);
      } else {
        return (litecoin * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Your Dashboard"),
      ),
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    // totalCrypto = totalCrypto + double.parse(getValue(document.id, document.data()['amount']));
                    return Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            "${document.id}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${document.data()['Amount']}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "\$${getValue(document.id, document.data()['Amount'])}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: () async {
                              await removeCoin(document.id);
                            },
                          ),
                          // Text(totalCrypto.toString(), style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddView()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
