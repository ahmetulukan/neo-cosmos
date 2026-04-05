import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/base/presentation/base_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  // await Hive.openBox('game_cache');
  
  runApp(const ProviderScope(child: NeoCosmosApp()));
}

class NeoCosmosApp extends StatelessWidget {
  const NeoCosmosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neo Cosmos',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const BaseScreen(),
    );
  }
}