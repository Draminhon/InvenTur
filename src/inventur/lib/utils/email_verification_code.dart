import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class EmailVerificationCode extends ChangeNotifier{
  late int _timeRemaining;
  bool _stopCodeTimeout = false;

  setStopCodeTimeout(bool stop) {
    _stopCodeTimeout = stop;
  }

  int get timeRemaining => _timeRemaining;

  String generateVerificationCode() {
    List<int> code = List.generate(6, (index) => Random().nextInt(10));
    code.shuffle();
    return code.join();
  }

  void startCodeTimeout() {
    _timeRemaining = 1 * 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {

      if (_timeRemaining == 0 || _stopCodeTimeout) {
        timer.cancel();
        return;
      }
      _timeRemaining--;
      notifyListeners();
    });
  }
  
  void sendEmailVerificationCode() {}
}