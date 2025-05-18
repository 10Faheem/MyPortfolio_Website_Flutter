// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainMobile extends StatefulWidget {
  final Function(int)? onNavMenuTap;

  const MainMobile({super.key, this.onNavMenuTap});

  @override
  State<MainMobile> createState() => _MainMobileState();
}

class _MainMobileState extends State<MainMobile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // Slower animation for performance
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.transparent,
      child: Stack(
        children: [
          // Simplified animated background - fewer shapes for better performance
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundPainter(_controller.value),
                  isComplex: false,
                );
              },
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile image with simpler decoration
              _buildProfileImage(),
              const SizedBox(height: 30),

              // Intro text
              const Text(
                'Hi, I am',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whitePrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Faheem Umer',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whitePrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Animated text with reduced complexity
              SizedBox(
                height: 36,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Mobile Developer',
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.highlightColor,
                      ),
                      speed: const Duration(milliseconds: 120),
                    ),
                    TypewriterAnimatedText(
                      'Flutter Expert',
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.highlightColor,
                      ),
                      speed: const Duration(milliseconds: 120),
                    ),
                    TypewriterAnimatedText(
                      'UI/UX Enthusiast',
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.highlightColor,
                      ),
                      speed: const Duration(milliseconds: 120),
                    ),
                  ],
                  totalRepeatCount: 2, // Reduced repeat count for performance
                  pause: const Duration(milliseconds: 1500),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
              const SizedBox(height: 30),

              // Buttons with simpler styling
              Column(
                children: [
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () =>
                          downloadResume('download_files/Resume.pdf'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: CustomColor.accentColor,
                      ),
                      child: const Text(
                        'Download Resume',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(
                      onPressed: () {
                        // Use the navMenuTap callback to scroll to projects section (index 2)
                        if (widget.onNavMenuTap != null) {
                          widget.onNavMenuTap!(2);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: CustomColor.accentColor,
                        side: const BorderSide(color: CustomColor.accentColor),
                      ),
                      child: const Text(
                        'View Projects',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Material(
      elevation: 4.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: CircleAvatar(
        radius: 90,
        backgroundColor: CustomColor.bgLight1,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(
            'web/assets/images/myphoto-nobg.png',
            height: 180,
            width: 180,
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColor.accentColor.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Reduced number of shapes for better performance
    for (int i = 0; i < 2; i++) {
      final x = size.width * (0.3 + 0.2 * i);
      final y = size.height * 0.1 +
          size.height * 0.1 * math.sin(animationValue * math.pi + i);

      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.05 + 0.02 * i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

void downloadResume(String url) {
  html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = 'Resume.pdf'
    ..click();
}
