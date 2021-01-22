import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  String fullname;
  String username;
  String email;
  String password;

  _saveUserPreferences(String jFullname, String jEmail, String jUsername,
      String jPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("fullname", jFullname);
    preferences.setString("email", jEmail);
    preferences.setString("username", jUsername);
    preferences.setString("password", jPassword);
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Positioned.fill(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.012),
                          DropdownButton(
                            dropdownColor: Colors.blueGrey[900],
                            style: TextStyle(color: Colors.white),
                            underline: Container(
                              height: 0.6,
                              color: Colors.white,
                            ),
                            items: [
                              DropdownMenuItem(
                                  value: Locale('en'), child: Text(languages[0])),
                              DropdownMenuItem(
                                  value: Locale('es'), child: Text(languages[1])),
                              DropdownMenuItem(
                                  value: Locale('ru'), child: Text(languages[2])),
                            ],
                            onChanged: (v) => setState(() {
                              context.locale = v;
                              setLanguagePreference(v.toString());
                            }),
                            value: context.locale,
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                              Text('floower',
                                  style: TextStyle(
                                      letterSpacing: 3.0,
                                      fontFamily: "NotoSerifSC",
                                      fontSize: 40.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100)),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8783,
                                height: MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  cursorWidth: 0.5,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    hintText: tr('fullnameField'),
                                    hintStyle: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white60,
                                        fontSize: 14),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                  ),
                                  validator: (input) => input.length <= 0
                                      ? "Field cannot be empty"
                                      : null,
                                  onSaved: (input) {
                                    setState(() {
                                      fullname = input;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Divider(color: Colors.transparent, height: MediaQuery.of(context).size.height * 0.012),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8783,
                                height: MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  cursorWidth: 0.5,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    hintText: tr('emailField'),
                                    hintStyle: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white60,
                                        fontSize: 14),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                  ),
                                  validator: (input) => input.length <= 0
                                      ? "Field cannot be empty"
                                      : null,
                                  onSaved: (input) {
                                    setState(() {
                                      email = input;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Divider(color: Colors.transparent, height: MediaQuery.of(context).size.height * 0.012),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8783,
                                height: MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  cursorWidth: 0.5,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    hintText: tr('usernameField'),
                                    hintStyle: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white60,
                                        fontSize: 14),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                  ),
                                  validator: (input) => input.length <= 0
                                      ? "Field cannot be empty"
                                      : null,
                                  onSaved: (input) {
                                    setState(() {
                                      username = input;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Divider(color: Colors.transparent, height: MediaQuery.of(context).size.height * 0.012),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8783,
                                height: MediaQuery.of(context).size.height * 0.065,
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  cursorWidth: 0.5,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey[800],
                                    filled: true,
                                    hintText: tr('passwordField'),
                                    hintStyle: TextStyle(
                                        backgroundColor: Colors.transparent,
                                        color: Colors.white60,
                                        fontSize: 14),
                                    alignLabelWithHint: false,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0),
                                    ),
                                  ),
                                  validator: (input) => input.length <= 0
                                      ? "Field cannot be empty"
                                      : null,
                                  onSaved: (input) {
                                    setState(() {
                                      password = input;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Divider(color: Colors.transparent, height: MediaQuery.of(context).size.height * 0.012),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8783,
                                height: MediaQuery.of(context).size.height * 0.055,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[700],
                                    onPrimary: Colors.white,
                                  ),
                                  child: Text(tr('signUpButton'),
                                      style: TextStyle(fontFamily: "NotoSerifSC"),
                                      textScaleFactor: 1.2),
                                  onPressed: () {
                                    if (_submit()) {
                                      _saveUserPreferences(
                                          fullname, email, username, password);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  },
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
              ]
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
    );
  }
}