import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';
import 'package:my_portfolio/pages/skills_page.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
      width: double.infinity,
      color: CustomColor.bgLight1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'My skills',
            style: TextStyle(
                color: CustomColor.whitePrimary,
                fontWeight: FontWeight.w500,
                fontSize: 24),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                for (var item in platformItems)
                  GestureDetector(
                    onTap: () {
                      if (item['title'] != null &&
                          item['description'] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SkillsPage(
                              title: item['title'] as String,
                              description: item['description'] as String,
                            ),
                          ),
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: CustomColor.bgLight2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            leading: Image.asset(
                              item['img'] as String,
                              width: 26,
                            ),
                            title: Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 5,
                          right: 5,
                          child: Opacity(
                            opacity: 0.1,
                            child: Icon(
                              Icons.touch_app,
                              color: CustomColor.whitePrimary,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (var item in skillItems)
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side:
                        const BorderSide(width: 0, color: CustomColor.bgLight2),
                    backgroundColor: CustomColor.bgLight2,
                    label: Text(item['title'] as String),
                    avatar: Image.asset(item['img'] as String),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
