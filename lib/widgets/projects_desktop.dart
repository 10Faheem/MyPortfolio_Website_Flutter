import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/projects_data.dart';

class ProjectsDesktop extends StatefulWidget {
  final String? id;

  const ProjectsDesktop({super.key, this.id});

  @override
  State<ProjectsDesktop> createState() => _ProjectsDesktopState();
}

class _ProjectsDesktopState extends State<ProjectsDesktop> {
  int? hoveredIndex;

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
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 80),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(
                    color: CustomColor.whitePrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: CustomColor.accentColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'A showcase of my recent work and capabilities',
                  style: TextStyle(
                    color: CustomColor.whiteSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // GridView for Desktop with optimized performance
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1100
                  ? 3
                  : constraints.maxWidth > 800
                      ? 2
                      : 1;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.8, // More vertical cards
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projectsData.length,
                itemBuilder: (context, index) {
                  final item = projectsData[index];
                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = null),
                    child: ProjectCard(
                      title: item['title'],
                      imageUrl: item['img'],
                      url: item['url'],
                      isHovered: hoveredIndex == index,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String url;
  final bool isHovered;

  const ProjectCard({
    required this.title,
    required this.imageUrl,
    required this.url,
    this.isHovered = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: isHovered
          ? (Matrix4.identity()..translate(0, -5, 0))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? CustomColor.accentColor.withOpacity(0.2)
                : Colors.black.withOpacity(0.1),
            blurRadius: isHovered ? 10 : 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => js.context.callMethod('open', [url]),
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 0,
          color: CustomColor.bgLight1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isHovered
                ? BorderSide(color: CustomColor.accentColor, width: 1.5)
                : BorderSide.none,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Project image
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apps,
                          size: 48,
                          color: isHovered
                              ? CustomColor.accentColor
                              : CustomColor.whitePrimary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: isHovered
                                ? CustomColor.accentColor
                                : CustomColor.whitePrimary,
                          ),
                          textAlign: TextAlign.center,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'View on GitHub',
                        style: TextStyle(
                          fontSize: 14,
                          color: isHovered
                              ? CustomColor.accentColor
                              : CustomColor.whiteSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // View project button
                      AnimatedOpacity(
                        opacity: isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: ElevatedButton(
                            onPressed: () =>
                                js.context.callMethod('open', [url]),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColor.accentColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(120, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
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
