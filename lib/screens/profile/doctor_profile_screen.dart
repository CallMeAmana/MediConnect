import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _specializationController;
  late TextEditingController _qualificationsController;
  late TextEditingController _experienceController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _specializationController = TextEditingController(text: user?.specialization);
    _qualificationsController = TextEditingController(
      text: user?.qualifications?.join(', '),
    );
    _experienceController = TextEditingController(text: '10 years'); // Example
    _bioController = TextEditingController(
      text: 'Experienced doctor specializing in providing comprehensive healthcare.',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _qualificationsController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.id)
          .update({
        'name': _nameController.text,
        'specialization': _specializationController.text,
        'qualifications': _qualificationsController.text.split(',').map((e) => e.trim()).toList(),
        'experience': _experienceController.text,
        'bio': _bioController.text,
      });

      if (!mounted) return;
      
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'Doctor Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : () => setState(() => _isEditing = true),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(theme),
            _buildProfileForm(theme),
            _buildStatistics(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              if (_isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (!_isEditing) ...[
            Text(
              _nameController.text,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _specializationController.text,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ],
      ),
    ).animate().fade().slideY(begin: 0.2);
  }

  Widget _buildProfileForm(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Personal Information', theme),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              enabled: _isEditing,
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              enabled: false,
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Professional Information', theme),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _specializationController,
              label: 'Specialization',
              enabled: _isEditing,
              icon: Icons.medical_services_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your specialization';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _qualificationsController,
              label: 'Qualifications',
              enabled: _isEditing,
              icon: Icons.school_outlined,
              helperText: 'Separate qualifications with commas',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your qualifications';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _experienceController,
              label: 'Experience',
              enabled: _isEditing,
              icon: Icons.work_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _bioController,
              label: 'Professional Bio',
              enabled: _isEditing,
              icon: Icons.description_outlined,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Statistics', theme),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Patients',
                  value: '150+',
                  icon: Icons.people_outline,
                  theme: theme,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Experience',
                  value: '10 yrs',
                  icon: Icons.timeline,
                  theme: theme,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  title: 'Rating',
                  value: '4.8',
                  icon: Icons.star_outline,
                  theme: theme,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  title: 'Reviews',
                  value: '120',
                  icon: Icons.rate_review_outlined,
                  theme: theme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool enabled,
    required IconData icon,
    String? Function(String?)? validator,
    String? helperText,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.primary,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}