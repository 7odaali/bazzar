/*
import 'package:flutter/material.dart';
class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Container(),
    );
  }
}
*/
import 'package:flutter/material.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({super.key});

  @override
  State<LangScreen> createState() => _LangScreenState();
}

class _LangScreenState extends State<LangScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر اللغة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "الرجاء اختيار اللغة:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Language buttons
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = 'العربية';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedLanguage == 'العربية' ? Colors.blue : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "العربية",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedLanguage = 'English';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedLanguage == 'English' ? Colors.blue : Colors.grey,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "English",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            // Confirmation button
            ElevatedButton(
              onPressed: () {
                // Save selected language logic here
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("تم اختيار اللغة: $selectedLanguage"),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "تأكيد",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
