import 'package:flutter/material.dart';
import 'package:my_portfolio/styles/style.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

class HeaderMobile extends StatelessWidget {
  const HeaderMobile({super.key, this.logoTap, this.menuTap});
  final VoidCallback? logoTap;
  final VoidCallback? menuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 5, 20, 5),
      height: 50,
      decoration: kHeaderDecoration,
      child: Row(
        children: [
          SiteLogo(
            onTap: logoTap,
          ),
          const Spacer(),
          IconButton(
            onPressed: menuTap,
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
