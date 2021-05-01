import 'package:flutter/material.dart';

import 'constant.dart';

class SharedFunctions {
  static bool get isClientLogged => Constant.signInClient != null;

  static gridDelegate(int crossAxisCount) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
    );
  }
}
