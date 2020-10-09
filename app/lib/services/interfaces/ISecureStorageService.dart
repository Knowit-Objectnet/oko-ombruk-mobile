abstract class ISecureStorageService {

  Future<String> getValue({String key});

  Future<void> setValue({String key, String value});

  Future<void> deleteAll();
}