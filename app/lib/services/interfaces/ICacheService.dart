import 'dart:async';

abstract class ICacheService<T> {
  Map<String, StreamedObject<T>> _cache = Map();
}

class StreamedObject<T> {
  StreamController<List<T>> streamController = StreamController.broadcast();
  List<T> lastItem;
}
