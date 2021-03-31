import 'package:basic_ui/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'webview.dart';

class Home extends StatelessWidget {
  Home({key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  TextEditingController myController = new TextEditingController();
  String webSmartAccessPath =
      'https://onesmartaccess-vue.herokuapp.com/?onechat_token=';

  cheackPermission() async {
    var cameraStatus = await Permission.camera.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    print(cameraStatus);
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

  Widget _buildList(String name, String des) => ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _tile('Name', name, Icons.web_asset),
          _tile('Description', des, Icons.description_outlined),
          // _tile('E-mail', mail, Icons.mail),
        ],
      );

  Widget _card(String cardPicture, String cardTitle, String address,
          String phone, BuildContext context) =>
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
                              child: _buildList(address, phone),
                              height: MediaQuery.of(context).size.height * 0.16,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: myController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your Token'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton.icon(
                            label: Text('Click Me',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6))),
                            icon: Icon(Icons.web),
                            onPressed: () {
                              webSmartAccessPath =
                                  webSmartAccessPath + myController.text;
                              // print(webSmartAccessPath);
                              cheackPermission();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      InAppWebview(
                                        url: webSmartAccessPath,
                                      )));
                            },
                          )
                        ],
                      )
                    ],
                  ))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('AppBar Demo'),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index.isEven) {
                    return Container(
                        padding: EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: _card(
                            'images/dog.png',
                            'Dog',
                            'https://onesmartaccess-vue.herokuapp.com',
                            'Web Application for booking a Meeting Room',
                            context));
                  } else {
                    return Container(
                        padding: EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width * 1.0,
                        child: _card(
                            'images/bald.jpg',
                            'Bald',
                            '8/12 Long Roed, Los Angeles, California',
                            '098765432',
                            context));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
