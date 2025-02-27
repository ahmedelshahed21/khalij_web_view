import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KhalijWebView extends StatefulWidget {
  const KhalijWebView({super.key});

  @override
  State<KhalijWebView> createState() => _KhalijWebViewState();
}

class _KhalijWebViewState extends State<KhalijWebView> {
  bool _isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) async {
            if (!request.url.contains("khelj.com")) {
              await launchUrl(Uri.parse(request.url),
                  mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://www.khelj.com"));
  }

  Future<bool> _handleWillPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,result) async {
        if (!didPop) {
          bool canExit = await _handleWillPop();
          if (canExit) {
            if(!context.mounted)return;
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading)
                Container(
                  color: Colors.white,
                  child:  Center(
                      child:  SvgPicture.asset('assets/images/Khelj-new.svg')),
                ),
            ],
          ),
        ),
      ),
    );
  }
}