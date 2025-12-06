import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/services/supabase_service.dart';

class Careers extends StatefulWidget {
  const Careers({super.key});

  @override
  State<Careers> createState() => _CareersState();
}

class _CareersState extends State<Careers> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? _selectedCareer;
  String? _selectedGovernorate;
  PlatformFile? _cvFile;

  final List<String> _careers = <String>[
    'sales',
    'installation_technician',
    'maintenance_engineer',
    'project_manager',
    'customer_support',
    'other',
  ];

  final List<String> _governorates = <String>[
    'cairo',
    'giza',
    'alexandria',
    'dakahlia',
    'sharqia',
    'qalyubia',
    'other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickCv() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _cvFile = result.files.first;
      });
    }
  }

  Future<void> _submit() async {
    final FormState? currentState = _formKey.currentState;
    if (currentState == null) return;
    if (!currentState.validate()) return;

    if (_cvFile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('please_upload_cv'.tr)));
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Submit to Supabase
      await SupabaseService().submitCareerApplication(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        career: _selectedCareer!,
        governorate: _selectedGovernorate!,
        message: _messageController.text.trim(),
        cvFileName: _cvFile?.name,
        cvMimeType: _cvFile?.extension,
        cvBytes: _cvFile?.bytes,
      );

      // Close loading indicator
      Navigator.of(context).pop();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('application_submitted'.tr),
          backgroundColor: Colors.green,
        ),
      );

      // Clear form
    _formKey.currentState!.reset();
    setState(() {
      _selectedCareer = null;
      _selectedGovernorate = null;
      _cvFile = null;
    });
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageController.clear();
    } catch (e) {
      // Close loading indicator
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting application: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double maxFormWidth = 700;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        'careers_title'.tr,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'careers_subtitle'.tr,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(height: 24),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final bool isWide =
                                        constraints.maxWidth > 700;
                                    return Column(
                                      children: [
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
                                                SizedBox(height: 12),
                                                _buildTextField(
                                                  _phoneController,
                                                  'phone_number'.tr,
                                                  TextInputType.phone,
                                                ),
                                              ],
                                            ),
                                        SizedBox(height: 12),
                                        _buildTextField(
                                          _emailController,
                                          'email'.tr,
                                          TextInputType.emailAddress,
                                          validator: _emailValidator,
                                        ),
                                        SizedBox(height: 12),
                                        isWide
                                            ? Row(
                                              children: [
                                                Expanded(
                                                  child: _buildCareerDropdown(),
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child:
                                                      _buildGovernorateDropdown(),
                                                ),
                                              ],
                                            )
                                            : Column(
                                              children: [
                                                _buildCareerDropdown(),
                                                SizedBox(height: 12),
                                                _buildGovernorateDropdown(),
                                              ],
                                            ),
                                        SizedBox(height: 12),
                                        _buildMessageField(),
                                        SizedBox(height: 12),
                                        _buildCvPicker(),
                                        SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: _submit,
                                            child: Text('submit'.tr),
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
        border: OutlineInputBorder(),
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
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      validator: _requiredValidator,
    );
  }

  Widget _buildCareerDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCareer,
      items:
          _careers
              .map((c) => DropdownMenuItem<String>(value: c, child: Text(c.tr)))
              .toList(),
      onChanged: (v) => setState(() => _selectedCareer = v),
      decoration: InputDecoration(
        labelText: 'career'.tr,
        border: OutlineInputBorder(),
      ),
      validator:
          (v) => v == null || v.isEmpty ? 'please_select_career'.tr : null,
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
        border: OutlineInputBorder(),
      ),
      validator:
          (v) => v == null || v.isEmpty ? 'please_select_governorate'.tr : null,
    );
  }

  Widget _buildCvPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _pickCv,
          icon: Icon(Icons.upload_file),
          label: Text('upload_cv'.tr),
        ),
        if (_cvFile != null) ...[
          SizedBox(height: 8),
          Text(
            '${'selected_file'.tr} ${_cvFile!.name}',
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ],
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
