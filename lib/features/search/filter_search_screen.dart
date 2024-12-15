import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/theming/colors.dart';

class FilterSearchScreen extends StatefulWidget {
  const FilterSearchScreen({super.key});

  @override
  State<FilterSearchScreen> createState() => _FilterSearchScreenState();
}

class _FilterSearchScreenState extends State<FilterSearchScreen> {
  final double _minPrice = 0;
  final double _maxPrice = 1000;
  RangeValues _currentRangeValues = const RangeValues(0, 1000);

  List<String> _categories = [];
  final Set<String> _selectedCategories = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories =
            snapshot.docs.map((doc) => doc['name'] as String).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch categories: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Filter search'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Select price",
                    style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
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
                  padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("min: ${_currentRangeValues.start.round()} KWD"),
                      Text("max: ${_currentRangeValues.end.round()} KWD"),
                    ],
                  ),
                ),
                 Padding(
                  padding: EdgeInsets.all(20.0.w),
                  child:  Text(
                    "Select categories",
                    style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: _categories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategories.add(category);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                        },
                        selectedColor:Colors.yellow ,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                            color: isSelected ? ColorsManager.darkBlue : Colors.black),
                      );
                    }).toList(),
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'minPrice': _currentRangeValues.start,
                        'maxPrice': _currentRangeValues.end,
                        'categories': _selectedCategories.toList(),
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.yellow,
                      backgroundColor: const Color(0xFF041A31),
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
