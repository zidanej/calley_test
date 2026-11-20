import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class EmailOtpVerificationScreen extends StatefulWidget {
  final String email;
  final String? userid;
  final String? sentOtp;
  final String? userMobile;

  const EmailOtpVerificationScreen({
    super.key,
    required this.email,
    this.userid,
    this.sentOtp,
    this.userMobile,
  });

  @override
  State<EmailOtpVerificationScreen> createState() =>
      EmailOtpVerificationScreenState();
}

class EmailOtpVerificationScreenState
    extends State<EmailOtpVerificationScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  final AuthService authService = AuthService();
  bool isLoading = false;
  String? sentOtp;

  @override
  void initState() {
    super.initState();
    sentOtp = widget.sentOtp;
  }

  String get enteredOtp =>
      otpControllers.map((controller) => controller.text).join();

  void handleOtpChange(int index, String value) {
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

      for (int i = 0; i < digits.length && index + i < 6; i++) {
        otpControllers[index + i].text = digits[i];
      }

      final nextIndex = (index + digits.length).clamp(0, 5);
      otpFocusNodes[nextIndex].requestFocus();
      setState(() {});
      return;
    }

    if (value.isNotEmpty && index < 5) {
      otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }

    setState(() {});
  }

  Future<void> verifyOtp() async {
    if (enteredOtp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete 6-digit OTP')),
      );
      return;
    }

    final userid = widget.userid;
    final sentOtp = this.sentOtp;

    if (userid == null || sentOtp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'OTP session information is missing. Please login again.',
          ),
        ),
      );
      return;
    }

    if (enteredOtp != sentOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.verifyOtp(userid: userid);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            userName: widget.email.split('@').first,
            userEmail: widget.email,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> resendOtp() async {
    final userid = widget.userid;
    if (userid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User information is missing. Please login again.'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await authService.sendOtp(userid: userid);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP resent successfully')));

      setState(() {
        sentOtp = result.otp;
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in otpControllers) {
      controller.dispose();
    }

    for (final focusNode in otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final panelHeight = math.max(
      540.0,
      MediaQuery.sizeOf(context).height -
          190 -
          MediaQuery.of(context).viewInsets.bottom,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              const SizedBox(height: 55),

              Image.asset(
                'assets/images/calley_logo.png',
                width: 260,
                height: 100,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 35),

              SizedBox(
                height: panelHeight,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    border: Border.all(color: const Color(0xFFD3DEEC)),
                  ),
                  child: Column(
                    children: [
                      const Spacer(),

                      const Text(
                        'Email OTP\nVerification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.15,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        'Please ensure that the email address '
                        'mentioned is valid as we have sent an '
                        'OTP to your email.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 55),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 43,
                            height: 65,
                            child: TextField(
                              controller: otpControllers[index],
                              focusNode: otpFocusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) {
                                handleOtpChange(index, value);
                              },
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD3DEEC),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD3DEEC),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2862ED),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 35),

                      Text(widget.email, style: const TextStyle(fontSize: 18)),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Text(
                              "Didn't receive OTP code?",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          TextButton(
                            onPressed: isLoading ? null : resendOtp,
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: Color(0xFF2862ED),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2862ED),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
