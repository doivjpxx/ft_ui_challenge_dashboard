import 'package:flutter/material.dart';
import 'package:ft_ui_challenge_dashboard/pages/dashboard_1.dart';

import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/first': (context) => MyDashboard1(),
        // '/second': (context) => MyEcommerce2(),
        // '/third': (context) => MyEcommerce3(),
        // '/four': (context) => MyEcommerce4(),
      },
    );
  }
}
