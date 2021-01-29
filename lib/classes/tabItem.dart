import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final Function onTap;
  final Function onLongPress;

  const TabItem(
      {Key key, this.isSelected, this.onTap, this.iconData, this.onLongPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData,
                color: isSelected ? Colors.white : Colors.white54,
                size: MediaQuery.of(context).size.height * 0.035),
          ],
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}

class TabItemIcon extends StatelessWidget {
  final Widget icon;
  final bool isSelected;
  final Function onTap;
  final Function onLongPress;

  const TabItemIcon(
      {Key key, this.isSelected, this.onTap, this.icon, this.onLongPress})
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
      onLongPress: onLongPress,
    );
  }
}
