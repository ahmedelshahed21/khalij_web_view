import 'package:flutter/material.dart';
import 'package:khelj/views/khelj_web_view.dart';

class KheljApp extends StatelessWidget {
  const KheljApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KheljWebView(),
    );
  }
}