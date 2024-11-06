import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _rememberMe = false;

  // To load saved username and password (if any) on startup
  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // Load saved credentials (if any)
  _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');
    final savedRememberMe = prefs.getBool('rememberMe') ?? false;

    if (savedRememberMe && savedUsername != null && savedPassword != null) {
      setState(() {
        _rememberMe = savedRememberMe;
        usernameController.text = savedUsername;
        passwordController.text = savedPassword;
      });
    }
  }

  // Save credentials if "Remember Me" is checked
  _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('username', usernameController.text);
      prefs.setString('password', passwordController.text);
      prefs.setBool('rememberMe', true);
    } else {
      prefs.remove('username');
      prefs.remove('password');
      prefs.remove('rememberMe');
    }
  }

  // Handle login
  void login(BuildContext context) async {
    String? token = await authService.login(
      usernameController.text,
      passwordController.text,
    );
    if (token != null) {
      // Save credentials if "Remember Me" is checked
      _saveCredentials();
      Navigator.pushReplacementNamed(context, '/home',
          arguments: usernameController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A), // Dark grey
              Color(0xFF0D0D0D), // Blackish grey
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image
                Container(
                  width: 100,
                  height: 94,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors
                          .white54, // Border color compatible with background
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/images/smart resume profiler logo.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 9),

                // Title
                Text(
                  "LOGIN IN",
                  style: TextStyle(
                    color: Color(0xFFC0A480), // Muted brown color
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 18),

                // Username Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D2D), // Dark grey background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                        hintText: "USER NAME",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white70,
                        )),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 8),

                // Password Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D2D), // Dark grey background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "PASSWORD",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white70,
                        )),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 14),

                // Remember Me Checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      activeColor: Color(0xFFC0A480),
                    ),
                    Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),

                // Login Button
                ElevatedButton(
                  onPressed: () => login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC0A480), // Muted brown color
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "LOGIN IN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: 7),

                // Sign Up Text
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                        color: Colors.white70, letterSpacing: 1, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
