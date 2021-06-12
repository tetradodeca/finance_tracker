import 'package:finance_tracker/net/flutterfire.dart';
import 'package:finance_tracker/ui/dashboard.dart';
import 'package:finance_tracker/ui/home_view.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context)
            .size
            .height, // fills the container to the screen size
        decoration: BoxDecoration(
          // styling for container
          color: Colors.blueAccent,
        ),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _emailField,
              decoration: InputDecoration(
                hintText: "email@email.com",
                hintStyle: TextStyle(
                  color: Colors.white54,
                ),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _passwordField,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                bool shouldNavigate =
                    await register(_emailField.text, _passwordField.text);
                if (shouldNavigate) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoard(),
                    ),
                  );
                }
              },
              child: Text("Register"),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: MaterialButton(
              onPressed: () async {
                bool shouldNavigate =
                    await signIn(_emailField.text, _passwordField.text);
                if (shouldNavigate) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoard(),
                    ),
                  );
                }
              },
              child: Text("Login"),
            ),
          ),
        ]),
      ),
    );
  }
}
