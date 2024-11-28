import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopSkillsScreen extends StatelessWidget {
  final String domain; // Domain passed from the previous screen

  TopSkillsScreen({required this.domain});

  // Fetch top skills from the backend using the domain
  Future<List<String>> _fetchTopSkills(String domain) async {
    // Construct the URL with the domain as a query parameter
    final uri = Uri.parse('http://127.0.0.1:5000/auth/getTopSkills')
        .replace(queryParameters: {'domain': domain});

    // Send the GET request
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse the response body
      final data = jsonDecode(response.body);
      List<String> topSkills = List<String>.from(data['top_skills']);
      await Future.delayed(
          Duration(seconds: 2)); // Optional: add delay for better UX
      return topSkills;
    } else {
      // Handle errors
      throw Exception('Failed to load top skills');
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
          'Top Skills for $domain', // Display the domain in the title
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      backgroundColor: Color(0xFF0D1F2D),
      body: FutureBuilder<List<String>>(
        future: _fetchTopSkills(domain),
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
                    'Loading top skills...',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              itemBuilder: (context, index) {
                final skill = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  color: Colors.greenAccent.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.greenAccent,
                      size: 28,
                    ),
                    title: Text(
                      skill,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text(
              'Error fetching top skills',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
