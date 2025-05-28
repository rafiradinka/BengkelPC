import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'main_home_page.dart';

String currentUsername = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role');
  runApp(MyApp(userRole: role));
}


class MyApp extends StatelessWidget {
  final String? userRole;
  const MyApp({super.key, this.userRole});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          userRole == null
              ? LoginPage()
              : MainHomePage(role: userRole!), // dari file main_home_page.dart
    );
  }
}
