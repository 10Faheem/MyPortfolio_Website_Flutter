import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/projects_data.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class ProjectsDesktop extends StatelessWidget {
  const ProjectsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Projects',
              style: TextStyle(
                  color: CustomColor.whitePrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          // GridView for Desktop
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 4 / 3, // Aspect ratio of each card
            ),
            shrinkWrap:
                true, // Allows the GridView to be constrained by its parent
            physics:
                const NeverScrollableScrollPhysics(), // Prevents scrolling within this GridView
            itemCount: projectsData.length,
            itemBuilder: (context, index) {
              final item = projectsData[index];
              return Container(
                decoration: BoxDecoration(
                  color: CustomColor.bgLight2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    final url = item['url'] as String;
                    js.context.callMethod('open', [url]);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Image.asset(
                            item['img'] as String,
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
