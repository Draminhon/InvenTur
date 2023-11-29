import 'dart:math';

class EmailVerificationCodeGenerator {
  String generate() {
    List<int> code = List.generate(6, (index) => Random().nextInt(10));
    code.shuffle();
    return code.join();
  }
}