import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/utils/country_utils.dart';
import '../myaccount/widget/app_bar_profile_screen.dart';

String getCountryCodeFromName(String countryName) {
  return countryCodes[countryName] ?? '';
}

class ChangeCountryScreen extends StatefulWidget {
  const ChangeCountryScreen({super.key});

  @override
  _ChangeCountryScreenState createState() => _ChangeCountryScreenState();
}

class _ChangeCountryScreenState extends State<ChangeCountryScreen> {
  Country? selectedCountry;
  String currentCountry = '';

  Future<void> getCurrentCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedCountry = prefs.getString('country');

    if (storedCountry != null) {
      setState(() {
        currentCountry = storedCountry;
      });
    } else {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('userID')
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        String country = userDoc.data()!['country'] ?? '';
        setState(() {
          currentCountry = country;
        });
        prefs.setString('country', country);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarProfileScreen(),
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Change Country",
                      style: TextStyle(
                        color: ColorsManager.darkBlue,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Current Country : $currentCountry',
                      style: TextStyle(
                          fontSize: 12.w, fontWeight: FontWeight.bold),
                    ),
                    horizontalSpace(10.w),
                    if (currentCountry.isNotEmpty &&
                        countryCodes.containsKey(currentCountry))
                      Image.network(
                        'https://flagcdn.com/w320/${countryCodes[currentCountry]!.toLowerCase()}.png',
                        width: 25.w,
                        height: 25.h,
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
                verticalSpace(20),
                GestureDetector(
                  onTap: () => _showCountryPicker(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0.h, horizontal: 20.0.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        selectedCountry == null
                            ? const Text('Change Country')
                            : Row(
                                children: [
                                  Image.network(
                                    'https://flagcdn.com/w320/${selectedCountry!.countryCode.toLowerCase()}.png',
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(selectedCountry!.name),
                                ],
                              ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                verticalSpace(20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCountry != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.w)),
                          title: const Center(
                              child: Text(
                            'Change Country',
                            style: TextStyle(color: ColorsManager.darkBlue),
                          )),
                          content: SizedBox(
                            height: 50.w,
                            child: const Center(
                              child: Text(
                                  'Are you sure you want to change the country?'),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(100.w, 50.h),
                                    backgroundColor: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyles.font17boldDarkBlue,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    saveCountryToFirebase(
                                        selectedCountry!.name);
                                    await saveCountryToPreferences(
                                        selectedCountry!.name);
                                    setState(() {
                                      currentCountry = selectedCountry!.name;
                                      selectedCountry = null;
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: Size(100.w, 50.h),
                                    backgroundColor: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.w),
                                    ),
                                  ),
                                  child: Text(
                                    'Yes',
                                    style: TextStyles.font17boldDarkBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(2000, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 13.w, color: ColorsManager.darkBlue),
        bottomSheetHeight: 500.h,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0.w),
          topRight: Radius.circular(10.0.w),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }

  void saveCountryToFirebase(String country) {
    FirebaseFirestore.instance.collection('users').doc('userID').update({
      'country': country,
    });
  }

  Future<void> saveCountryToPreferences(String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('country', country);
  }
}
