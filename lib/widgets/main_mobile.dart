// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Hi,\nI am Faheem Umer\nI am a Mobile Developer',
              style: TextStyle(
                fontSize: 30,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: CustomColor.whitePrimary,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //   },
                //   style: ElevatedButton.styleFrom(
                //     overlayColor: const Color.fromARGB(255, 145, 0, 0),
                //     padding: const EdgeInsets.symmetric(horizontal: 33),
                //     backgroundColor: const Color.fromARGB(255, 252, 120, 68),
                //   ),
                //   child: const Text(
                //     'Get in touch',
                //     style: TextStyle(
                //         color: CustomColor.whitePrimary,
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),
                // const SizedBox(width: 7),
                ElevatedButton(
                  onPressed: () =>
                      downloadResume('web/assets/download_files/Resume.pdf'),
                  style: ElevatedButton.styleFrom(
                    overlayColor: const Color.fromARGB(255, 145, 0, 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

void downloadResume(String url) {
  html.AnchorElement(href: url)
    ..download = 'Resume.pdf'
    ..click();
}
