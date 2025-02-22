import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import '../services/firestore.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

import '../services/payhere_service.dart';






void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    
    
  );
FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home:  SplashScreen(),
    );
  }
}

