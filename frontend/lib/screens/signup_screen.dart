// lib/screens/signup_screen.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatelessWidget {
  final AuthService authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signup(BuildContext context) async {
    String? token = await authService.signup(
      usernameController.text,
      passwordController.text,
    );
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed. Try a different username.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A), // Dark grey
              Color(0xFF0D0D0D), // Blackish grey
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors
                          .white54, // Border color compatible with background
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/smart resume profiler logo.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 14),

                // Title
                // Text(
                //   "CREATE ACCOUNT",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1.5,
                //   ),
                // ),
                // SizedBox(height: 9),
                Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Color(0xFFC0A480), // Muted brown color
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 30),

                // Username Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D2D), // Dark grey background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        hintText: "USER NAME",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white70,
                        )),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),

                // Password Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D2D), // Dark grey background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "PASSWORD",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white70,
                        )),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 24),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () => signup(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC0A480), // Muted brown color
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: 15),

                // Already have an account Text
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 1,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
