import 'package:bazzar/features/stores/Favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/helpers/spacing.dart';
import '../core/theming/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool notificationOn = true;
  bool languageIsEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.w),
                  bottomRight: Radius.circular(30.w),
                ),
                color: ColorsManager.darkBlue,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: 50.w,
                      child: Image.asset(
                        "assets/Logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
            verticalSpace(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Menu",
                        style: TextStyle(
                            color: ColorsManager.darkBlue,
                            fontSize: 19.w,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  verticalSpace(10),
                  _menuItem(
                      title: "Language",
                      icon: Icons.language,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      )),
                  _menuItem(
                      title: "Notification",
                      icon: Icons.notifications,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      )),
                  _menuItem(
                      title: "Wishlist",
                      icon: Icons.favorite,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      }),
                  _menuItem(
                      title: "Change Country",
                      icon: Icons.public,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.w,
                            color: Colors.black54,
                          ),
                        ],
                      )),
                  _menuItem(
                      title: "Offers",
                      icon: Icons.local_offer,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      )),
                  _menuItem(
                      title: "Join us",
                      icon: Icons.person_add,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      )),
                  _menuItem(
                      title: "Info",
                      icon: Icons.info,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.w,
                        color: Colors.black54,
                      )),
                  _menuItem(
                    title: "Contact Us",
                    icon: Icons.contact_mail,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w,
                      color: Colors.black54,
                    ),
                  ),
                  _menuItem(
                    title: "Refer your friend",
                    icon: Icons.share,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.w,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(13.w),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: ListTile(
            leading: Icon(icon, color: Colors.yellow),
            title: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16.w),
            ),
            trailing: trailing ?? const SizedBox(),
            contentPadding: EdgeInsets.zero,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
