import 'package:flutter/material.dart';

import 'back_space_button.dart';

class BackspaceKey extends StatelessWidget {
  final bool isPlainText;
  const BackspaceKey({
    Key? key,
    this.isPlainText = false,
    required this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback onBackspace;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onBackspace.call();
      },
      child: backSpaceButton(context, isPlainText: isPlainText),
    );
  }
}

class BiometricKey extends StatelessWidget {
  final bool isPlainText;
  const BiometricKey({
    Key? key,
    this.isPlainText = false,
    required this.biometricClicked,
    this.flex = 1,
  }) : super(key: key);

  final VoidCallback biometricClicked;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        biometricClicked.call();
      },
      child: emptyButton(isPlainText: isPlainText),
    );
  }
}
