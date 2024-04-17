import 'package:docd/screens/document_view/document_view_screen.dart';
import 'package:docd/screens/home/home_page.dart';
import 'package:docd/screens/login/login_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doc D",
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomePage(),
        "/document": (context) => const DocumentViewScreen(),
      },
    );
  }
}
