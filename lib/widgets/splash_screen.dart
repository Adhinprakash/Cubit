import 'dart:async';

import 'package:cubit/features/auth/auth_gate.dart';
import 'package:cubit/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _loaderController;

  static const Color primaryColor = Color(0xFF20B86B);

  @override
  void initState() {
    super.initState();

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthGate(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [

          

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 90,
                child: CustomPaint(
                  painter: BottomWavePainter(
                    color: primaryColor,
                  ),
                ),
              ),
            ),

        

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    height: 250,
                    width: 200,
            
                    padding: const EdgeInsets.all(25),

                 

                    child: Image.asset(
                      'assets/images/shoppy_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 25),

             
                  const Text(
                    'Shoppy',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.5,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

            
                  const Text(
                    'Shop More. Live Better.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF5F6368),
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: 55),

                 

                  SizedBox(
                    height: 240,
                    width: 300,

                    child: Image.asset(
                      'assets/images/shoppy_splash.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 35),

             
                  RotationTransition(
                    turns: _loaderController,
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(
                          primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class BottomWavePainter extends CustomPainter {
  final Color color;

  BottomWavePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height * 0.55);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.50,
      size.height * 0.60,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.95,
      size.width,
      size.height * 0.35,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}