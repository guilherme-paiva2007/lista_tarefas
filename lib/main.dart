import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefas/core/constants/preferences.dart';
import 'package:lista_tarefas/core/theme.dart';
import 'package:lista_tarefas/core/utils/set_system_style.dart';
import 'package:lista_tarefas/screens/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lista_tarefas/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge
  );

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final localThemeName = preferences.getString(AppPreferences.localTheme);

  if (localThemeName != null) {
    final localTheme = AppTheme.fromString(localThemeName);
    if (localTheme != null) AppTheme.mode = localTheme;
  }
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } catch(err) {
    //
  }

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with ThemeListener {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((context) {
      setSystemStyle();
    });

    return MaterialApp(
      theme: AppTheme.theme,
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}