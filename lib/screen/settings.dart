import 'package:fansseathub/helper/widgets/ListTile.dart';
import 'package:fansseathub/helper/widgets/widgets.dart';
import 'package:fansseathub/screen/privacyandPolicy.dart';
import 'package:fansseathub/screen/termsandConditions.dart';
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
              const AdminSideHeadingsBlack(headings: 'About'),
              ListtileItem(
                listtileText: 'Terms & conditions',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                  );
                },
              ),
              ListtileItem(
                listtileText: 'privacy & policy',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PrivacyAndPolicy()),
                  );
                },
              )
            ],
          )),
    );
  }
}
