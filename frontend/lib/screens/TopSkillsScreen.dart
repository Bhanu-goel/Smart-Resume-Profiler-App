import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopSkillsScreen extends StatelessWidget {
  // Fetch top skills from the backend
  Future<List<String>> _fetchTopSkills() async {
    final response = await http.get(
      Uri.parse(
          'https://f955-103-212-146-45.ngrok-free.app/auth/getTopSkills'), // Replace with your backend URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> topSkills = List<String>.from(data['top_skills']);
      await Future.delayed(Duration(seconds: 2));
      return topSkills;
    } else {
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
          'Top Skills',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      backgroundColor: Color(0xFF0D1F2D),
      body: FutureBuilder<List<String>>(
        future: _fetchTopSkills(),
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
