import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shifaa_pharmacy/widget/spin_indicator.dart';

class ModalProgressIndicator extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Widget child;
  ModalProgressIndicator({this.inAsyncCall, this.opacity = 0.75, this.child});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: inAsyncCall,
      opacity: opacity,
      progressIndicator: SpinIndicator(),
      child: child,
    );
  }
}
