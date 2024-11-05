// lib/main.dart

import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Check the route name and handle routes with arguments
        if (settings.name == '/home') {
          // Cast the arguments as a String to pass the username
          final String userName = settings.arguments as String;

          // Return a MaterialPageRoute to navigate to HomeScreen with the username
          return MaterialPageRoute(
            builder: (context) => HomeScreen(userName: userName),
          );
        }

        // Define other routes without arguments here
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => WelcomeScreen());
          case '/signup':
            return MaterialPageRoute(builder: (_) => SignupScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          default:
            return null; // Return null if no route is matched
        }
      },
    );
  }
}
