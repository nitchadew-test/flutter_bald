import 'package:basic_ui/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'webview.dart';
import 'webviewWithData.dart';

class Home extends StatefulWidget {
  Home({key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Home> {
  TextEditingController myController = new TextEditingController();
  String webSmartAccessPath = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bald',
      home: Scaffold(
        backgroundColor: Colors.grey[50],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.greenAccent[400],
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Bald Red Chat'),
          backgroundColor: Colors.greenAccent[400],
          elevation: 5.00,
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return QRViewExample();
                    }));
                  },
                  child: Icon(Icons.navigate_next),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.90,
                  child: _buildcard(context)),
            ],
          ),
        ),
      ),
    );
  }

  cheackPermission(Map permissionReq) async {
    if (permissionReq['camera']) {
      var cameraStatus = await Permission.camera.status;
      print('cameraStatus');
      print(cameraStatus);
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
    }

    if (permissionReq['ble']) {
      var bluetoothStatus = await Permission.bluetooth.status;
      print('bluetoothStatus');
      print(bluetoothStatus);
      if (!bluetoothStatus.isGranted) {
        await Permission.bluetooth.request();
      }
    }
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.lime[500],
          size: 30,
        ),
      );

  Widget _buildList(String webName, String description) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _tile('Name', webName, Icons.web_asset),
          _tile('Description', description, Icons.description_outlined),
          // _tile('E-mail', mail, Icons.mail),
        ],
      );

  Widget _card(
          String cardPicture,
          String cardTitle,
          String webName,
          String webUrl,
          String description,
          bool tokenReq,
          bool webViewWithData,
          Map permissionReq,
          BuildContext context) =>
      Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
          child: Padding(
              padding: EdgeInsets.all(25),
              child: new Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(cardTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Image.asset(
                        cardPicture,
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.lime,
                        height: 45,
                        thickness: 5,
                        indent: 60,
                        endIndent: 60,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: _buildList(webName, description),
                              height: MediaQuery.of(context).size.height * 0.17,
                            ),
                          ),
                        ],
                      ),
                      if (tokenReq) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TextField(
                            controller: myController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Onechat Token'),
                          ),
                        ),
                      ],
                      if (webViewWithData) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              label: Text('Open Webview',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                              icon: Icon(Icons.web),
                              onPressed: () {
                                webSmartAccessPath = webUrl;
                                webSmartAccessPath =
                                    webSmartAccessPath + myController.text;
                                print(webSmartAccessPath);
                                cheackPermission(permissionReq);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        InAppWebviewWithData(
                                            url: webSmartAccessPath,
                                            webName: webName)));
                              },
                            )
                          ],
                        )
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              label: Text('Open Webview',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6))),
                              icon: Icon(Icons.web),
                              onPressed: () {
                                webSmartAccessPath = webUrl;
                                webSmartAccessPath =
                                    webSmartAccessPath + myController.text;
                                print(webSmartAccessPath);
                                cheackPermission(permissionReq);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        InAppWebview(
                                            url: webSmartAccessPath,
                                            webName: webName)));
                              },
                            )
                          ],
                        )
                      ],
                    ],
                  ))));

  Widget _buildcard(BuildContext context) => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width * 1.0,
              child: _card(
                  'images/dog.png',
                  'One Smart Access',
                  'www.onesmartaccess-vue.herokuapp.com',
                  'https://onesmartaccess-vue.herokuapp.com/?onechat_token=',
                  'Web Application for booking a Meeting Room',
                  true,
                  false,
                  {'camera': true, 'ble': false},
                  context)),
          Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width * 1.0,
              child: _card(
                  'images/bald.jpg',
                  'test',
                  'https://4e83f6d4756c.ngrok.io',
                  'https://4e83f6d4756c.ngrok.io',
                  'test webview to call flutter fuction',
                  false,
                  true,
                  {'camera': false, 'ble': true},
                  context)),
          Container(
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width * 1.0,
              child: _card(
                  'images/bald.jpg',
                  'Medbald',
                  'https://afternoon-citadel-44754.herokuapp.com',
                  'https://afternoon-citadel-44754.herokuapp.com/#/?onechat_token=',
                  'Web Application for Unlocking Medical Box',
                  true,
                  false,
                  {'camera': false, 'ble': true},
                  context)),
        ],
      );
}
