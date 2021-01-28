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
    if (username.length < 1) {
      _checkPreErrors.add(tr('errorUsername'));
    }
    if (password.length < 1) {
      _checkPreErrors.add(tr('errorPassword'));
    }
    return _checkPreErrors.isEmpty;
  }

  _submit() {
    if (usernameError || passwordError) return false;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(_context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
          onTap: () {
            setState(() {});
          },
          dropdownColor: Theme.of(context).cardColor,
          style: TextStyle(color: Theme.of(context).textTheme.headline1.color),
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
                          return SignupPage();
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
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('floower',
                      style: TextStyle(
                          fontFamily: "NotoSerifSC",
                          fontSize: 40.0,
                          color: Theme.of(context).textTheme.headline1.color,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 3.0)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8783,
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: TextField(
                      cursorColor: Theme.of(context).accentColor,
                      cursorWidth: 0.5,
                      decoration: InputDecoration(
                        fillColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        filled: true,
                        hintText: tr("usernameOrEmailField"),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).hintColor,
                            fontSize: 14),
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
                        fillColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        filled: true,
                        hintText: tr("passwordField"),
                        hintStyle: TextStyle(
                            backgroundColor: Colors.transparent,
                            color: Theme.of(context).hintColor,
                            fontSize: 14),
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
                      child: Text(tr("signInButton"),
                          style: TextStyle(fontFamily: "NotoSerifSC"),
                          textScaleFactor: 1.2),
                      elevation: 0,
                      highlightElevation: 0,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_submit()) {
                          _saveUserData(username, password);
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
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
