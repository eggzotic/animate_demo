import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _clicks = 0;
  int get clicks => _clicks;
  //
  bool _animating = false;
  bool get animating => _animating;
  //
  bool _go = true;
  bool get go => _go;
  //
  // To facilitate user-control of the minimum Scale value
  double _minScale = 0.1;
  double get minScale => _minScale;
  final minMinScale = 0.0;
  final maxMinScale = 0.1;

  void setMinScale(double scale) {
    if (scale >= minMinScale && scale <= maxMinScale) {
      _minScale = scale;
    }
    notifyListeners();
  }

  void toggle() {
    if (!_go) _clicks += 1;
    _go = !_go;
    _animating = true;
    notifyListeners();
  }

  void update(bool status) {
    // notify only if this has changed
    final notify = status != _animating;
    _animating = status;
    if (notify) notifyListeners();
  }
}
