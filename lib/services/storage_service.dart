import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// บันทึกค่า
  Future<String> write(String key, dynamic value) async {
    try {
      final docRef = await _firestore.collection(key).add(value);
      return docRef.id;
    } catch (e) {
      print('StorageService.write: $e');
      rethrow;
    }
  }

  /// อ่านค่า
  Future<List<Map<String, dynamic>>> read(String key, {String? uid}) async {
    try {
      if (uid != null) {
        final snapshot = await _firestore
            .collection(key)
            .where('uid', isEqualTo: uid)
            .get();
        return snapshot.docs.map((e) => e.data()).toList();
      } else {
        final snapshot = await _firestore.collection(key).get();
        return snapshot.docs.map((e) => e.data()).toList();
      }
    } catch (e) {
      print('StorageService.read: $e');
      return [];
    }
  }

  /// ลบค่าตาม document id
  Future<void> delete(String key, String docId) async {
    try {
      await _firestore.collection(key).doc(docId).delete();
    } catch (e) {
      print('StorageService.delete: $e');
    }
  }

  /// อัปเดตค่าตาม document id
  Future<void> update(String key, String docId, dynamic value) async {
    try {
      await _firestore.collection(key).doc(docId).update(value);
    } catch (e) {
      print('StorageService.update: $e');
    }
  }

}