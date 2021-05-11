import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';
import 'webview.dart';

class profile extends StatefulWidget {
  final String name;

  profile({@required this.name});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  File _pickedImage;
  final picker = ImagePicker();

  @override
  //Function to load picture
  void _loadPicture(ImageSource src) async {
    PickedFile finalPic = await picker.getImage(source: src);
    if (finalPic != null) {
      setState(() {
        _pickedImage = File(finalPic.path);

      });
    }
  }
  
//Textile function to show options for source of picture
  void _showPickupOptions(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Pick from Gallery"),
                    onTap: () {
                      _loadPicture(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    title: Text("Use Camera"),
                    onTap: () {
                      _loadPicture(ImageSource.camera);
                    },
                  )
                ],
              ),
            ));
  }

  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homepage!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        shadowColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(top: deviceHeight * 0.05, left: deviceWidth)),
          CircleAvatar(
            radius: 82,
            backgroundColor: Colors.red,
            child: CircleAvatar(
              radius: 80,
              child: _pickedImage == null ? Text("Profile Picture") : null,
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage) : null,

            ),
          ),
          ElevatedButton(
              onPressed: () {
                _showPickupOptions(context);
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.red,
              ),
              child: Text("Pick image")),
          Padding(
              padding:
                  EdgeInsets.only(top: deviceHeight * 0.3, left: deviceWidth)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => webView()));
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.red,
              ),
              child: Text("Profiles")),
          ElevatedButton(
              onPressed: () {
                Amplify.Auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.red,
              ),
              child: Text("Sign out")),
        ],
      ),
    );
  }
}
