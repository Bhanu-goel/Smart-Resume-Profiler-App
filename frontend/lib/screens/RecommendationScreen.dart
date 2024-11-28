import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendationScreen extends StatelessWidget {
  final String domain;

  // Constructor to accept the domain
  RecommendationScreen({required this.domain});

  // Fetch recommendations from the backend using the GET method
  Future<Map<String, dynamic>> _fetchRecommendations() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:5000/auth/getRecommendations?domain=$domain'), // Send domain in the query
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Ensure the data structure matches expectations
        if (data['recommendations'] != null &&
            data['recommendations'].isNotEmpty) {
          return data['recommendations']
              [0]; // Extract the first recommendation object
        } else {
          throw Exception('Recommendations data is missing');
        }
      } else {
        throw Exception('Failed to load recommendations');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load recommendations');
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
          'Recommendations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      backgroundColor: Color(0xFF0D1F2D),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchRecommendations(),
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
                    'Loading recommendations...',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;

            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildSection(
                  'Domain Assessment',
                  data['domain_assessment'],
                ),
                SizedBox(height: 16),
                _buildSection(
                  'Skill Recommendations',
                  data['skill_recommendations'],
                ),
                SizedBox(height: 16),
                _buildSection(
                  'Improvement Areas',
                  data['improvement_areas'],
                ),
              ],
            );
          }

          return Center(
            child: Text(
              'Error fetching recommendations',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  // Helper method to build each section
  Widget _buildSection(String title, List<dynamic>? content) {
    if (content == null || content.isEmpty) {
      return SizedBox
          .shrink(); // Return nothing if the content is null or empty
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        for (var item in content)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '• $item',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
