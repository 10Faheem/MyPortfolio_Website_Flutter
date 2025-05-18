import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/projects_data.dart';

class ProjectsMobile extends StatefulWidget {
  final String? id;

  const ProjectsMobile({super.key, this.id});

  @override
  State<ProjectsMobile> createState() => _ProjectsMobileState();
}

class _ProjectsMobileState extends State<ProjectsMobile> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    int page = (_pageController.page ?? 0).round();
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add HTML ID for scrolling if provided
    if (widget.id != null) {
      // Add a div with the ID for scrolling
      html.DivElement div = html.DivElement()
        ..id = widget.id!
        ..style.position = 'absolute'
        ..style.top = '0'
        ..style.width = '1px'
        ..style.height = '1px';

      html.document.body?.children.add(div);
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 60),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Column(
              children: [
                Text(
                  'Projects',
                  style: TextStyle(
                    color: CustomColor.whitePrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: 50,
                  height: 3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: CustomColor.accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'A showcase of my recent work and capabilities',
                    style: TextStyle(
                      color: CustomColor.whiteSecondary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Page indicator - simplified for better performance
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              projectsData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 16 : 8,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? CustomColor.accentColor
                      : CustomColor.bgLight1,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Project cards with improved performance
          SizedBox(
            height: 360, // Reduced height
            child: PageView.builder(
              controller: _pageController,
              itemCount: projectsData.length,
              itemBuilder: (context, index) {
                final item = projectsData[index];
                final isActive = index == _currentPage;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: MobileProjectCard(
                    title: item['title'],
                    imageUrl: item['img'],
                    url: item['url'],
                    isActive: isActive,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MobileProjectCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String url;
  final bool isActive;

  const MobileProjectCard({
    required this.title,
    required this.imageUrl,
    required this.url,
    this.isActive = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isActive ? 3 : 1,
      margin: EdgeInsets.zero,
      color: CustomColor.bgLight1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive
            ? BorderSide(color: CustomColor.accentColor, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => js.context.callMethod('open', [url]),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project image
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.bgLight2.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.apps,
                        size: 42,
                        color: isActive
                            ? CustomColor.accentColor
                            : CustomColor.whitePrimary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isActive
                              ? CustomColor.accentColor
                              : CustomColor.whitePrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Project info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View on GitHub',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? CustomColor.accentColor
                            : CustomColor.whiteSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // View button
                    ElevatedButton(
                      onPressed: () => js.context.callMethod('open', [url]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.accentColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 36),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: isActive ? 2 : 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'View Project',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
    );
  }
}
