import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/layout/home_layout/home_layout.dart';
import 'package:todo_app/shared/network/bloc_observe.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
       appBarTheme: AppBarTheme(
         backwardsCompatibility: false,
         systemOverlayStyle: SystemUiOverlayStyle(
             statusBarColor: Colors.indigo,
             statusBarIconBrightness: Brightness.light
         ),
       ),
      primarySwatch:Colors.indigo,
      ),
      home:HomeLayout(),
    );
  }
}

