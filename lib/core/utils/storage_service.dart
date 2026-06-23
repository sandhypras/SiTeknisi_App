import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Exception thrown when storage operations fail
class StorageException implements Exception {
  const StorageException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Service for handling file uploads to Supabase Storage
class StorageService {
  StorageService(this._client);

  final SupabaseClient _client;

  /// Upload request photo to storage
  /// Returns the public URL of the uploaded file
  Future<String> uploadRequestPhoto({
    required Uint8List bytes,
    required String fileName,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        throw const StorageException('User not authenticated');
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = fileName.split('.').last.toLowerCase();
      final uniqueFileName = '$userId/$timestamp.$extension';

      if (kDebugMode) {
        print('\n📤 Uploading photo to storage...');
        print('  Bucket: request-photos');
        print('  Path: $uniqueFileName');
        print('  Size: ${bytes.length} bytes');
      }

      // Upload to storage
      await _client.storage
          .from('request-photos')
          .uploadBinary(
            uniqueFileName,
            bytes,
            fileOptions: FileOptions(
              contentType: _getContentType(extension),
              upsert: false,
            ),
          );

      // Get public URL
      final publicUrl = _client.storage
          .from('request-photos')
          .getPublicUrl(uniqueFileName);

      if (kDebugMode) {
        print('✅ Photo uploaded successfully');
        print('  URL: $publicUrl');
      }

      return publicUrl;
    } on StorageException catch (e) {
      if (kDebugMode) {
        print('❌ StorageException: ${e.message}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Upload error: $e');
      }
      throw StorageException('Failed to upload photo: $e');
    }
  }

  /// Upload technician document (KTP, profile photo)
  Future<String> uploadTechnicianDocument({
    required Uint8List bytes,
    required String fileName,
    required bool isProfilePhoto,
  }) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) {
        throw const StorageException('User not authenticated');
      }

      final bucket = isProfilePhoto ? 'avatars' : 'technician-documents';
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = fileName.split('.').last.toLowerCase();
      final uniqueFileName = '$userId/$timestamp.$extension';

      if (kDebugMode) {
        print('\n📤 Uploading document to storage...');
        print('  Bucket: $bucket');
        print('  Path: $uniqueFileName');
      }

      await _client.storage
          .from(bucket)
          .uploadBinary(
            uniqueFileName,
            bytes,
            fileOptions: FileOptions(
              contentType: _getContentType(extension),
              upsert: false,
            ),
          );

      final publicUrl = _client.storage
          .from(bucket)
          .getPublicUrl(uniqueFileName);

      if (kDebugMode) {
        print('✅ Document uploaded successfully');
      }

      return publicUrl;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Upload error: $e');
      }
      throw StorageException('Failed to upload document: $e');
    }
  }

  /// Delete file from storage
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await _client.storage.from(bucket).remove([path]);

      if (kDebugMode) {
        print('✅ File deleted from storage: $path');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Delete error: $e');
      }
      throw StorageException('Failed to delete file: $e');
    }
  }

  /// Get content type based on file extension
  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  /// Validate image file
  bool isValidImageSize(Uint8List bytes, {int maxSizeInMB = 5}) {
    final sizeInMB = bytes.length / (1024 * 1024);
    return sizeInMB <= maxSizeInMB;
  }

  /// Validate image extension
  bool isValidImageExtension(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension);
  }
}
