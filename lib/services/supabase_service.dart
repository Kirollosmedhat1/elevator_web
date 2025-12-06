import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';

class SupabaseService {
  static SupabaseClient? _client;

  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    _client = Supabase.instance.client;
  }

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception(
        'Supabase not initialized. Call SupabaseService.initialize() first.',
      );
    }
    return _client!;
  }

  // Contact Form Methods
  Future<void> submitContactForm({
    required String name,
    required String phone,
    required String email,
    required String? governorate,
    required String city,
    required String? contactTime,
    required String message,
  }) async {
    try {
      await client.from('contact_submissions').insert({
        'name': name,
        'phone': phone,
        'email': email,
        'governorate': governorate,
        'city': city,
        'contact_time': contactTime,
        'message': message,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to submit contact form: $e');
    }
  }

  // Careers Form Methods
  Future<void> submitCareerApplication({
    required String name,
    required String phone,
    required String email,
    required String career,
    required String governorate,
    required String message,
    String? cvFileName,
    String? cvMimeType,
    Uint8List? cvBytes,
  }) async {
    try {
      String? cvUrl;

      // Upload CV file to Supabase Storage if provided
      if (cvBytes != null && cvFileName != null) {
        final fileExt = cvFileName.split('.').last;
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
        final filePath = 'career_applications/$fileName';

        await client.storage.from('cv_files').uploadBinary(filePath, cvBytes);

        cvUrl = client.storage.from('cv_files').getPublicUrl(filePath);
      }

      await client.from('career_applications').insert({
        'name': name,
        'phone': phone,
        'email': email,
        'career': career,
        'governorate': governorate,
        'message': message,
        'cv_file_name': cvFileName,
        'cv_file_url': cvUrl,
        'cv_mime_type': cvMimeType,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to submit career application: $e');
    }
  }

  // Product Methods (if you want to fetch products from Supabase)
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await client
          .from('products')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Gallery Methods
  Future<List<Map<String, dynamic>>> getGalleryItems() async {
    try {
      print('🔍 Attempting to fetch gallery items...');
      
      // First try without ordering to see if we can read at all
      final response = await client.from('gallery').select();
      
      print('✅ Raw response received: $response');
      print('✅ Response type: ${response.runtimeType}');
      
      // Convert to list and handle ordering
      final items = List<Map<String, dynamic>>.from(response);
      
      print('✅ Converted to list: ${items.length} items');
      if (items.isNotEmpty) {
        print('✅ First item structure: ${items.first}');
        print('✅ First item keys: ${items.first.keys.toList()}');
      }
      
      // Try to sort by created_at if it exists, otherwise by id
      items.sort((a, b) {
        if (a.containsKey('created_at') && b.containsKey('created_at')) {
          final aDate = a['created_at'];
          final bDate = b['created_at'];
          if (aDate != null && bDate != null) {
            return bDate.toString().compareTo(aDate.toString());
          }
        }
        // Fallback to id comparison
        final aId = a['id']?.toString() ?? '';
        final bId = b['id']?.toString() ?? '';
        return bId.compareTo(aId);
      });
      
      print('✅ Returning ${items.length} items');
      return items;
    } catch (e, stackTrace) {
      print('❌ Error fetching gallery items: $e');
      print('❌ Stack trace: $stackTrace');
      throw Exception('Failed to fetch gallery items: $e');
    }
  }
}
