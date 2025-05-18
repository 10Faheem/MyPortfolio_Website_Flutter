// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainDesktop extends StatefulWidget {
  final Function(int)? onNavMenuTap;

  const MainDesktop({super.key, this.onNavMenuTap});

  @override
  State<MainDesktop> createState() => _MainDesktopState();
}

class _MainDesktopState extends State<MainDesktop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 30), // Slower animation for better performance
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 1.2,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      constraints: const BoxConstraints(minHeight: 450),
      child: Stack(
        children: [
          // Animated background shapes (reduced complexity)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: BackgroundPainter(_controller.value),
                  isComplex: false, // Hint to Flutter that this isn't complex
                );
              },
            ),
          ),
          // Main content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Left column - text and buttons
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hi, I am',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Faheem Umer',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.whitePrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Mobile Developer',
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.highlightColor,
                          ),
                          speed: const Duration(milliseconds: 120),
                        ),
                        TypewriterAnimatedText(
                          'Flutter Expert',
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.highlightColor,
                          ),
                          speed: const Duration(milliseconds: 120),
                        ),
                        TypewriterAnimatedText(
                          'UI/UX Enthusiast',
                          textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: CustomColor.highlightColor,
                          ),
                          speed: const Duration(milliseconds: 120),
                        ),
                      ],
                      totalRepeatCount: 2, // Reduced repeat count
                      pause: const Duration(milliseconds: 1500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        _buildButton(
                          'Download Resume',
                          () => downloadResume('download_files/Resume.pdf'),
                          isPrimary: true,
                        ),
                        const SizedBox(width: 16),
                        _buildButton(
                          'View Projects',
                          () {
                            // Use the navMenuTap callback to scroll to projects section (index 2)
                            if (widget.onNavMenuTap != null) {
                              widget.onNavMenuTap!(2);
                            }
                          },
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              // Right column - profile image
              Expanded(
                flex: 4,
                child: _buildProfileImage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Material(
      elevation: 8.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: CircleAvatar(
        radius: 140,
        backgroundColor: CustomColor.bgLight1,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(
            'web/assets/images/myphoto-nobg.png',
            height: 280,
            width: 280,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {bool isPrimary = true}) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: CustomColor.accentColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: CustomColor.accentColor,
          side: const BorderSide(color: CustomColor.accentColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }
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
    for (int i = 0; i < 3; i++) {
      final y = size.height * (0.3 + 0.2 * i);
      final x = size.width * 0.1 +
          size.width * 0.15 * math.sin(animationValue * math.pi + i);

      canvas.drawCircle(
        Offset(x, y),
        size.width * (0.08 + 0.03 * i),
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
