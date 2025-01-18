import 'package:flutter/material.dart';
import "/SignUpApi.dart"; // Replace with the actual path to the SignUpApi class
import '/pages/HomePage.dart'; // Replace with the actual path to the HomePage class
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  // To toggle password visibility
  bool _obscurePassword = true;

  // Function to handle sign-up action
  Future<void> _handleSignUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final referralCode = referralCodeController.text.trim();

    // Validation
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and Password are required!')),
      );
      return;
    }

    int? referralCodeInt;
    if (referralCode.isNotEmpty) {
      referralCodeInt = int.tryParse(referralCode);
      if (referralCodeInt == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid referral code!')),
        );
        return;
      }
    }

    // Use fixed userId and store in SharedPreferences
    final String userId = '62a833766ec5dafd6780fc85';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);

    // Perform the sign-up request
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signing up...')),
    );

    final signUpSuccess = await SignUpApi.signUp(
      email: email,
      password: password,
      referralCode: referralCodeInt,
      userId: userId, // Use the fixed userId
    );

    if (signUpSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up successful!')),
      );

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up failed. Email may already exist.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),

                // Logo
                const SizedBox(height: 20),
                Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white70.withOpacity(0.6),
                      BlendMode.srcOver,
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 200,
                    ),
                  ),
                ),

                // Let's Begin Text
                const SizedBox(height: 40),
                const Text(
                  "Let's Begin!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Subtitle
                const SizedBox(height: 8),
                const Text(
                  "Please enter your credentials to proceed",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                // Email Field
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Your Email",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD32F2F)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                ),

                // Password Field
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Create Password",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD32F2F)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                // Referral Code Field
                const SizedBox(height: 20),
                TextField(
                  controller: referralCodeController,
                  decoration: InputDecoration(
                    labelText: "Referral Code (Optional)",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD32F2F)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    labelStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                ),

                // Submit Button
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: _handleSignUp,
          backgroundColor: const Color(0xFFD32F2F),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
