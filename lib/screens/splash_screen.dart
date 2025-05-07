import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/screens/login_screen.dart';
import 'package:mediconnect/screens/main_screen.dart';
import 'package:mediconnect/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Wait for animation to complete (3 seconds) then check auth status
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.initAuth();
    
    if (!mounted) return;
    
    // Navigate based on authentication status
    if (authProvider.isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightColorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.lightColorScheme.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.shadowMedium,
              ),
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 60,
              ),
            ).animate()
              .fade(duration: 600.ms, curve: Curves.easeOut)
              .scale(delay: 200.ms, duration: 800.ms, curve: Curves.elasticOut),
            
            const SizedBox(height: 32),
            
            // App Name
            Text(
              'MediConnect',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.lightColorScheme.primary,
              ),
            ).animate()
              .fade(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms, curve: Curves.easeOut),
            
            const SizedBox(height: 16),
            
            // App Description
            Container(
              width: 280,
              alignment: Alignment.center,
              child: Text(
                'Connecting patients and doctors for better healthcare',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightColorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ).animate()
              .fade(delay: 700.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0, delay: 700.ms, duration: 600.ms, curve: Curves.easeOut),
            
            const SizedBox(height: 48),
            
            // Loading Indicator
            CircularProgressIndicator(
              color: AppTheme.lightColorScheme.primary,
            ).animate()
              .fade(delay: 1000.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}