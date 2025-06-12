import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  StorageService._();
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final Uuid _uuid = const Uuid();

  /// Uploads a file to Firebase Storage and returns its public download URL.
  ///
  /// The [folder] parameter lets you organise uploads (e.g. `users`, `pets`, `posts`).
  /// When no [fileName] is supplied a random UUID is used to avoid collisions.
  static Future<String?> uploadFile({
    required File file,
    required String folder,
    String? fileName,
  }) async {
    try {
      final String ext = file.path.split('.').last;
      final String name = fileName ?? _uuid.v4();
      final Reference ref = _storage.ref().child('$folder/$name.$ext');

      final UploadTask task = ref.putFile(file);
      await task;
      final String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      // ignore: avoid_print
      print('Storage upload error: $e');
      return null;
    }
  }

  /// Optionally: delete a file by its storage [url].
  static Future<void> deleteByUrl(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      // ignore: avoid_print
      print('Storage delete error: $e');
    }
  }
}
