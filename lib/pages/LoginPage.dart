import 'package:flutter/material.dart';
import '/LoginApi.dart';
import '/pages/OtpPage.dart';
import '/pages/SignUppage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool isPhoneSelected = true;
  final TextEditingController _inputController = TextEditingController();
  bool isInputValid = false;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_validateInput);
  }

  void _validateInput() {
    final input = _inputController.text;
    setState(() {
      if (isPhoneSelected) {
        // Validate phone number (10 digits)
        isInputValid = RegExp(r'^\d{10}$').hasMatch(input);
      } else {
        // Validate email address
        isInputValid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(input);
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 40),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        isPhoneSelected = true;
                        _validateInput(); // Revalidate input for phone number
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isPhoneSelected
                              ? const Color.fromRGBO(194, 52, 62, 1)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'Phone',
                          style: TextStyle(
                            color: isPhoneSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        isPhoneSelected = false;
                        _validateInput(); // Revalidate input for email
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: !isPhoneSelected
                              ? const Color.fromRGBO(194, 52, 62, 1)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: !isPhoneSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Glad to see you!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPhoneSelected
                  ? 'Please provide your phone number'
                  : 'Please provide your email address',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: isPhoneSelected ? 'Phone' : 'Email',
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(194, 52, 62, 1)),
                ),
              ),
              keyboardType: isPhoneSelected
                  ? TextInputType.phone
                  : TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isInputValid
                    ? () async {

                  bool success = await LoginApi.sendCode(_inputController.text);
                  if (success) {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Otppage(),
                      ),
                    );
                  } else {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInputValid
                      ? const Color.fromRGBO(194, 52, 62, 1)
                      : const Color.fromRGBO(242, 177, 179, 1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SEND CODE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
