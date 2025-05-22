import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:product_list/core/database/client_manager_database.dart';
import 'package:product_list/core/enums/language_mode.dart';
import 'package:product_list/core/routes/app_pages.dart';
import 'package:product_list/core/routes/app_routes.dart';
import 'package:product_list/core/themes/app_theme.dart';
import 'package:product_list/features/app/app/app_binding.dart';
import 'package:product_list/generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    unawaited(ClientDatabaseManager.instance.closeConnection());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final defaultLocale = LanguageMode.vietnamese.locale;
        if (locale == null) {
          S.load(defaultLocale);
          return defaultLocale;
        }

        S.load(defaultLocale);
        return defaultLocale;
      },
      theme: AppTheme.themeData,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splashScreen,
      initialBinding: AppBinding(),
      builder: EasyLoading.init(),
    );
  }
}
