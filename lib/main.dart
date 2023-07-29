import 'package:auctify/screens/product_list_screen.dart';
import 'package:auctify/screens/splash_screen.dart';
import 'package:auctify/screens/testing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAO3hhwDFZ9mycWYEXFmJU7rS2gF2ZUdck",
    projectId: "auctify-f4102",
    storageBucket: "auctify-f4102.appspot.com",
    messagingSenderId: "44611420220",
    appId: "1:44611420220:web:b3ec32e6546b06d0654339",
  ));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const SplashScreen();
          }
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
