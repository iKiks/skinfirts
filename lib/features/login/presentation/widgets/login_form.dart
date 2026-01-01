import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/login/presentation/widgets/login_primary_button.dart';

class LoginForm extends StatefulWidget {
  final void Function(String identifier, String password) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: ResponsiveSize.fontSize(14),
    );
    final supportStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w500,
      fontSize: ResponsiveSize.fontSize(12),
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email or Mobile Number', style: labelStyle),
          SizedBox(height: ResponsiveSize.height(8)),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: _fieldDecoration('example@example.com'),
            validator: (value) {
              final input = value?.trim() ?? '';
              if (input.isEmpty) {
                return 'Please enter your email or phone number';
              }
              final emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
              final sanitized = input.replaceAll(RegExp(r'\s+'), '');
              final phoneRegExp = RegExp(r'^[+]?[0-9]{8,15}$');
              if (!emailRegExp.hasMatch(input) &&
                  !phoneRegExp.hasMatch(sanitized)) {
                return 'Enter a valid email or phone number';
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
            textInputAction: TextInputAction.done,
            decoration: _fieldDecoration('••••••••••').copyWith(
              suffixIcon: IconButton(
                onPressed: _toggleObscure,
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondary,
                  size: ResponsiveSize.width(18),
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your password';
              }
              if (value.trim().length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: ResponsiveSize.height(10)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Forget Password', style: supportStyle),
            ),
          ),
          SizedBox(height: ResponsiveSize.height(24)),
          LoginPrimaryButton(label: 'Log In', onPressed: _handleSubmit),
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

  void _toggleObscure() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }
}
