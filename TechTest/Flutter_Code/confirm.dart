import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class ConfirmScreen extends StatefulWidget {
  final String Email;

  ConfirmScreen({@required this.Email});

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  String _code;

  void _verifyCode(BuildContext context) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: widget.Email, confirmationCode: _code);
      if (result.isSignUpComplete) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile()),
        );
      }
    } on AuthException catch (e) {}
  }

  void _resendCode(BuildContext context) async {
    try {
      final result =
          await Amplify.Auth.resendSignUpCode(username: widget.Email);
    } on AuthException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Code!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shadowColor: Colors.red,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.15, left: deviceWidth * 0.01),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  hintText: 'Enter code',
                ),
                onChanged: (val) {
                  _code = val;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _verifyCode(context);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                ),
                child: Text("Confirm code!")),
            ElevatedButton(
                onPressed: () {
                  _resendCode(context);
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                ),
                child: Text("Resend code!")),
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.1),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    "http://ww1.prweb.com/prfiles/2020/05/13/17121435/95894959_116496096711411_7814852381308354560_n.png"),
              ),
            )
          ],
        ));
  }
}
