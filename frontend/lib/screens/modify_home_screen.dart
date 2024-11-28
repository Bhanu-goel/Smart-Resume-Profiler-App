// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:frontend/screens/glassContainer.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For animations
import 'package:glassmorphism/glassmorphism.dart'; // For glass effect

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GlassContainer(
              height: 40,
              width: 40,
              blur: 10,
              borderRadius: BorderRadius.circular(20),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  // Notification action
                },
              ),
            ).animate().fade().scale(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${widget.userName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().slideX(duration: 500.ms),
                          SizedBox(height: 5),
                          Text(
                            'Your Career Journey Starts Here',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ).animate().slideX(delay: 300.ms, duration: 500.ms),
                        ],
                      ),
                      GlassContainer(
                        height: 60,
                        width: 60,
                        blur: 10,
                        borderRadius: BorderRadius.circular(30),
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ).animate().scale(),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Other sections
                  _buildInteractiveServices(context),
                  SizedBox(height: 20),
                  _buildRecommendedResources(context),
                  SizedBox(height: 20),
                  _buildQuickActions(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildInteractiveBottomNavBar(context),
    );
  }

  Widget _buildInteractiveBottomNavBar(BuildContext context) {
    return GlassContainer(
      height: 70,
      width: double.infinity,
      blur: 10,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.blueAccent
            .withOpacity(0.6), // Changed the color to a more vibrant blue
        elevation: 0,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resume Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _serviceCard(
                icon: Icons.analytics_outlined,
                title: 'ATS Analyzer',
                description: 'Optimize resume for tracking systems',
                color: Colors.blue.shade200,
              ),
              SizedBox(width: 10),
              _serviceCard(
                icon: Icons.design_services_outlined,
                title: 'Resume Design',
                description: 'Professional templates & styling',
                color: Colors.purple.shade200,
              ),
              SizedBox(width: 10),
              _serviceCard(
                icon: Icons.recommend_outlined,
                title: 'Personalized Tips',
                description: 'Tailored improvement suggestions',
                color: Colors.green.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Add action
      },
      child: GlassContainer(
        height: 180,
        width: 160,
        blur: 10,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedResources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning Resources',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _resourceCard(
                title: 'Interview Prep',
                icon: Icons.video_library,
                color: Colors.orange.shade200,
              ),
              SizedBox(width: 10),
              _resourceCard(
                title: 'Career Tips',
                icon: Icons.lightbulb_outline,
                color: Colors.yellow.shade200,
              ),
              SizedBox(width: 10),
              _resourceCard(
                title: 'Skill Development',
                icon: Icons.graphic_eq,
                color: Colors.teal.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _resourceCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Resource action
      },
      child: GlassContainer(
        height: 120,
        width: 120,
        blur: 10,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            icon: Icon(Icons.analytics, color: Colors.white),
            label:
                Text('Analyze Resume', style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Analyze action
            },
          ),
        ),
      ],
    );
  }
}
