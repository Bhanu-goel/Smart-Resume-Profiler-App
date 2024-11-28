import 'package:flutter/material.dart';
import 'package:frontend/screens/TopSkillsScreen.dart';
import 'ATSScreen.dart';
import 'RecommendationScreen.dart';

class ResultScreen extends StatelessWidget {
  final String domain; // Add a domain property

  ResultScreen({required this.domain});

  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
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
          'Resume Analysis Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      backgroundColor: Color(0xFF0D1F2D),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(
              context: context,
              text: 'Check ATS Score',
              icon: Icons.assessment,
              onPressed: () {
                // Pass the domain to the ATSScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ATSScreen(domain: domain),
                  ),
                );
              },
            ),
            _buildActionButton(
              context: context,
              text: 'Get Top Skills',
              icon: Icons.star,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopSkillsScreen(
                            domain: domain,
                          )),
                );
              },
            ),
            _buildActionButton(
              context: context,
              text: 'Recommendations',
              icon: Icons.recommend,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendationScreen(
                            domain: domain,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
