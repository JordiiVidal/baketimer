import 'package:flutter/material.dart';

class AuthColumn extends StatelessWidget {
  final List<Widget> children;
  const AuthColumn({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
