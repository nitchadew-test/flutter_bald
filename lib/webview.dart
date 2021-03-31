import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebview extends StatefulWidget {
  final String url;

  InAppWebview({
    @required this.url,
  });

  @override
  _InAppWebviewState createState() => new _InAppWebviewState(url);
}

class _InAppWebviewState extends State<InAppWebview> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  _InAppWebviewState(url) {
    this.url = url;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('InAppWebView Example'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
              child: InAppWebView(
                  initialUrl: url,
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      debuggingEnabled: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  androidOnPermissionRequest:
                      (InAppWebViewController controller, String origin,
                          List<String> resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  }),
            ),
          ),
        ])));
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MyWebView extends StatelessWidget {
//   final String title;
//   final String selectedUrl;

//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   MyWebView({
//     @required this.title,
//     @required this.selectedUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: WebView(
//           initialUrl: selectedUrl,
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             _controller.complete(webViewController);
//           },
//         ));
//   }
// }
