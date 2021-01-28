import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:floower/editProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var resBody = {};
  resBody["username"] = preferences.getString("username");
  resBody["fullname"] = preferences.getString("fullname");
  resBody["email"] = preferences.getString("email");
  return json.encode(resBody);
}

class ProfilePage extends StatefulWidget {
  final path;
  ProfilePage({Key key, this.path}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future getPhotoDirPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    imagePathStream.sink.add(preferences.getString("profileImage"));
  }

  Future<bool> savePhotoDirPreference(String dir) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    imagePathStream.sink.add(dir);
    return preferences.setString("profileImage", dir);
  }

  clearAllSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  final StreamController<String> imagePathStream = StreamController<String>();
  final ImagePicker _picker = ImagePicker();
  String filePath;
  var user;

  @override
  void initState() {
    _getPhotoPath();
    super.initState();
  }

  @override
  void dispose() {
    imagePathStream.close();
    super.dispose();
  }

  _getPhotoPath() async {
    filePath = await getPhotoDirPreference();
    return true;
  }

  @override
  Widget build(context) {
    takePhoto(ImageSource source) async {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        filePath = pickedFile.path;
        savePhotoDirPreference(filePath).then((value) => print(value));
        print(filePath);
      });
    }

    _photoOptions() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: Icon(Icons.camera, color: Colors.black),
              onPressed: () {
                takePhoto(ImageSource.camera)
                    .then((value) => Navigator.pop(context));
              },
              label: Text(tr('camera'), style: TextStyle(color: Colors.black)),
            ),
            TextButton.icon(
              icon: Icon(Icons.image, color: Colors.black),
              onPressed: () {
                takePhoto(ImageSource.gallery)
                    .then((value) => Navigator.pop(context));
              },
              label: Text(tr('gallery'), style: TextStyle(color: Colors.black)),
            ),
            if (filePath != null && filePath != "notSet")
              TextButton.icon(
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () {
                  savePhotoDirPreference("notSet").then(
                      (value) => {Navigator.pop(context), filePath = "notSet"});
                },
                label: Text(tr('removePhoto'),
                    style: TextStyle(color: Colors.black)),
              )
          ]);
    }

    bottomSheet() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  tr('choosePhoto'),
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                _photoOptions(),
              ]),
        ),
      );
    }

    _userFullName() {
      return FutureBuilder(
          future: getUserPreference(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var json = jsonDecode(snapshot.data);
              if (json["fullname"] != null)
                return Text(json["fullname"],
                    style: Theme.of(context).textTheme.headline2);
            }
            return Text(tr('notLoggedIn'));
          });
    }

    _userName() {
      return FutureBuilder(
          future: getUserPreference(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var json = jsonDecode(snapshot.data);
              if (json["fullname"] != null && json["email"] != null)
                return Text(json["username"] + "   -   " + json["email"],
                    style: Theme.of(context).textTheme.headline3);
            }
            return SizedBox.shrink();
          });
    }

    _profileImage() {
      return StreamBuilder(
          stream: imagePathStream.stream,
          builder: (context, snapshot) {
            bool isSet = (snapshot.data != null && snapshot.data != 'notSet');
            if (isSet) filePath = snapshot.data;
            return GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).highlightColor,
                radius: 50,
                backgroundImage: isSet ? FileImage(File(filePath)) : null,
                child: Icon(Icons.person, size: 50, color: isSet ? Colors.transparent : Theme.of(context).iconTheme.color),
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
            );
          }
      );
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.34,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              color: Theme.of(context).cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      _profileImage(),
                    ],
                  ),
                  Column(children: [
                    _userFullName(),
                    SizedBox(height: 5),
                    _userName(),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(IconData(0xe900, fontFamily: 'flower'),
                    color: Theme.of(context).iconTheme.color),
                title: Text(tr('addFloower'),
                    style: Theme.of(context).textTheme.headline1),
                onTap: () {},
              ),
              Divider(thickness: 0.3, height: 0.3, color: Color(0xff242424)),
              ListTile(
                leading: Icon(Icons.person,
                    color: Theme.of(context).iconTheme.color),
                title: Text(tr('personalInformation'),
                    style: Theme.of(context).textTheme.headline1),
                onTap: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => EditProfile()));
                },
              ),
              Divider(thickness: 0.3, height: 0.3, color: Color(0xff242424)),
              ListTile(
                leading: Icon(Icons.remove,
                    color: Theme.of(context).iconTheme.color),
                title: Text("Delete all saved information",
                    style: Theme.of(context).textTheme.headline1),
                onTap: () {
                  clearAllSavedData();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
