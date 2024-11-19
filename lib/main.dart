import 'package:final_exam/provider/contact_provider.dart';
import 'package:final_exam/views/home_page.dart';
import 'package:final_exam/views/search_page.dart';
import 'package:final_exam/views/signIn_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers : [
    ChangeNotifierProvider(create: (context) => ContactProvider(),)
  ],child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
