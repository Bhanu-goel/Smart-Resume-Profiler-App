import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ATSScreen extends StatelessWidget {
  // Fetch ATS Score from the backend API
  Future<String> _fetchATSScore() async {
    // Replace with your backend URL
    final String apiUrl = 'http://127.0.0.1:5000/auth/getATSScore';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the ATS score
        var data = json.decode(response.body);
        await Future.delayed(Duration(seconds: 2));
        String atsScore = data['ats_score'] ?? 'Error fetching ATS score';
        return atsScore;
      } else {
        // Handle error if the server response isn't successful
        return 'Failed to load ATS Score';
      }
    } catch (e) {
      // Catch any exceptions and display an error message
      return 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'ATS Score',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      backgroundColor: Color(0xFF0D1F2D),
      body: FutureBuilder<String>(
        future: _fetchATSScore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.greenAccent,
                    strokeWidth: 4,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Fetching your ATS Score...',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.tealAccent, Colors.greenAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ATS Score',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      snapshot.data!,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'Error fetching ATS Score',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
