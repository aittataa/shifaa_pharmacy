import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ActionButton extends StatelessWidget {
  final bool isLiked;
  final bool absorbing;
  final Function onTap;
  final Function iconBuilder;
  final double size;
  ActionButton({
    this.isLiked,
    this.absorbing = false,
    this.onTap,
    this.iconBuilder,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: LikeButton(
        likeCountPadding: EdgeInsets.zero,
        onTap: onTap,
        isLiked: isLiked,
        size: size,
        bubblesSize: 0,
        circleSize: 0,
        animationDuration: Duration(milliseconds: 1000),
        likeBuilder: iconBuilder,
      ),
    );
  }
}
