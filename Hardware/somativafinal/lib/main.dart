import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ponto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // 👇 Mude aqui: use colorScheme com primary definido
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4A6B3F), // ✅ Verde musgo
          secondary: const Color(0xFF6B8E23), // opcional: verde mais claro
          background: Colors.white,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A6B3F), // ✅ Verde musgo
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A6B3F), // ✅ Verde musgo
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const LoginView(),
    );
  }
}