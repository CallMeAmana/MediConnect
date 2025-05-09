import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/screens/login_screen.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediconnect/screens/settings/settings_screen.dart';
import 'package:mediconnect/screens/profile/patient_profile_screen.dart';
import 'package:mediconnect/screens/doctor/doctor_dashboard_screen.dart';

import 'package:mediconnect/models/appointment.dart';
import 'appointments/doctor_selection_screen.dart';
import 'messages_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    final List<Widget> _screens = [
      user?.type == UserType.doctor 
        ? const DoctorDashboardScreen() 
        : const HomeTab(),
      const AppointmentsTab(),
      const MessagesTab(),
      user?.type == UserType.doctor 
        ? const DoctorProfileScreen() 
        : const PatientProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _currentIndex == 3 ? null : AppBar(
        title: Text(
          'MediConnect',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}