import 'package:bazzar/features/home/home_screen.dart';
import 'package:bazzar/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/widgets/custom_bottom_navigation_bar.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/menuScreens/cubit/notification_service.dart';
import 'features/stores/cubit/favorite_cubit.dart';
import 'firebase_options.dart';
import 'product_model.dart';
import 'dark_mode_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>('favoritesBox');
  await NotificationService.initialize();

  final darkModeCubit = DarkModeCubit();
  await darkModeCubit.loadDarkMode();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DarkModeCubit>(create: (_) => darkModeCubit),
          BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
          BlocProvider<CartCubit>(create: (_) => CartCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<DarkModeCubit, bool>(
          builder: (context, isDarkMode) {
            return MaterialApp(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              home: FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified
                  ? const BottomNavigationBarScreen()
                  : const SplashScreen(),
              routes: {
                "homescreen": (_) => const HomeScreen(),
                "BottomNavigationBarScreen": (_) =>
                const BottomNavigationBarScreen(),
              },
            );
          },
        );
      },
    );
  }
}
