import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'profile.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _pass;

  //Function to sign in
  Future<String> _onSignin(BuildContext context) async {
    try {
      //making sure no one is signed in before
      await Amplify.Auth.signOut();

      //logging in using username and password
      final res = await Amplify.Auth.signIn(username: _email, password: _pass);

      //if succesfull go to profile page
      if (res.isSignedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => profile()));
      }
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  @override
  Widget build(BuildContext context) {
    //Captures relative size of device
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Log in',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shadowColor: Colors.red,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            //Padding to create a text form feild for first name
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.085, left: deviceWidth * 0.01),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: 'Enter your Email',
                ),
                onChanged: (text) {
                  _email = text;
                },
              ),
            ),
            //Padding to create a text form feild for last name
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.025, left: deviceWidth * 0.01),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: 'Enter your Password',
                ),
                onChanged: (val) {
                  _pass = val;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _onSignin(context);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                ),
                child: Text("Log in!")),
            Text("or"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                ),
                child: Text("Sign up!")),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    "http://ww1.prweb.com/prfiles/2020/05/13/17121435/95894959_116496096711411_7814852381308354560_n.png"),
              ),
            ),
          ],
        ));
  }
}
