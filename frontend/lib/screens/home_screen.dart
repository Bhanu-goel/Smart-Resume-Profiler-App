import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'alert_screen.dart';
import 'explore_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'resume_analysis_screen.dart';
import 'resume_tips_screen.dart'; // Import the Resume Tips screen
import 'interview_prep_screen.dart'; // Import the Interview Prep screen

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExploreScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlertsScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen(userName: widget.userName)),
        );
        break;
    }
  }

  void logout(BuildContext context) async {
    await AuthService().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void analyzeResume() {
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
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => logout(context),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0D1F2D),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // User Greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome,\n${widget.userName}',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Main Features section
                Text('Smart Resume Profiler Features',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
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
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Resource Cards (Clickable)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumeTipsScreen()),
                        );
                      },
                      child: ResourceCard(resourceName: 'Resume Tips'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InterviewPrepScreen()),
                        );
                      },
                      child: ResourceCard(resourceName: 'Interview Prep'),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Analyze Resume Button
                Text('Analyze Your Resume',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: analyzeResume,
                    child: Text('Resume Scanner',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Alerts'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.greenAccent,
            unselectedItemColor: Colors.grey[600],
            onTap: _onItemTapped,
          ),
        ));
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
