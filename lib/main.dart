import 'package:flutter/material.dart';
import 'package:online_store_mvvm/provider/providers.dart';
import 'package:online_store_mvvm/screens/main_screen.dart';
import 'dart:async';

import 'package:online_store_mvvm/utils/pref_utils.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.initInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        home: MainScreen(),
      ),
    );


  }
}
