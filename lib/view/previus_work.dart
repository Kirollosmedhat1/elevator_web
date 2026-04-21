import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:elevatorweb/widgets/page_name&photo.dart';
import 'package:elevatorweb/services/supabase_service.dart';
import 'package:get/get.dart';

class PreviusWork extends StatefulWidget {
  const PreviusWork({super.key});

  @override
  State<PreviusWork> createState() => _PreviusWorkState();
}

class _PreviusWorkState extends State<PreviusWork> {
  final SupabaseService _supabaseService = SupabaseService();
  List<Map<String, dynamic>> _previousWorkList = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPreviousWork();
  }

  Future<void> _fetchPreviousWork() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _supabaseService.getPreviousWork();
      setState(() {
        _previousWorkList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getLocalizedValue(Map<String, dynamic> item, String key) {
    final lang = Get.locale?.languageCode ?? 'en';
    final langKey = lang == 'ar' ? '${key}_ar' : '${key}_en';
    return item[langKey]?.toString() ?? item['${key}_en']?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final lang = Get.locale?.languageCode ?? 'en';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageNamePhoto(pagename: 'previous_work'.tr),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Table Container
            Container(
              padding: EdgeInsets.all(isMobile ? 16 : 40),
              child:
                  _isLoading
                      ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        ),
                      )
                      : _errorMessage != null
                      ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Text(
                                'Error loading data',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              Text(_errorMessage!),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _fetchPreviousWork,
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                      : _previousWorkList.isEmpty
                      ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            'No previous work records found',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                      : isMobile
                      ? _buildMobileTable()
                      : _buildDesktopTable(),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopTable() {
    final lang = Get.locale?.languageCode ?? 'en';

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
          dataRowColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.selected)
                ? Colors.grey[100]
                : Colors.white;
          }),
          columns: [
            DataColumn(
              label: Text(
                lang == 'ar' ? 'اسم الشركة' : 'Company Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                lang == 'ar' ? 'عنوان الشركة' : 'Company Address',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                lang == 'ar' ? 'اسم الخدمة' : 'Service Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                lang == 'ar' ? 'نوع الوحدة' : 'Unit Type',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                lang == 'ar' ? 'عدد الوحدات' : 'Units Count',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          rows:
              _previousWorkList.map((item) {
                return DataRow(
                  cells: [
                    DataCell(Text(_getLocalizedValue(item, 'company_name'))),
                    DataCell(
                      Text(
                        _getLocalizedValue(item, 'company_address'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DataCell(Text(_getLocalizedValue(item, 'service_name'))),
                    DataCell(Text(_getLocalizedValue(item, 'unit_type'))),
                    DataCell(
                      Center(
                        child: Text(item['units_count']?.toString() ?? '0'),
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildMobileTable() {
    final lang = Get.locale?.languageCode ?? 'en';

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _previousWorkList.length,
      itemBuilder: (context, index) {
        final item = _previousWorkList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMobileRow(
                lang == 'ar' ? 'اسم الشركة' : 'Company Name',
                _getLocalizedValue(item, 'company_name'),
              ),
              SizedBox(height: 8),
              _buildMobileRow(
                lang == 'ar' ? 'عنوان الشركة' : 'Company Address',
                _getLocalizedValue(item, 'company_address'),
              ),
              SizedBox(height: 8),
              _buildMobileRow(
                lang == 'ar' ? 'اسم الخدمة' : 'Service Name',
                _getLocalizedValue(item, 'service_name'),
              ),
              SizedBox(height: 8),
              _buildMobileRow(
                lang == 'ar' ? 'نوع الوحدة' : 'Unit Type',
                _getLocalizedValue(item, 'unit_type'),
              ),
              SizedBox(height: 8),
              _buildMobileRow(
                lang == 'ar' ? 'عدد الوحدات' : 'Units Count',
                item['units_count']?.toString() ?? '0',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(flex: 3, child: Text(value)),
      ],
    );
  }
}
