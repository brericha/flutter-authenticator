import 'package:authenticator/app_themes.dart';
import 'package:authenticator/database.dart';
import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/data/account_repository_impl.dart';
import 'package:authenticator/shared/data/settings_repository.dart';
import 'package:authenticator/shared/data/settings_repository_impl.dart';
import 'package:authenticator/util/bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import 'feature/account_list/ui/account_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  if (!kReleaseMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.loggerName}-${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  // Initialize singletons
  await Database().init();
  GetIt.I.registerSingleton<AccountRepository>
    (AccountRepositoryImpl(Database().accountBox));

  final preferences = SettingsRepositoryImpl();
  await preferences.init();
  GetIt.I.registerSingleton<SettingsRepository>(preferences);

  // Start the app wrapped in a BlocObserver
  BlocOverrides.runZoned(() => runApp(const MyApp()),
      blocObserver: SimpleBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authenticator',
      theme: appThemeData[AppTheme.light]!.copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CustomColors.light
          ]
      ),
      darkTheme: appThemeData[AppTheme.dark]!.copyWith(
          extensions: <ThemeExtension<dynamic>>[
            CustomColors.dark
          ]
      ),
      home: const AccountListPage(),
    );
  }
}