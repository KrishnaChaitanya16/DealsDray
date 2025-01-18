import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/pages/LoginPage.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Image.asset(
              'assets/splashscreen.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.3),
                BlendMode.srcOver,
              ),
              child: Image.asset(
                'assets/logo.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: SpinKitCircle(
                      color: Color(0xFFD32F2F),
                      size: 60.0,
                    ),
                  ),
                  const SizedBox(height: 5),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}