import 'package:flutter/material.dart';
import 'package:github_search_app_study/screens/search_screen.dart';
import 'package:github_search_app_study/services/github_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 追加

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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SearchScreen(),
        ));
  }
}