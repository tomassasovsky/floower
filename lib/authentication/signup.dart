import 'package:easy_localization/easy_localization.dart';
import 'package:floower/main.dart';
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
    preferences.setBool("isLoggedIn", true);
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: DropdownButton(
            dropdownColor: Theme.of(context).cardColor,
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            underline: Container(
              height: 0.6,
              color: Theme.of(context).textTheme.headline1.color,
            ),
            items: [
              DropdownMenuItem(value: Locale('en'), child: Text(languages[0])),
              DropdownMenuItem(value: Locale('es'), child: Text(languages[1])),
              DropdownMenuItem(value: Locale('ru'), child: Text(languages[2])),
            ],
            onChanged: (v) => setState(() {
              context.locale = v;
              setLanguagePreference(v.toString());
            }),
            value: context.locale,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GestureDetector(
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
                                color:
                                    Theme.of(context).textTheme.headline1.color,
                                fontWeight: FontWeight.w100)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8783,
                          height: MediaQuery.of(context).size.height * 0.065,
                          child: TextField(
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 0.5,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              filled: true,
                              hintText: tr('fullnameField'),
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Theme.of(context).hintColor,
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
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 0.5,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              filled: true,
                              hintText: tr('emailField'),
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Theme.of(context).hintColor,
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
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 0.5,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              filled: true,
                              hintText: tr('usernameField'),
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Theme.of(context).hintColor,
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
                            cursorColor: Theme.of(context).accentColor,
                            cursorWidth: 0.5,
                            decoration: InputDecoration(
                              fillColor: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              filled: true,
                              hintText: tr('passwordField'),
                              hintStyle: TextStyle(
                                  backgroundColor: Colors.transparent,
                                  color: Theme.of(context).hintColor,
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
                                : Theme.of(context).buttonColor,
                            textColor: _checkForErrors()
                                ? Colors.white
                                : Theme.of(context).hintColor,
                            splashColor: _checkForErrors()
                                ? Theme.of(context).splashColor
                                : Colors.transparent,
                            highlightColor: _checkForErrors()
                                ? Theme.of(context).splashColor
                                : Colors.transparent,
                            child: Text(tr('signUpButton'),
                                style: TextStyle(fontFamily: "NotoSerifSC"),
                                textScaleFactor: 1.2),
                            elevation: 0,
                            highlightElevation: 0,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_submit()) {
                                _saveUserPreferences(
                                    fullname, email, username, password);
                                setSelectedPosition(0);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                        _buildErrors(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ]),
                )),
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ));
  }
}