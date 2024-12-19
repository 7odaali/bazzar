import 'package:bazzar/core/helpers/spacing.dart';
import 'package:bazzar/features/myaccount/widget/app_bar_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import 'info_screens/about_bazzar_screen.dart';
import 'info_screens/privacy_policy_screen.dart';
import 'info_screens/return_policy_screen.dart';
import 'info_screens/terms_conditions_screen.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        children: [
          const AppBarProfileScreen(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Info",
                      style: TextStyle(
                        color: ColorsManager.darkBlue,
                        fontSize: 19.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                customListTile(
                  title: "About Bazzar",
                  leadingIcon: const Icon(
                    Icons.account_balance_outlined,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutBazzarScreen(),
                      ),
                    );
                  },
                ),
                verticalSpace(10),
                customListTile(
                  title: "Terms & Conditions",
                  leadingIcon: const Icon(
                    Icons.stadium,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsConditionsScreen(),
                      ),
                    );
                  },
                ),
                verticalSpace(10),
                customListTile(
                  title: "Privacy Policy",
                  leadingIcon: const Icon(
                    Icons.privacy_tip,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                verticalSpace(10),
                customListTile(
                  title: "Return Policy",
                  leadingIcon: const Icon(
                    Icons.local_police_sharp,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReturnPolicyScreen(),
                      ),
                    );
                  },
                ),
                verticalSpace(10),
                customListTile(
                  title: "FAQ's",
                  leadingIcon: const Icon(
                    Icons.question_mark,
                    color: Colors.yellow,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutBazzarScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget customListTile({
    required String title,
    required Icon leadingIcon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Center(
          child: ListTile(
            title: Text(title, style: TextStyles.font15boldDarkBlue),
            leading: leadingIcon,
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 17.w,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
