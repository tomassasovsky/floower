import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserPreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var resBody = {};
  resBody["username"] = preferences.getString("username");
  resBody["fullname"] = preferences.getString("fullname");
  resBody["email"] = preferences.getString("email");
  return json.encode(resBody);
}
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final formKey = GlobalKey<FormState>();
  Future getUP = getUserPreference();

  _saveUserPreferences(
      String jFullname, String jEmail, String jUsername) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("fullname", jFullname);
    preferences.setString("email", jEmail);
    preferences.setString("username", jUsername);
  }

  var emailTEC;
  var nameTEC;
  var usernameTEC;

  builder() {
    return FutureBuilder(
        future: getUP,
        builder: (context, snapshot) {
          var json = jsonDecode(snapshot.data);
          emailTEC = TextEditingController(text: json["email"]);
          nameTEC = TextEditingController(text: json["fullname"]);
          usernameTEC = TextEditingController(text: json["username"]);
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email address"),
                  TextFormField(
                    cursorColor: Colors.white,
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700])),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700]))),
                    validator: (input) =>
                        input.length <= 0 ? "Field cannot be empty" : null,
                    controller: emailTEC,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15),
                  Text("Name"),
                  TextFormField(
                    cursorColor: Colors.white,
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700])),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700]))),
                    validator: (input) =>
                        input.length <= 0 ? "Field cannot be empty" : null,
                    controller: nameTEC,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15),
                  Text("Username"),
                  TextFormField(
                    cursorColor: Colors.white,
                    cursorWidth: 0.5,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700])),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.7, color: Colors.grey[700]))),
                    validator: (input) =>
                        input.length <= 0 ? "Field cannot be empty" : null,
                    controller: usernameTEC,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tr('editAccountInformation')),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                _submit();
                _saveUserPreferences(nameTEC.text, emailTEC.text, usernameTEC.text);
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Navigator.pop(context);
              }
            )
          ]
        ),
        body: builder());
  }
  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}
