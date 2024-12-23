import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeCubit extends Cubit<bool> {
  DarkModeCubit() : super(false);

  Future<void> loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode);
  }

  Future<void> toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool currentMode = state;
    await prefs.setBool('isDarkMode', !currentMode);
    emit(!currentMode);
  }
}
