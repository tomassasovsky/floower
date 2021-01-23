import 'package:easy_localization/easy_localization.dart';
import 'package:floower/authentication/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:floower/main.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  String selectedLanguage = 'English - United Kingdom';
  bool usernameError = false;
  bool passwordError = false;
  String username = "";
  String password = "";
  bool isOnSignUp = false;

  _saveUserData(String jUsername, String jPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", jUsername);
    preferences.setString("password", jPassword);
  }

  _checkForErrors() {
    var _checkPreErrors = [];
    if (!RegExp(r'^[a-zA-Z][a-zA-Z\d-_\.]+$').hasMatch(username)) {
      _checkPreErrors.add(tr('errorUsername'));
    }
    if (password.length < 8) {
      _checkPreErrors.add(tr('errorPassword'));
    }
    return _checkPreErrors.isEmpty;
  }

  _checkForErrorsSubmit() {
    setState(() {
      if (!RegExp(r'^[a-zA-Z][a-zA-Z\d-_\.]+$').hasMatch(username)) {
        usernameError = true;
      } else {
        usernameError = false;
      }
      if (password.length < 8) {
        passwordError = true;
      } else {
        passwordError = false;
      }
    });
  }

  _submit() {
    _checkForErrorsSubmit();
    if (usernameError || passwordError) return false;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  _buildErrors() {
    return GestureDetector(
      child: Column(children: [
        usernameError
            ? ListTile(
                leading: Icon(Icons.error_outline, color: Colors.red),
                title: Text(tr('errorUsername'),
                    style: TextStyle(color: Colors.red)))
            : SizedBox(height: 0, width: 0),
        passwordError
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

  _buildSignUpPage() {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: DropdownButton(
            dropdownColor: Colors.blueGrey[900],
            style: TextStyle(color: Colors.white),
            underline: Container(
              height: 0.6,
              color: Colors.white,
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
        body: SignupPage());
  }

  @override
  Widget build(_context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
          dropdownColor: Colors.blueGrey[900],
          style: TextStyle(color: Colors.white),
          underline: Container(
            height: 0.6,
            color: Colors.white,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.065,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(tr('registerAccountMessage'),
                    style: TextStyle(fontSize: 12)),
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (_) {
                          return _buildSignUpPage();
                        }));
                      });
                    },
                    child: Text(tr('registerAccountButton'),
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12)))
              ]),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        child: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('floower',
                      style: TextStyle(
                          fontFamily: "NotoSerifSC",
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 3.0)),
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
                        hintText: tr("usernameOrEmailField"),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Colors.white60,
                            fontSize: 14),
                        alignLabelWithHint: false,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
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
                        hintText: tr("passwordField"),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Colors.white60,
                            fontSize: 14),
                        alignLabelWithHint: false,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[800], width: 0),
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
                      textColor: _checkForErrors() ? Colors.white : Colors.grey,
                      splashColor: _checkForErrors()
                          ? Theme.of(context).splashColor
                          : Colors.red,
                      highlightColor: _checkForErrors()
                          ? Theme.of(context).splashColor
                          : Colors.red,
                      child: Text(tr("signInButton"),
                          style: TextStyle(fontFamily: "NotoSerifSC"),
                          textScaleFactor: 1.2),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_submit()) {
                          _saveUserData(username, password);
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
                  _buildErrors(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tr("recoverAccountMessage"),
                          style: TextStyle(fontSize: 12)),
                      TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                          ),
                          onPressed: () {},
                          child: Text(tr('recoverAccountButton'),
                              style: TextStyle(fontSize: 12)))
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005)
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}