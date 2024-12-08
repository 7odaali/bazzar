import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../lang_screen.dart';
import 'package:bazzar/core/helpers/spacing.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /*Future<void> _fetchImages() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('onboarding')
          .doc('rkwrWVNiUIAvJd5ENYvd')
          .get();

      final data = snapshot.data();
      print(
          '=======================================Fetched data: $data');

      if (data != null && data['images'] is List) {
        setState(() {
          _images = List<String>.from(
              data['images']);
        });
        print(
            '==========================================Images list: $_images');
      }
    } catch (e) {
      print(
          '====================================================Error fetching images: $e');
    }
  }*/
  Future<void> _fetchImages() async {
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('onboarding').get();

      List<String> images = [];
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data['images'] is List) {
          images.addAll(
            List<String>.from(
              data['images'],
            ),
          );
        }
      }

      setState(() {
        _images = images;
      });
      print('==========================================Images list: $_images');
    } catch (e) {
      print(
          '====================================================Error fetching images: $e');
    }
  }

  void _nextPage() {
    if (_currentPage < _images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LangScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundWhite,
      body: Padding(
        padding: EdgeInsets.only(right: 30.w, left: 30.w, top: 40.h),
        child: Column(
          children: [
            SizedBox(
              height: 650.h,
              width: 500.w,
              child: _images.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: ClipRRect(borderRadius: BorderRadius.circular(25.w),
                      child: Image.network(
                        _images[i],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
                    (index) =>
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentPage == index ? 14.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? ColorsManager.yellow
                            : ColorsManager.darkBlue,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
              ),
            ),
            verticalSpace(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40.h,
                  minWidth: 120.w,
                  color: ColorsManager.darkBlue,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LangScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Skip",
                    style: TextStyles.font17boldYellow,
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40.h,
                  minWidth: 120.w,
                  color: ColorsManager.yellow,
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _images.length - 1 ? "Start" : "Next",
                    style: TextStyles.font17boldDarkBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
