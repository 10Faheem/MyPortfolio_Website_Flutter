import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key, required this.onNavItemsTap});
  final Function(int) onNavItemsTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColor.scaffoldBg,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          for (var i = 0; i < 4; i++)
            ListTile(
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: CustomColor.whitePrimary,
              ),
              onTap: () {
                onNavItemsTap(i);
              },
              leading: Icon(navIcons[i]),
              title: Text(navItems[i]),
            ),
        ],
      ),
    );
  }
}
