abstract class ILocalStorageService {

  Future<String> getValue({String key});

  Future<void> setValue({String key, String value});

  Future<void> deleteAll();
}