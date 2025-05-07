import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mediconnect/providers/auth_provider.dart';
import 'package:mediconnect/utils/theme.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.sendPasswordRecovery(
      _emailController.text.trim(),
    );
    
    if (!mounted) return;
    
    setState(() {
      _isLoading = false;
      
      if (success) {
        _isSuccess = true;
      } else {
        _errorMessage = 'Email not found. Please check and try again.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        _isSuccess ? 'Email Sent' : 'Reset Password',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: _isSuccess
          ? _buildSuccessContent()
          : _buildFormContent(),
      actions: [
        if (!_isSuccess)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppTheme.lightColorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
        if (_isSuccess)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(
                color: AppTheme.lightColorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (!_isSuccess)
          ElevatedButton(
            onPressed: _isLoading ? null : _sendResetEmail,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(100, 40),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text('Send Email'),
          ),
      ],
    );
  }

  Widget _buildFormContent() {
    return SizedBox(
      width: double.maxFinite,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email and we\'ll send you instructions to reset your password.',
              style: TextStyle(
                color: AppTheme.lightColorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 16),
            
            if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppTheme.lightColorScheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.lightColorScheme.error.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                    color: AppTheme.lightColorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Email is required'),
                EmailValidator(errorText: 'Enter a valid email address'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: AppTheme.lightColorScheme.primary.withOpacity(0.1),
          radius: 40,
          child: Icon(
            Icons.check,
            size: 40,
            color: AppTheme.lightColorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'We\'ve sent password reset instructions to ${_emailController.text}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.lightColorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please check your email.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightColorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}