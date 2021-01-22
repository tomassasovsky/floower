import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:floower/editProfile.dart';
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
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr('choosePhoto'),
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextButton.icon(
                          icon: Icon(Icons.camera, color: Colors.black),
                          onPressed: () {
                            takePhoto(ImageSource.camera)
                                .then((value) => Navigator.pop(context));
                          },
                          label: Text(tr('camera'),
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.image, color: Colors.black),
                          onPressed: () {
                            takePhoto(ImageSource.gallery)
                                .then((value) => Navigator.pop(context));
                          },
                          label: Text(tr('gallery'),
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.delete, color: Colors.black),
                          onPressed: () {
                            savePhotoDirPreference("")
                                .then((value) => Navigator.pop(context));
                          },
                          label: Text(tr('removePhoto'),
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ]),
            )),
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
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Color(0xffecebf0)));
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
                  style: TextStyle(
                      fontWeight: FontWeight.w300, color: Color(0xffecebf0)));
            }
            return Text("");
          });
    }

    _profileImage() {
      return StreamBuilder(
          stream: imagePathStream.stream,
          builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data != '') {
                log(snapshot.data);
                filePath = snapshot.data;
                return GestureDetector(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(filePath)),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                );
              } else {
                return GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    child: Icon(Icons.person, size: 80),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet()),
                    );
                  },
                );
              }
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
              color: Color(0xff201f25),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  _profileImage(),
                  SizedBox(height: 10),
                  _userFullName(),
                  SizedBox(height: 5),
                  _userName(),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(IconData(0xe900, fontFamily: 'flower'),
                    color: Color(0xffecebf0)),
                title: Text(tr('addFloower'),
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Color(0xffecebf0))),
                onTap: () {},
              ),
              Divider(thickness: 0.3, height: 0.3, color: Color(0xff242424)),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xffecebf0)),
                title: Text(tr('personalInformation'),
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Color(0xffecebf0))),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => EditProfile()));
                },
              ),
              Divider(thickness: 0.3, height: 0.3, color: Color(0xff242424)),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xffecebf0)),
                title: Text(tr('settings'),
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Color(0xffecebf0))),
                onTap: () {
                  _profileImage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}