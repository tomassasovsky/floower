import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  List<bool> errors = [false, false, false, false];
  String fullname = "", username = "", email = "", password = "";

  _saveUserPreferences(String jFullname, String jEmail, String jUsername,
      String jPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("fullname", jFullname);
    preferences.setString("email", jEmail);
    preferences.setString("username", jUsername);
    preferences.setString("password", jPassword);
  }

  _checkForErrors() {
    var _checkPreErrors = [];
    if (fullname.length < 1) {
      _checkPreErrors.add(tr('errorNameLength'));
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      _checkPreErrors.add(tr('errorEmail'));
    }
    if (!RegExp(r'^[a-zA-Z][a-zA-Z\d-_\.]+$').hasMatch(username)) {
      _checkPreErrors.add(tr('errorUsername'));
    }
    if (password.length < 8) {
      _checkPreErrors.add(tr('errorPassword'));
    }

    return _checkPreErrors.isEmpty;
  }

  _checkForErrorsSubmit() {
    String regexEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    String regexUsername = r'^[a-zA-Z][a-zA-Z\d-_\.]+$';

    setState(() {
      if (fullname.length < 1) {
        errors[0] = true;
      } else {
        errors[0] = false;
      }
      if (!RegExp(regexEmail).hasMatch(email)) {
        errors[1] = true;
      } else {
        errors[1] = false;
      }
      if (!RegExp(regexUsername).hasMatch(username)) {
        errors[2] = true;
      } else {
        errors[2] = false;
      }
      if (password.length < 8) {
        errors[3] = true;
      } else {
        errors[3] = false;
      }
    });
  }

  _submit() {
    _checkForErrorsSubmit();
    var canSubmit = true;
    for (var error in errors) {
      if (error) canSubmit = false;
    }
    if (!canSubmit) return false;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  _buildErrors() {
    return GestureDetector(
      child: Column(children: [
        errors[0]
            ? ListTile(
                leading: Icon(Icons.error_outline, color: Colors.red),
                title: Text(tr('errorNameLength'),
                    style: TextStyle(color: Colors.red)))
            : SizedBox(height: 0, width: 0),
        errors[1]
            ? ListTile(
                leading: Icon(Icons.error_outline, color: Colors.red),
                title:
                    Text(tr('errorEmail'), style: TextStyle(color: Colors.red)))
            : SizedBox(height: 0, width: 0),
        errors[2]
            ? ListTile(
                leading: Icon(Icons.error_outline, color: Colors.red),
                title: Text(tr('errorUsername'),
                    style: TextStyle(color: Colors.red)))
            : SizedBox(height: 0, width: 0),
        errors[3]
            ? ListTile(
                leading: Icon(Icons.error_outline, color: Colors.red),
                title: Text(tr('errorPassword'),
                    style: TextStyle(color: Colors.red)))
            : SizedBox(height: 0, width: 0),
      ]),
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      child: TextField(
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
                        onChanged: (input) {
                          setState(() {
                            fullname = input;
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Divider(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.012),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8783,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: TextField(
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
                        onChanged: (input) {
                          setState(() {
                            email = input;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Divider(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.012),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8783,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: TextField(
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
                        onChanged: (input) {
                          setState(() {
                            username = input;
                          });
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Divider(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.012),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8783,
                      height: MediaQuery.of(context).size.height * 0.065,
                      child: TextField(
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
                        onChanged: (input) {
                          setState(() {
                            password = input;
                          });
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Divider(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.012),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8783,
                      height: MediaQuery.of(context).size.height * 0.055,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        color: _checkForErrors()
                            ? Colors.blue[700]
                            : Color(0xff003480),
                        textColor:
                            _checkForErrors() ? Colors.white : Colors.grey,
                        splashColor: _checkForErrors()
                            ? Theme.of(context).splashColor
                            : Colors.red,
                        highlightColor: _checkForErrors()
                            ? Theme.of(context).splashColor
                            : Colors.red,
                        child: Text(tr('signUpButton'),
                            style: TextStyle(fontFamily: "NotoSerifSC"),
                            textScaleFactor: 1.2),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_submit()) {
                            _saveUserPreferences(
                                fullname, email, username, password);
                          }
                        },
                      ),
                    ),
                    _buildErrors(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ]),
            )),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}