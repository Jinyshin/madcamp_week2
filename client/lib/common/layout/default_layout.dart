import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final AppBar? appbar;
  final Widget child;
  final Widget? bottomsheet;

  const DefaultLayout({
    this.appbar,
    required this.child,
    this.bottomsheet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: child,
      bottomSheet: bottomsheet,
      resizeToAvoidBottomInset: true,
    );
  }
}
