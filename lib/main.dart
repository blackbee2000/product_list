import 'dart:async';

import 'package:flutter/material.dart';
import 'package:product_list/core/configs/easy_loading_config.dart';
import 'package:product_list/core/database/client_manager_database.dart';
import 'package:product_list/features/app/app/app.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    EasyLoadingConfig.config();
    await ClientDatabaseManager.instance.open();
    runApp(const MyApp());
  }, (error, stack) {
    debugPrint('ERROR ===> $error');
  });
}
