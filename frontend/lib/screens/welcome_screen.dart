// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1, // Upper half
            child: Container(
              color: Color(0xFFCDA274), // Tan-like background color
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image:
                        AssetImage('lib/images/smart resume profiler logo.jpg'),
                    fit: BoxFit.cover, // Fill the entire space with the logo
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1, // Lower half
            child: Container(
              color: Color(0xFF3A3A3A), // Darkish grey background color
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the login screen
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFF2D2D2D), // Set background color
                          // Set text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(
                        'LOGIN IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the account creation screen
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.white, // Set background color
                          backgroundColor: Color(0xFFCDA274), // Set text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 65.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle login using social media
                          },
                          icon: Icon(
                            Icons.facebook,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        IconButton(
                          onPressed: () {
                            // Handle login using social media
                          },
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16.0),
                        IconButton(
                          onPressed: () {
                            // Handle login using social media
                          },
                          icon: Icon(
                            Icons.apple,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
