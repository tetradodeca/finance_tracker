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

  @override
  void initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {});
  }

  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsPrecision(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Your Dashboard"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              
            },
          )
        ],
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
                    return Container(
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 1,),
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
                            },)
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
    //   bottomNavigationBar: new Theme(
    // data: Theme.of(context).copyWith(
    //     // sets the background color of the `BottomNavigationBar`
    //     canvasColor: Colors.blue,
    //     // sets the active color of the `BottomNavigationBar` if `Brightness` is light
    //     primaryColor: Colors.red,
    //     textTheme: Theme
    //         .of(context)
    //         .textTheme
    //         .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
    // child: BottomNavigationBar(
    //     unselectedItemColor: Colors.white70,
    //     selectedItemColor: Colors.orange[100],
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.monetization_on),
    //         label: 'Crypto',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.attach_money),
    //         label: 'Stocks',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.assessment),
    //         label: 'Dashboard',
    //       ),
    //     ],
    //   ),
    // ));
    );}
}
