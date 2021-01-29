import 'package:flutter/material.dart';
import '../classes/colorPicker.dart';

class FloowerControlPage extends StatefulWidget {
  @override
  _FloowerControlPageState createState() => _FloowerControlPageState();
}

class _FloowerControlPageState extends State<FloowerControlPage> {
  int colorPickerColor = 0xffff0000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: CircleColorPicker(
              colorListener: (int value) {
                setState(() {
                  colorPickerColor = value;
                });
              },
          ),
          color: Color(colorPickerColor),
        ),
      )
    );
  }
}