import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/constraint_width.dart';
import 'package:my_portfolio/widgets/footer.dart';
import 'package:my_portfolio/widgets/get_in_touch.dart';
import 'package:my_portfolio/widgets/header_desktop.dart';
import 'package:my_portfolio/widgets/header_mobile.dart';
import 'package:my_portfolio/widgets/main_desktop.dart';
import 'package:my_portfolio/widgets/main_mobile.dart';
import 'package:my_portfolio/widgets/mobile_drawer.dart';
import 'package:my_portfolio/widgets/projects_desktop.dart';
import 'package:my_portfolio/widgets/projects_mobile.dart';
import 'package:my_portfolio/widgets/skills_desktop.dart';
import 'package:my_portfolio/widgets/skills_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: CustomColor.scaffoldBg,
        key: scaffoldKey,
        endDrawer: constraints.maxWidth >= constraintWidth
            ? null
            : MobileDrawer(
                onNavItemsTap: (int navIndex) {
                  scaffoldKey.currentState?.closeEndDrawer();
                  scrollToSection(navIndex);
                },
              ),
        body: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                key: navBarKeys.first,
              ),
              // Header
              if (constraints.maxWidth >= constraintWidth)
                HeaderDesktop(
                  onNavMenuTap: (int navIndex) {
                    scrollToSection(navIndex);
                  },
                )
              else
                HeaderMobile(
                  logoTap: () {},
                  menuTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),

              // Main
              if (constraints.maxWidth >= constraintWidth)
                const MainDesktop()
              else
                const MainMobile(),

              // Skills
              if (constraints.maxWidth >= constraintWidth)
                SkillsDesktop(
                  key: navBarKeys[1],
                )
              else
                SkillsMobile(
                  key: navBarKeys[1],
                ),

              // Projects
              if (constraints.maxWidth >= constraintWidth)
                ProjectsDesktop(
                  key: navBarKeys[2],
                )
              else
                ProjectsMobile(
                  key: navBarKeys[2],
                ),

              // Contact
              GetInTouch(
                key: navBarKeys[3],
              ),
              const SizedBox(height: 20),
              // Footer
              const Footer(),
            ],
          ),
        ),
      );
    });
  }

  void scrollToSection(int navIndex) {
    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}