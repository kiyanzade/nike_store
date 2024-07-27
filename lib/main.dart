import 'package:flutter/material.dart';
import 'package:nike_store/data/favorite_manager.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/theme.dart';

import 'package:nike_store/ui/root.dart';

void main() {
  FavoritesManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository
        .getAll(ProductSort.latest)
        .then((value) {})
        .catchError((e) {});

    bannerRepository.getAll().then((value) {}).catchError((e) {});
    const defaultTextStyle = TextStyle(
        fontFamily: 'Vazir', color: LightThemeColors.primaryTextColor);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        hintColor: LightThemeColors.scondaryTextColor,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: LightThemeColors.primaryTextColor.withOpacity(0.1)),
          ),
        ),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.white,
            foregroundColor: LightThemeColors.primaryTextColor),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white)),
        textTheme: TextTheme(
          titleMedium:
              defaultTextStyle.apply(color: LightThemeColors.scondaryTextColor),
          labelLarge: defaultTextStyle,
          bodyMedium: defaultTextStyle,
          titleLarge: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 18),
          bodySmall:
              defaultTextStyle.apply(color: LightThemeColors.scondaryTextColor),
        ),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: RootScreen(),
      ),
    );
  }
}
