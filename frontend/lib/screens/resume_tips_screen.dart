import 'package:flutter/material.dart';

class ResumeTipsScreen extends StatelessWidget {
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
          'Resume Tips',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '1. Tailor Your Resume to the Job Description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Ensure that your resume highlights skills and experience that align with the job requirements.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '2. Use Action Verbs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Action verbs like "achieved", "designed", and "managed" make your resume stand out.',
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
