import 'package:elevatorweb/widgets/page_name&photo.dart';
import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/services/supabase_service.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedGovernorate;
  String? _selectedContactTime;

  final List<String> _governorates = <String>[
    'cairo',
    'giza',
    'alexandria',
    'dakahlia',
    'sharqia',
    'qalyubia',
    'other',
  ];

  final List<String> _contactTimes = <String>[
    'morning',
    'afternoon',
    'evening',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    final FormState? currentState = _formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    setState(() => _isSubmitting = true);

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      debugPrint('Submitting contact form to Supabase...');

      // Submit to Supabase
      await SupabaseService().submitContactForm(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        governorate: _selectedGovernorate,
        city: _cityController.text.trim(),
        contactTime: _selectedContactTime,
        message: _messageController.text.trim(),
      );

      debugPrint('Contact form submitted successfully');

      // Close loading indicator
      if (mounted) Navigator.of(context).pop();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('application_submitted'.tr),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }

      // Clear form
      _formKey.currentState!.reset();
      setState(() {
        _selectedGovernorate = null;
        _selectedContactTime = null;
      });
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _cityController.clear();
      _messageController.clear();
    } catch (e) {
      debugPrint('Error submitting contact form: $e');

      // Close loading indicator
      if (mounted) Navigator.of(context).pop();

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'please_try_again'.tr}: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      } else {
        _isSubmitting = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxFormWidth = 800;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageNamePhoto(pagename: 'contact_us'.tr),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.06,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxFormWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'contact_us_now'.tr,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'contact_form_subtitle'.tr,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(height: 32),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final bool isWide =
                                        constraints.maxWidth > 600;
                                    return Column(
                                      children: [
                                        // Name and Phone Row
                                        isWide
                                            ? Row(
                                              children: [
                                                Expanded(
                                                  child: _buildTextField(
                                                    _nameController,
                                                    'name'.tr,
                                                    TextInputType.name,
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: _buildTextField(
                                                    _phoneController,
                                                    'phone_number'.tr,
                                                    TextInputType.phone,
                                                  ),
                                                ),
                                              ],
                                            )
                                            : Column(
                                              children: [
                                                _buildTextField(
                                                  _nameController,
                                                  'name'.tr,
                                                  TextInputType.name,
                                                ),
                                                SizedBox(height: 16),
                                                _buildTextField(
                                                  _phoneController,
                                                  'phone_number'.tr,
                                                  TextInputType.phone,
                                                ),
                                              ],
                                            ),
                                        SizedBox(height: 16),
                                        // Email Field
                                        _buildTextField(
                                          _emailController,
                                          'email'.tr,
                                          TextInputType.emailAddress,
                                          validator: _emailValidator,
                                        ),
                                        SizedBox(height: 16),
                                        // Governorate and City Row
                                        isWide
                                            ? Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      _buildGovernorateDropdown(),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: _buildTextField(
                                                    _cityController,
                                                    'city'.tr,
                                                    TextInputType.text,
                                                  ),
                                                ),
                                              ],
                                            )
                                            : Column(
                                              children: [
                                                _buildGovernorateDropdown(),
                                                SizedBox(height: 16),
                                                _buildTextField(
                                                  _cityController,
                                                  'city'.tr,
                                                  TextInputType.text,
                                                ),
                                              ],
                                            ),
                                        SizedBox(height: 16),
                                        // Preferred Contact Time
                                        _buildContactTimeDropdown(),
                                        SizedBox(height: 16),
                                        // Message Field
                                        _buildMessageField(),
                                        SizedBox(height: 24),
                                        // Submit Button
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: _isSubmitting ? null : _submit,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[700],
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 32,
                                                vertical: 12,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: _isSubmitting
                                                ? SizedBox(
                                                    width: 18,
                                                    height: 18,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    'confirm'.tr,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    TextInputType keyboardType, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: validator ?? _requiredValidator,
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'message'.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: _requiredValidator,
    );
  }

  Widget _buildGovernorateDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGovernorate,
      items:
          _governorates
              .map((g) => DropdownMenuItem<String>(value: g, child: Text(g.tr)))
              .toList(),
      onChanged: (v) => setState(() => _selectedGovernorate = v),
      decoration: InputDecoration(
        labelText: 'governorate'.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator:
          (v) => v == null || v.isEmpty ? 'please_select_governorate'.tr : null,
    );
  }

  Widget _buildContactTimeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedContactTime,
      items:
          _contactTimes
              .map((t) => DropdownMenuItem<String>(value: t, child: Text(t.tr)))
              .toList(),
      onChanged: (v) => setState(() => _selectedContactTime = v),
      decoration: InputDecoration(
        labelText: 'preferred_contact_time'.tr,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator:
          (v) =>
              v == null || v.isEmpty ? 'please_select_contact_time'.tr : null,
    );
  }

  String? _requiredValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'this_field_required'.tr;
    return null;
  }

  String? _emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'email_required'.tr;
    final String value = v.trim();
    final RegExp emailReg = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailReg.hasMatch(value)) return 'enter_valid_email'.tr;
    return null;
  }
}
