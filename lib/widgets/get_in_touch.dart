// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/constraint_width.dart';
import 'package:my_portfolio/widgets/custom_text_field.dart';

class GetInTouch extends StatelessWidget {
  const GetInTouch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: CustomColor.bgLight1,
      child: Column(
        children: [
          const Text(
            'Get in touch',
            style: TextStyle(
                color: CustomColor.whitePrimary,
                fontWeight: FontWeight.w500,
                fontSize: 24),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
              maxHeight: 100,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= constraintWidth) {
                  return buildNameEmailDesktop();
                }
                return buildNameEmailMobile();
              },
            ),
          ),
          const SizedBox(height: 7),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: const CustomTextField(
              hintText: 'Your message',
              maxLines: 10,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: CustomColor.accentColor,
                foregroundColor: CustomColor.whitePrimary,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Center(
                      child: Text('Email service is not available yet'),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Send',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            child: const Divider(
              thickness: 2,
            ),
          ),
          const SizedBox(height: 7),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              InkWell(
                onTap: () {
                  const url = 'https://github.com/10Faheem';
                  js.context.callMethod('open', [url]);
                },
                child: Image.asset(
                  'web/assets/images/github.png',
                  width: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  const url =
                      'https://www.linkedin.com/in/faheem-umer-8b0023274/';
                  js.context.callMethod('open', [url]);
                },
                child: Image.asset(
                  'web/assets/images/linkedin.png',
                  width: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  const url = 'https://www.instagram.com/faheemm.umer/';
                  js.context.callMethod('open', [url]);
                },
                child: Image.asset(
                  'web/assets/images/instagram.png',
                  width: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  const url = 'https://leetcode.com/u/faheem10/';
                  js.context.callMethod('open', [url]);
                },
                child: Image.asset(
                  'web/assets/images/leetcode.png',
                  width: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Row buildNameEmailDesktop() {
    return const Row(
      children: [
        Flexible(
          child: CustomTextField(hintText: 'Your name'),
        ),
        SizedBox(width: 7),
        Flexible(
          child: CustomTextField(hintText: 'Your email'),
        ),
      ],
    );
  }

  Column buildNameEmailMobile() {
    return const Column(
      children: [
        Flexible(
          child: CustomTextField(hintText: 'Your name'),
        ),
        SizedBox(height: 7),
        Flexible(
          child: CustomTextField(hintText: 'Your email'),
        ),
      ],
    );
  }
}
