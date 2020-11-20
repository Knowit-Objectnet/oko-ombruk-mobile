import 'package:ombruk/models/CustomResponse.dart';

mixin UseCache<T> {
  List<dynamic> _cacheChangedCallbacks = List();

  void cacheChanged(
      CustomResponse response, Function(CustomResponse) _parseResult) {
    CustomResponse parsedResponse = _parseResult(response);
    _cacheChangedCallbacks.forEach((listener) => listener(parsedResponse));
  }

  void addOnChangedCallback<T>(dynamic callback) {
    _cacheChangedCallbacks.add(callback);
  }

  void removeOnChangedCallback(void Function(CustomResponse) callback) {
    _cacheChangedCallbacks.remove(callback);
  }
}
