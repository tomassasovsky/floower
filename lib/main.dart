import 'package:floower/splashScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:floower/pages/authentication/signin.dart';
import 'package:floower/pages/floowerControlPage.dart';
import 'package:floower/pages/profilePage.dart';
import 'classes/tabItem.dart';

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
  print(preferences.getString("name"));
  return preferences.setString("name", name);
}

Future<String> getNamePreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString("name"));
  return preferences.getString("name");
}

Future setLanguagePreference(var language) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString("language"));
  return preferences.setString("language", language);
}

Future<Locale> getLanguagePreference() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print(preferences.getString("language"));
  if (preferences.getString("language") == null) {
    preferences.setString("language", "Locale(\'en\')");
    preferences = await SharedPreferences.getInstance();
  }
  return localeFromString(preferences.getString("language"));
}

Future isUserLoggedIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getBool("isLoggedIn") == null) {
    preferences.setBool("isLoggedIn", false);
  }
  return preferences.getBool("isLoggedIn");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale startLanguage = await getLanguagePreference();
  setSelectedPosition(1000);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
  runApp(
    EasyLocalization(
      path: 'assets',
      supportedLocales: [Locale('en'), Locale('es'), Locale('ru')],
      fallbackLocale: startLanguage,
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
          textTheme: TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
            headline2: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),
            headline3: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
          ),
          buttonColor: Colors.blue[100],
          hintColor: Colors.black54,
          textSelectionTheme:
              TextSelectionThemeData(selectionColor: Colors.grey[120]),
          cardColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          primaryColor: Colors.white,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          accentColor: Colors.black,
        ),
        darkTheme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
            headline2: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 25, color: Colors.white),
            headline3: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
          ),
          buttonColor: Color(0xff13305e),
          cardColor: Color(0xff201f25),
          highlightColor: Colors.white54,
          iconTheme: IconThemeData(color: Colors.white),
          accentColor: Colors.white,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xff020202),
          primaryColor: Color(0xff020202),
          canvasColor: Colors.transparent,
        ),
        home: ScreenPicker(title: 'Floower'),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ]);
  }
}

class ScreenPicker extends StatefulWidget {
  ScreenPicker({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ScreenPickerState createState() => _ScreenPickerState();
}

class _ScreenPickerState extends State<ScreenPicker> {
  final StreamController isAppBarVisible = StreamController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedPosition.close();
    isAppBarVisible.close();
    super.dispose();
  }

  Future _setSelectedPosition(int pos) async {
    selectedPosition.sink.add(pos);
    setState(() {
      _selectedPosition = pos;
    });
  }

  _currentScreen() {
    return StreamBuilder(
        stream: selectedPosition.stream,
        initialData: 1000,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data != '') {
            _selectedPosition = snapshot.data;
            switch (snapshot.data) {
              case 1000:
                isAppBarVisible.sink.add(false);
                return SplashScreen();
              case 100:
                isAppBarVisible.sink.add(false);
                return SigninPage();
              case 0:
                isAppBarVisible.sink.add(true);
                return FloowerControlPage();
              case 1:
                isAppBarVisible.sink.add(true);
                return SigninPage();
              case 2:
                return null;
              case 3:
                isAppBarVisible.sink.add(true);
                return ProfilePage();
            }
          }
          return Center(
              child: Container(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: CircularProgressIndicator.adaptive()));
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                tr('choosePhoto'),
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ]),
      ),
    );
  }

  _buildBottomTab() {
    return StreamBuilder(
        stream: isAppBarVisible.stream,
        initialData: 1000,
        builder: (context, snapshot) {
          if (snapshot.data != 0 &&
              _selectedPosition != 100 &&
              _selectedPosition != 1000) {
            return BottomAppBar(
              color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TabItemIcon(
                    icon: Icon(Icons.palette,
                        color: _selectedPosition == 0
                            ? Colors.white
                            : Colors.white54,
                        size: MediaQuery.of(context).size.height * 0.035),
                    isSelected: _selectedPosition == 0,
                    onTap: () async {
                      setState(() {
                        _setSelectedPosition(0);
                      });
                    },
                  ),
                  TabItemIcon(
                    icon: FaIcon(FontAwesomeIcons.userFriends,
                        color: _selectedPosition == 1
                            ? Colors.white
                            : Colors.white54),
                    isSelected: _selectedPosition == 1,
                    onTap: () {
                      setState(() {
                        _setSelectedPosition(1);
                      });
                    },
                  ),
                  TabItem(
                    iconData: IconData(0xe900, fontFamily: 'flower'),
                    isSelected: _selectedPosition == 2,
                    onTap: () {
                      setState(() {
                        _setSelectedPosition(2);
                      });
                    },
                  ),
                  TabItemIcon(
                    icon: FaIcon(FontAwesomeIcons.solidUserCircle,
                        color: _selectedPosition == 3
                            ? Colors.white
                            : Colors.white54),
                    isSelected: _selectedPosition == 3,
                    onTap: () {
                      setState(() {
                        _setSelectedPosition(3);
                      });
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        });
  }

  _appBar() {
    if (_selectedPosition == 3) {
      return AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                dropdownColor: Theme.of(context).cardColor,
                underline: SizedBox(),
                icon: Icon(
                  Icons.public_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () => setState(() {}),
                onChanged: (language) => setState(() {
                      context.locale = language;
                      setLanguagePreference(language.toString());
                    }),
                items: [
                  DropdownMenuItem(
                      value: Locale('en'),
                      child: Text(languages[0],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .color))),
                  DropdownMenuItem(
                      value: Locale('es'),
                      child: Text(languages[1],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .color))),
                  DropdownMenuItem(
                      value: Locale('ru'),
                      child: Text(languages[2],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .color))),
                ]),
          ),
        ],
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
    );
  }
}
