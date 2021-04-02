import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flashlight/flashlight.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class InAppWebviewWithData extends StatefulWidget {
  final String _url;
  final String _webName;

  InAppWebviewWithData({String url, String webName})
      : _url = url,
        _webName = webName;

  @override
  _InAppWebviewState createState() => new _InAppWebviewState(_url, _webName);
}

class _InAppWebviewState extends State<InAppWebviewWithData> {
  InAppWebViewController webView;
  bool isturnon = false;
  String url = "";
  List<String> deviceList = [];
  String webName = "";
  double progress = 0;

  _InAppWebviewState(url, webName) {
    this.url = url;
    this.webName = webName;
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
          title: Text(webName),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            child: Column(children: <Widget>[
          Expanded(
            child: Container(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  // initialFile: url,
                  // initialHeaders: {},
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      mediaPlaybackRequiresUserGesture: false,
                      // debuggingEnabled: true,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                    controller.addJavaScriptHandler(
                        handlerName: "flashToggle",
                        callback: (args) {
                          print(isturnon);
                          print(args);
                          if (isturnon) {
                            Flashlight.lightOff();
                            isturnon = false;
                            print('Flashlight is Off');
                            return 'Flashlight is Off';
                          } else {
                            Flashlight.lightOn();
                            isturnon = true;
                            print('Flashlight is On');
                            return 'Flashlight is On';
                          }
                          // print("From the JavaScript side:");
                          // print(args);
                          // return args.reduce((curr, next) => curr + next);
                        });
                    controller.addJavaScriptHandler(
                        handlerName: "scanBle",
                        callback: (args) async {
                          deviceList = [];
                          print(deviceList);
                          FlutterBlue flutterBlue = FlutterBlue.instance;
                          await flutterBlue.startScan(
                              timeout: Duration(seconds: 4));
                          var subscription =
                              flutterBlue.scanResults.listen((results) {
                            for (ScanResult r in results) {
                              deviceList.add(
                                  'id:${r.device.id} , name: ${r.device.name}, rssi: ${r.rssi}');
                              // print('${r.device.name} found! rssi: ${r.rssi}');
                              print(r.device);
                            }
                          });
                          await flutterBlue.stopScan();
                          return deviceList;
                        });
                  },
                  onConsoleMessage: (InAppWebViewController controller,
                      ConsoleMessage consoleMessage) {
                    print("console message: ${consoleMessage.message}");
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
