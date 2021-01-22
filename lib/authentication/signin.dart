import 'package:easy_localization/easy_localization.dart';
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
  String username = "";
  String password = "";

  _saveUserData(String jUsername, String jPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", jUsername);
    preferences.setString("password", jPassword);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
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
              Expanded(child: Text("")),
              Text('floower',
                  style: TextStyle(
                      fontFamily: "NotoSerifSC",
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 3.0)),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                width: MediaQuery.of(context).size.width * 0.8783,
                height: MediaQuery.of(context).size.height * 0.065,
                child: TextFormField(
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
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
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
              Divider(color: Colors.transparent, height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.8783,
                height: MediaQuery.of(context).size.height * 0.065,
                child: TextFormField(
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
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[800], width: 0),
                    ),
                  ),
                  onChanged: (input) {
                    setState(() {
                      password = input;
                    });
                  },
                  keyboardType: TextInputType.text,
                ),
              ),
              Divider(color: Colors.transparent, height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.8783,
                height: MediaQuery.of(context).size.height * 0.055,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _buttonIsEnabled()
                        ? Colors.blue[700]
                        : Color(0xff003480),
                    onPrimary: _buttonIsEnabled() ? Colors.white : Colors.grey,
                  ),
                  child: Text(tr("signInButton"),
                      style: TextStyle(fontFamily: "NotoSerifSC"),
                      textScaleFactor: 1.2),
                  onPressed: () {
                    if (_buttonIsEnabled()) {
                      if (_submit()) {
                        _saveUserData(username, password);
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    }
                  },
                ),
              ),
              Divider(color: Colors.transparent, height: 10),
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
              Expanded(child: SizedBox(height: 0)),
              Divider(
                thickness: 1,
                color: Colors.white24,
                indent: MediaQuery.of(context).size.width * 0.05,
                endIndent: MediaQuery.of(context).size.width * 0.05,
                height: 0,
              ),
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
                        setSelectedPosition(6);
                      });
                    },
                    child: Text(tr('registerAccountButton'),
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12)))
              ]),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005)
            ],
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  _buttonIsEnabled() {
    if (password.length > 0 && username.length > 0) {
      return true;
    }
    return false;
  }

  _submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
    }
  }
}
