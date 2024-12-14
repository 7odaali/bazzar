import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSearchScreen extends StatefulWidget {
  const FilterSearchScreen({super.key});

  @override
  State<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  final double _minPrice = 0;
  final double _maxPrice = 1000;
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text('Filter search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Select price",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: _minPrice,
            max: _maxPrice,
            divisions: 100,
            activeColor: const Color(0xFF041A31),
            inactiveColor: Colors.grey,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("min : ${_currentRangeValues.start.round()} KWD"),
                Text("max : ${_currentRangeValues.end.round()} KWD"),
              ],
            ),
          ),
          SizedBox(height: 300.h),
          Center(
            child:ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'minPrice': _currentRangeValues.start,
                  'maxPrice': _currentRangeValues.end,
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.yellow, backgroundColor: const Color(0xFF041A31), // لون النص (يمكنك تغييره حسب الحاجة)
              ),
              child: const Text("Search"),
            ),

          ),
           SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
