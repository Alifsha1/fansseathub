import 'package:fansseathub/helper/widgets/ListTile.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/Subpages/aboutUs.dart';
import 'package:fansseathub/screen/Subpages/privacyandPolicy.dart';
import 'package:fansseathub/screen/Subpages/termsandConditions.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const AdminSideHeadingsBlack(headings: 'settings'),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ListtileItem(
            listtileText: 'Terms & conditions',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const TermsAndConditions()),
              );
            },
          ),
          ListtileItem(
            listtileText: 'privacy & policy',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const PrivacyAndPolicy()),
              );
            },
          ),
          ListtileItem(
            listtileText: ' About us',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.39,
          ),

          //Social links
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FOLLOW OUR SOCIALS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0x33000000),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FeatherIcons.instagram,
                      size: 14,
                      color: Color(0x33000000),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FeatherIcons.twitter,
                      color: Color(0x33000000),
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FeatherIcons.facebook,
                      size: 14,
                      color: Color(0x33000000),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      FeatherIcons.linkedin,
                      size: 14,
                      color: Color(0x33000000),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'v2.0.1',
                  style: TextStyle(
                      color: Color(0x1A000000),
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
