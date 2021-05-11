import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'login.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  //Variables

  bool _amplifyConfigured = false; // Starting out as false

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    final storage = AmplifyStorageS3();

    //Try catch statement in-case of any configuration errors.
    try {
      //Adding amplify plugins
      Amplify.addPlugins([auth, analytics, storage]);

      await Amplify.configure(amplifyconfig);

      //Setting configured to true
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException catch (e) {
      //prints error if caught
      print(e);
    }
  }

  //Widget for app design build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Background colour set to grey
        backgroundColor: Colors.grey,
        body: Center(
          child: _amplifyConfigured ? Login() : CircularProgressIndicator(),
        ));
  }
}
