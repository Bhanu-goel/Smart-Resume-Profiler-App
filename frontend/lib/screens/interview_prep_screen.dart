import 'package:flutter/material.dart';

class InterviewPrepScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1F2D),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent.withOpacity(0.1), Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Interview Preparation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '1. Research the Company',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Familiarize yourself with the company’s culture, products, and values.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '2. Practice Common Interview Questions',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Prepare for typical questions such as "Tell me about yourself" or "What is your greatest strength?".',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            // Add more tips as needed
          ],
        ),
      ),
    );
  }
}
