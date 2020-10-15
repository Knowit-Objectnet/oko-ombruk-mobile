import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ombruk/services/interfaces/ISecureStorageService.dart';

class SecureStorageService implements ISecureStorageService {
  final storage = FlutterSecureStorage();

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<String> getValue({String key}) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> setValue({String key, String value}) async {
    await storage.write(key: key, value: value);
  }
}