import 'package:flutter/material.dart';
import 'package:github_search_app_study/screens/search_screen.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:provider/provider.dart';
import 'i18n/translations.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SearchProvider(),
        child: MaterialApp(
          title: 'github_search_app_study',
          theme: ThemeData(
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.black,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.grey[400],
            ),
            useMaterial3: true,
          ),
          home: SearchScreen(),
        ));
  }
}
