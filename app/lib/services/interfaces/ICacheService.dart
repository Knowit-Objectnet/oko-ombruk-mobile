import 'dart:async';

abstract class ICacheService<T> {
  Map<String, StreamedObject<T>> _cache = Map();

  void dispose() {
    _cache.values.forEach((object) => object.streamController.close());
  }
}

class StreamedObject<T> {
  StreamController<List<T>> streamController = StreamController.broadcast();
  List<T> lastItem;
}
