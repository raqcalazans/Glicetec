import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class GlicetecAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GlicetecAppBar({key, required this.title}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(58);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
    );
  }
}
