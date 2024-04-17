import 'package:docd/app_widget.dart';
import 'package:docd/providers/document_provider.dart';
import 'package:docd/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DocumentProvider(),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
