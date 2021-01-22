import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function onTap;

  const TabItem({Key key, this.icon, this.isSelected, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var selectedSize = MediaQuery.of(context).size.height * 0.04;
    // var unselectedSize = MediaQuery.of(context).size.height * 0.03;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: isSelected ? Colors.white : Colors.white54),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}