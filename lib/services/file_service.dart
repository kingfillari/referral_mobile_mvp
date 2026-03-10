import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

/// File service for upload/download of images or scans
class FileService {
  /// Upload a file to server
  Future<bool> uploadFile(String endpoint, File file) async {
    final request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  /// Download a file from server
  Future<File?> downloadFile(String url, String filename) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$filename');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
      return null;
    } catch (e) {
      print('File download error: $e');
      return null;
    }
  }

  /// Delete local file
  Future<void> deleteLocalFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    if (await file.exists()) {
      await file.delete();
    }
  }
}