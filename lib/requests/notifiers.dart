import 'package:flutter/widgets.dart';

class Notifier {
  final Map<String, ValueNotifier<bool>> _map = {};

  void addListener(String key, VoidCallback listener) {
    if (!_map.containsKey(key)) {
      _map[key] = ValueNotifier(false);
    }
    _map[key]!.addListener(listener);
  }

  void removeListeners(String key, VoidCallback listener) {
    _map[key]?.removeListener(listener);
  }

  void notifyListeners(String key) {
    if (_map.containsKey(key)) {
      _map[key]!.value = !_map[key]!.value;
    }
  }
}