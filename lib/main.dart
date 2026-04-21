import 'package:flutter/material.dart';
import 'package:surveywebapp/screens/login_page.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:surveywebapp/screens/surveypage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
/*
Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  print("Handling a background message ${message.data}");
  //You need to do everything in here
  //If you need to do anything with firebase you also need to call
  //await Firebase.initializeApp();
}*/

/*
Future<DocumentSnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance
      .collection("users")
      .doc("docID")
      .get();
}
*/
class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SurveyWebApp',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error Snapshot");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage(); //LoginPage();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text('EXPLORE'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Discover',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Contact Us',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 50,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}

class SomethingWentWrong {}
