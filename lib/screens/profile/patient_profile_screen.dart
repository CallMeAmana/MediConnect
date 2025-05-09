import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _phoneController = TextEditingController(text: ''); // Add phone to user model
    _addressController = TextEditingController(text: ''); // Add address to user model
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'My Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                if (_formKey.currentState!.validate()) {
                  // Save profile changes
                  setState(() => _isEditing = false);
                }
              } else {
                setState(() => _isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildProfileForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppTheme.primary.withOpacity(0.1),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: AppTheme.primary,
                ),
              ),
              if (_isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
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
          if (!_isEditing)
            Text(
              _nameController.text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ).animate().fade().slideY(begin: 0.2),
    );
  }

  Widget _buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
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
              enabled: false, // Email cannot be edited
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              enabled: _isEditing,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              enabled: _isEditing,
              icon: Icons.location_on_outlined,
              maxLines: 2,
            ),
          ].animate(interval: 100.ms).fade().slideX(),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool enabled,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.shade100,
      ),
    );
  }
}