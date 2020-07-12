import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './providers/covid_provider.dart';
import './home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //PROVIDER DIGUNAKAN UNTUK MANAJEMEN STATE
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CovidProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        title: 'Corona Track',
      ),
    );
  }
}