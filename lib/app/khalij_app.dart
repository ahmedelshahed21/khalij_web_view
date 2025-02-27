import 'package:flutter/material.dart';
import 'package:khalij/views/khalij_web_view.dart';


class KhalijApp extends StatelessWidget {
  const KhalijApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KhalijWebView(),
    );
  }
}