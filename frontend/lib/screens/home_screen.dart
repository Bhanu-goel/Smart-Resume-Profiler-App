// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'alert_screen.dart';
import 'explore_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'resume_analysis_screen.dart'; // Import the new screen

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the currently selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    // Navigate based on the selected index
    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExploreScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0; // Reset to Home
          });
        });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlertsScreen()),
        ).then((_) {
          setState(() {
            _selectedIndex = 0; // Reset to Home
          });
        });
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(userName: widget.userName)),
        ).then((_) {
          setState(() {
            _selectedIndex = 0; // Reset to Home
          });
        });
        break;
      // Add more cases as needed
    }
  }

  void logout(BuildContext context) async {
    await AuthService().logout(); // Log out the user
    // Navigate to the login screen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => WelcomeScreen()), // Navigate to LoginScreen
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  void analyzeResume() {
    // Navigate to the resume analysis screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResumeAnalysisScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.greenAccent.withOpacity(0.1),
        title: Text(
          "SMART RESUME PROFILER",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent.withOpacity(0.1), Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context), // Call the logout function
          ),
        ],
      ),
      backgroundColor:
          Color(0xFF0D1F2D), // Dark greenish color matching the theme
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section: User Greeting and Profile Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome,\n${widget.userName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    radius: 20,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Main Features section
              Text(
                'Smart Resume Profiler Features',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),

              // Feature cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(
                    title: 'ATS Score',
                    description:
                        'Check your resume’s compatibility with ATS systems.',
                    price: 'Free',
                  ),
                  FeatureCard(
                    title: 'Personal Tailoring',
                    description:
                        'Get a tailored resume to highlight your strengths.',
                    price: '\$5',
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Additional Services
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeatureCard(
                    title: 'Recommendations',
                    description:
                        'Get personalized tips to improve your resume.',
                    price: '\$3',
                  ),
                  FeatureCard(
                    title: 'Resume Templates',
                    description:
                        'Explore templates designed to impress recruiters.',
                    price: '100+',
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Suggested resources section
              Text(
                'Recommended Resources',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Resource Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ResourceCard(resourceName: 'Resume Tips'),
                  ResourceCard(resourceName: 'Interview Prep'),
                ],
              ),
              SizedBox(height: 30), // Add some spacing before the button

              // Suggested resources section
              Text(
                'Analyze Your Resume',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              // Analyze Resume Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Button color
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Button shape
                    ),
                  ),
                  onPressed: analyzeResume, // Navigate to analyze resume screen
                  child: Text(
                    'Resume Scanner',
                    style: TextStyle(
                        color: Colors.black, fontSize: 18), // Button text style
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.greenAccent.withOpacity(0.1),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Alerts'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex, // Set the current index
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.grey[600],
          onTap: _onItemTapped, // Handle taps
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}

// Custom widgets for FeatureCard and ResourceCard remain unchanged

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  const FeatureCard({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          Text(
            price,
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  final String resourceName;

  const ResourceCard({required this.resourceName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: Icon(Icons.book, color: Colors.black), // Resource icon
          ),
          SizedBox(height: 8),
          Text(
            resourceName,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
