import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/signup/presentation/widgets/signup_primary_button.dart';
import 'package:skinfirts/features/signup/presentation/widgets/signup_terms_notice.dart';

class SignupForm extends StatefulWidget {
  final void Function(SignupFormData data) onSubmit;

  const SignupForm({super.key, required this.onSubmit});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: ResponsiveSize.fontSize(14),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Full name', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _fullNameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: _fieldDecoration('e.g. John Doe'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              if (value.trim().split(' ').length < 2) {
                return 'Enter your first and last name';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(18)),
          Text('Password', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            decoration: _fieldDecoration('••••••••••').copyWith(
              suffixIcon: IconButton(
                onPressed: _togglePassword,
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                  size: ResponsiveSize.width(18),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please create a password';
              }
              if (value.trim().length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(18)),
          Text('Email', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: _fieldDecoration('example@example.com'),
            validator: (value) {
              final input = value?.trim() ?? '';
              if (input.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              if (!emailRegExp.hasMatch(input)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(18)),
          Text('Mobile Number', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: _fieldDecoration('+123 456 7890'),
            validator: (value) {
              final input = value?.trim() ?? '';
              if (input.isEmpty) {
                return 'Please enter your mobile number';
              }
              final sanitized = input.replaceAll(RegExp(r'\s+'), '');
              final phoneRegExp = RegExp(r'^[+]?[0-9]{8,15}$');
              if (!phoneRegExp.hasMatch(sanitized)) {
                return 'Enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(18)),
          Text('Date Of Birth', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _dobController,
            keyboardType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            decoration: _fieldDecoration('DD / MM / YYYY'),
            validator: (value) {
              final input = value?.trim() ?? '';
              if (input.isEmpty) {
                return 'Please enter your date of birth';
              }
              final dobInput = input.replaceAll(' ', '');
              final dobRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
              if (!dobRegExp.hasMatch(dobInput)) {
                return 'Use the format DD / MM / YYYY';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(24)),
          const SignupTermsNotice(),
          SizedBox(height: ResponsiveSize.height(24)),
          SignupPrimaryButton(label: 'Sign Up', onPressed: _handleSubmit),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(18),
        vertical: ResponsiveSize.height(16),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        SignupFormData(
          fullName: _fullNameController.text.trim(),
          password: _passwordController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          dateOfBirth: _dobController.text.trim(),
        ),
      );
    }
  }
}

class SignupFormData {
  final String fullName;
  final String password;
  final String email;
  final String phone;
  final String dateOfBirth;

  const SignupFormData({
    required this.fullName,
    required this.password,
    required this.email,
    required this.phone,
    required this.dateOfBirth,
  });
}
