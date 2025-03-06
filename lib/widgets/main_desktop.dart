// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainDesktop extends StatefulWidget {
  const MainDesktop({super.key});

  @override
  State<MainDesktop> createState() => _MainDesktopState();
}

class _MainDesktopState extends State<MainDesktop> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 1.2,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      constraints: const BoxConstraints(minHeight: 350),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hi,\nI am Faheem Umer\nI am a Mobile Developer',
                style: TextStyle(
                  fontSize: 28,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.whitePrimary,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        downloadResume('download_files/Resume.pdf'),
                    style: ElevatedButton.styleFrom(
                      overlayColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: const Color.fromARGB(255, 252, 120, 68),
                    ),
                    child: const Text(
                      'Download Resume',
                      style: TextStyle(
                          color: CustomColor.whitePrimary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Material(
            elevation: 8.0,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'web/assets/images/myphoto-nobg.png',
                scale: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void downloadResume(String url) {
  html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = 'Resume.pdf'
    ..click();
}
