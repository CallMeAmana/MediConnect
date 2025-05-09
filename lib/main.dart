import 'package:flutter/material.dart';
import 'package:mediconnect/providers/appointment_provider.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/providers/settings_provider.dart';
import 'package:mediconnect/screens/splash_screen.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    
    return MaterialApp(
      title: 'MediConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: settingsProvider.isDarkMode 
          ? AppTheme.darkColorScheme 
          : AppTheme.lightColorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: settingsProvider.isDarkMode 
            ? Colors.grey.shade900 
            : Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: settingsProvider.isDarkMode 
                ? Colors.grey.shade800 
                : Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: settingsProvider.isDarkMode 
                ? Colors.grey.shade800 
                : Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: settingsProvider.isDarkMode 
                ? AppTheme.darkColorScheme.primary 
                : AppTheme.lightColorScheme.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: settingsProvider.isDarkMode 
                ? AppTheme.darkColorScheme.error 
                : AppTheme.lightColorScheme.error,
              width: 2.0,
            ),
          ),
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: settingsProvider.isDarkMode 
              ? Colors.grey.shade300 
              : Colors.grey.shade700,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
            backgroundColor: settingsProvider.isDarkMode 
              ? AppTheme.darkColorScheme.primary 
              : AppTheme.lightColorScheme.primary,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}