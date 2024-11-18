import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecommendationScreen extends StatelessWidget {
  Future<List<String>> _fetchRecommendations() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:5000/auth/getRecommendations'), // Replace with your backend URL
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<String> recommendations =
            List<String>.from(data['recommendations']);
        await Future.delayed(Duration(seconds: 2));
        return recommendations;
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
      body: FutureBuilder<List<String>>(
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
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recommendation = snapshot.data![index];
                return Card(
                  color: Colors.greenAccent.withOpacity(0.1),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 28,
                    ),
                    title: Text(
                      recommendation,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
              'Error fetching recommendations',
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
