import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  final CollectionReference storageCollection = FirebaseFirestore.instance.collection('storage');

  // Read string data
  Future<String?> read(String key) async {
    final doc = await storageCollection.doc(key).get();
    if (doc.exists && doc.data() != null) {
      return (doc.data() as Map<String, dynamic>)['value'] as String?;
    }
    return null;
  }

  // Write string data
  Future<bool> write(String key, String value) async {
    try {
      await storageCollection.doc(key).set({'value': value});
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete data
  Future<bool> delete(String key) async {
    try {
      await storageCollection.doc(key).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Check if key exists
  Future<bool> containsKey(String key) async {
    final doc = await storageCollection.doc(key).get();
    return doc.exists;
  }

  // Clear all data
  Future<bool> clear() async {
    try {
      final snapshot = await storageCollection.get();
      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}