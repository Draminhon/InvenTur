import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class EmailVerificationCode extends ChangeNotifier {
  late int _timeRemaining;
  late int _codeTimeout;
  bool _stopCodeTimeout = false;
  bool _startedTime = false;

  setCodeTimeout(int seconds) {
    _codeTimeout = seconds;
  }

  setStopCodeTimeout(bool stop) {
    _stopCodeTimeout = stop;
  }

  bool get startedTime => _startedTime;

  int get timeRemaining => _timeRemaining;

  String generateVerificationCode() {
    List<int> code = List.generate(6, (index) => Random().nextInt(10));
    code.shuffle();
    return code.join();
  }

  void startCodeTimeout() {
    _startedTime = true;
    _timeRemaining = _codeTimeout;
    Timer.periodic(const Duration(seconds: 1), (timer) {

      if (_timeRemaining == 0 || _stopCodeTimeout) {
        timer.cancel();
        _startedTime = false;
        return;
      }
      _timeRemaining--;
      notifyListeners();
    });
  }
  
  void sendEmailVerificationCode() {}
}

// MOVER PARA CONTROLLERS