import 'package:flutter/material.dart';
import 'package:skinfirts/core/theme/app_colors.dart';
import 'package:skinfirts/core/utils/responsiveness/app_responsiveness.dart';
import 'package:skinfirts/features/profile/presentation/widgets/profile_header.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  DateTime? _selectedDob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Doe');
    _phoneController = TextEditingController(text: '+123 567 89000');
    _emailController = TextEditingController(text: 'johndoe@example.com');
    _dobController = TextEditingController(text: 'DD / MM / YYYY');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile updated successfully'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        margin: EdgeInsets.only(
          left: ResponsiveSize.width(18),
          right: ResponsiveSize.width(18),
          bottom: ResponsiveSize.height(18),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.secondary.withOpacity(0.25),
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.textSecondary.withOpacity(0.6),
        fontSize: ResponsiveSize.fontSize(14),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveSize.width(18),
        vertical: ResponsiveSize.height(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        borderSide: BorderSide(color: AppColors.secondary.withOpacity(0.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveSize.width(16)),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveSize.height(8)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: ResponsiveSize.fontSize(14),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: ResponsiveSize.width(18),
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveSize.fontSize(20),
              ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ResponsiveSize.width(12)),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.primary,
                size: ResponsiveSize.width(20),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.width(28),
            vertical: ResponsiveSize.height(28),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfileHeader(
                    name: 'John Doe',
                    avatarImage:
                        const NetworkImage('https://i.pravatar.cc/240?img=12'),
                  ),
                ),
                SizedBox(height: ResponsiveSize.height(32)),
                _buildLabel('Full Name'),
                TextFormField(
                  controller: _nameController,
                  decoration: _fieldDecoration('John Doe'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveSize.height(20)),
                _buildLabel('Phone Number'),
                TextFormField(
                  controller: _phoneController,
                  decoration: _fieldDecoration('+123 567 89000'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final phone = value.replaceAll(RegExp(r'[^0-9+]'), '');
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveSize.height(20)),
                _buildLabel('Email'),
                TextFormField(
                  controller: _emailController,
                  decoration: _fieldDecoration('johndoe@example.com'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.[A-Za-z]{2,}$')
                        .hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ResponsiveSize.height(20)),
                _buildLabel('Date Of Birth'),
                TextFormField(
                  controller: _dobController,
                  decoration: _fieldDecoration('DD / MM / YYYY'),
                  readOnly: true,
                  onTap: _pickDate,
                ),
                SizedBox(height: ResponsiveSize.height(40)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ResponsiveSize.width(24)),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ResponsiveSize.height(14),
                      ),
                    ),
                    child: Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveSize.fontSize(15),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    final initial = _selectedDob ?? DateTime(1995, 1, 1);
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year - 10),
    );

    if (picked != null) {
      setState(() {
        _selectedDob = picked;
        final day = picked.day.toString().padLeft(2, '0');
        final month = picked.month.toString().padLeft(2, '0');
        final year = picked.year.toString().padLeft(4, '0');
        _dobController.text = '$day / $month / $year';
      });
    }
  }
}
