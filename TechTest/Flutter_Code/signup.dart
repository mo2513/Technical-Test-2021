import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'confirm.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email = "i";
  String _pass;
  String _name;

//Function to signup user
  Future<String> _onSignup(
    BuildContext context,
  ) async {
    try {
      //signup using email, password and sername
      await Amplify.Auth.signUp(
        username: _email,
        password: _pass,
        options: CognitoSignUpOptions(
          userAttributes: {"email": _email},
        ),
      );

      //if succesfull go to profile page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(Email: _email)));
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
            'Create a New Account',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shadowColor: Colors.red,
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
                  hintText: 'Enter your Name',
                ),
                onChanged: (text) {
                  _name = text;
                },
              ),
            ),
            //Padding to create a text form feild for last name

            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.025, left: deviceWidth * 0.01),
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
                onChanged: (text) {
                  _pass = text;
                },
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  _onSignup(context);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                ),
                child: Text("Sign up!")),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "http://ww1.prweb.com/prfiles/2020/05/13/17121435/95894959_116496096711411_7814852381308354560_n.png"),
              ),
            )
          ],
        ));
  }
}
