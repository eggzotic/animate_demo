import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  /// Whether the animation is in progress
  bool get isAnimating => _isAnimating;
  bool _isAnimating = false;

  /// Whether the animation should start playing forward
  ///
  /// - false means play in reverse
  bool get goForward => _goForward;
  bool _goForward = true;
  //
  // To facilitate user-control of the minimum Scale value
  double _minScale = 0.1;
  double get minScale => _minScale;
  final minMinScale = 0.0;
  final maxMinScale = 0.1;

  /// Facilitates user-control of the minimum Scale value
  void setMinScale(double scale) {
    if (scale >= minMinScale && scale <= maxMinScale) {
      _minScale = scale;
    }
    notifyListeners();
  }

  /// (Re-)start the animation
  void begin() {
    _goForward = !_goForward;
    _isAnimating = true;
    notifyListeners();
  }

  /// Update the current state of animation-in-progress
  void animating(bool status) {
    // notify only if this has changed
    final notify = status != _isAnimating;
    _isAnimating = status;
    if (notify) notifyListeners();
  }
}
