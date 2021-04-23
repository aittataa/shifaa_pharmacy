import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuButtonBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          onPressed: () => {Scaffold.of(context).openDrawer()},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            CupertinoIcons.list_bullet_indent,
            //CupertinoIcons.text_justify,
            //CupertinoIcons.text_alignright,
            //CupertinoIcons.list_dash,
            //CupertinoIcons.line_horizontal_3,
            //CupertinoIcons.increase_indent,
            //CupertinoIcons.decrease_indent,
            //CupertinoIcons.bars,
            size: 30,
          ),
        );
      },
    );
  }
}
