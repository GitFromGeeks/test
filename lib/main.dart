import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/core/sqflite/sqflite.dart';
import 'package:test/src/features/post/display/pages/post_page.dart';
import 'package:test/src/features/post/display/providers/post_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteService.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostPage(),
      ),
    );
  }
}
