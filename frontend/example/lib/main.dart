import 'package:example/ui/welcome.dart';
import 'package:flutter/material.dart' hide Actions;

import 'ui/home.dart';
import 'ui/new_expense.dart';
import 'ui/login.dart';
import 'ui/signup.dart';
// import 'src/settings.dart';

void main() {
  runApp(LedgerApp());
}


class LedgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ledger',
          theme: ThemeData(
                  primarySwatch: Colors.blueGrey,
                  accentColor: Colors.blueGrey,
                ),
          routes: <String, Widget Function(BuildContext)>{
            '/':(BuildContext context)=>Welcome(),
            '/Signup':(BuildContext context)=>Signup(),
            '/Login':(BuildContext context)=>Login(),
            '/home': (BuildContext context) => Home(),
            '/home/new_expense': (BuildContext context) => NewExpenseScreen(),
            // '/settings': (BuildContext context) => Settings(),
          },
        );
  }
}
