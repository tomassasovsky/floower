import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:floower/authentication/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'authentication/signup.dart';
import 'tabItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

var languages = [
  'English - United Kingdom',
  'Español - América Latina',
  'Pусский'
];

final StreamController<int> selectedPosition = StreamController<int>();
int _selectedPosition;
String ipaddress = "192.168.1.90";
String espUrl = "http://8.8.8.8/config?ssid=";
String espUrl1 = "&pass=";

final tabs = ['color', 'devices', 'group', 'profile'];

Future setSelectedPosition(int pos) async {
  selectedPosition.sink.add(pos);
  _selectedPosition = pos;
}

Future<bool> saveNamePreference(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setString("name", name);
}

Future<String> getNamePreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("name");
}

Future setLanguagePreference(var language) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setString("language", language);
}

Future getLanguagePreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("language") == null)
    preferences.setString("language", 'Locale(\'en\')');
  return preferences.getString("language");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var startLanguage = await getLanguagePreference();
  setSelectedPosition(100);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
  runApp(
    EasyLocalization(
      path: 'assets',
      supportedLocales: [Locale('en'), Locale('es'), Locale('ru')],
      startLocale: localeFromString(startLanguage),
      child: MyApp(),
      assetLoader: RootBundleAssetLoader(),
      saveLocale: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Color(0xff020202),
        canvasColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        accentColor: Colors.transparent,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff020202),
        primaryColor: Color(0xff020202),
        canvasColor: Colors.transparent,
      ),
      home: ScreenPicker(title: 'Floower'),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

class ScreenPicker extends StatefulWidget {
  ScreenPicker({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenPickerState createState() => _ScreenPickerState();
}

class _ScreenPickerState extends State<ScreenPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedPosition.close();
    super.dispose();
  }

  _currentScreen() {
    return StreamBuilder(
        stream: selectedPosition.stream,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data != '') {
            _selectedPosition = snapshot.data;
            switch (snapshot.data) {
              case 100:
                return SigninPage();
                break;
              case 6:
                return SignupPage();
            }
          }
          return Center(
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: CircularProgressIndicator.adaptive()));
        });
  }

  // ignore: unused_element
  _fab() {
    if (_selectedPosition != 1 && _selectedPosition != 0)
      return FloatingActionButton(
        isExtended: true,
        backgroundColor: Color(0xFF32edaf),
        child: Icon(
          Icons.add,
          color: _selectedPosition == 4 ? Colors.white : Colors.black54,
        ),
        onPressed: () async {
          setState(() {
            setSelectedPosition(4);
          });
        },
        elevation: 0,
        highlightElevation: 0,
      );
  }

  _buildBottomTab() {
    if (_selectedPosition != 100)
      return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        child: BottomAppBar(
          color: Color(0xff04c2a9),
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TabItem(
                icon: IconData(0xe900, fontFamily: 'flower'),
                isSelected: _selectedPosition == 0,
                onTap: () async {
                  setState(() {
                    setSelectedPosition(0);
                  });
                },
              ),
              TabItem(
                icon: IconData(0xe900, fontFamily: 'flower'),
                isSelected: _selectedPosition == 1,
                onTap: () {
                  setState(() {
                    print('height: ' +
                        MediaQuery.of(context).size.height.toString());
                    print('width: ' +
                        MediaQuery.of(context).size.width.toString());
                    setSelectedPosition(1);
                  });
                },
              ),
              SizedBox(
                width: 48,
              ),
              TabItem(
                icon: IconData(0xe900, fontFamily: 'flower'),
                isSelected: _selectedPosition == 2,
                onTap: () {
                  setState(() {
                    setSelectedPosition(2);
                  });
                },
              ),
              TabItem(
                icon: Icons.person,
                isSelected: _selectedPosition == 3,
                onTap: () {
                  setState(() {
                    setSelectedPosition(3);
                  });
                },
              ),
            ],
          ),
        ),
      );
  }

  _appBar() {
    if (_selectedPosition == 3) {
      return AppBar(
        title: Text(widget.title),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _buildBottomTab(),
      body: _currentScreen(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: _fab()
    );
  }
}