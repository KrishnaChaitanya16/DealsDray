import 'package:flutter/material.dart';
import 'dart:async';
import '/OtpVerification.dart';

class Otppage extends StatefulWidget {
  const Otppage({super.key});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  late Timer _timer;
  int _start = 120; // 2 minutes in seconds
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();

    // Listen to changes in OTP fields
    _otpController1.addListener(_checkAndVerifyOtp);
    _otpController2.addListener(_checkAndVerifyOtp);
    _otpController3.addListener(_checkAndVerifyOtp);
    _otpController4.addListener(_checkAndVerifyOtp);
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getFormattedTime() {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  // Check if OTP is complete and then verify
  void _checkAndVerifyOtp() {
    String otp = _otpController1.text + _otpController2.text + _otpController3.text + _otpController4.text;

    if (otp.length == 4) {
      verifyOtp(otp);
    }
  }

  Future<void> verifyOtp(String otp) async {
    bool isVerified = await OtpVerificationApi.verifyOtp(otp);

    if (isVerified) {
      print('OTP verified successfully.');
      // Proceed to the next step
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully.')),
      );
    } else {
      print('OTP verification failed. Try again.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:  IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/Otp1.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'We have sent a unique OTP number\nto your mobile +91-9765232817',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                    (index) => Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: index == 0
                        ? _otpController1
                        : index == 1
                        ? _otpController2
                        : index == 2
                        ? _otpController3
                        : _otpController4,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Timer and Resend button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getFormattedTime(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: _start == 0
                      ? () {
                    setState(() {
                      _start = 120;
                      startTimer();
                    });
                  }
                      : null,
                  child: Text(
                    'SEND AGAIN',
                    style: TextStyle(
                      color: _start == 0
                          ? const Color.fromRGBO(194, 52, 62, 1)
                          : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
