import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Function onTap;

  const TabItem({Key key, this.isSelected, this.onTap, this.iconData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData, color: isSelected ? Colors.white : Colors.white54, size: MediaQuery.of(context).size.height * 0.035),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

class TabItemIcon extends StatelessWidget {
  final Icon icon;
  final bool isSelected;
  final Function onTap;

  const TabItemIcon({Key key, this.isSelected, this.onTap, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.icon,
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
