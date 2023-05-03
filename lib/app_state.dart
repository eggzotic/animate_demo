import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _clicks = 0;
  int get clicks => _clicks;
  bool _started = false;
  bool get animating => _started;
  bool _go = true;
  bool get start => _go;

  void toggle() {
    if (!_go) _clicks += 1;
    _go = !_go;
    _started = true;
    notifyListeners();
  }

  void update(bool status) {
    bool notify = false;
    if (status != _started) {
      notify = true;
    }
    _started = status;
    if (notify) notifyListeners();
  }
}
