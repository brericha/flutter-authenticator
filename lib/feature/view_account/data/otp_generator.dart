import 'dart:async';

import 'package:otp/otp.dart';

class OtpGenerator {
  final otpCodeController = StreamController<String>();
  final secondsRemainingController = StreamController<int>();

  String secret;
  Timer? _secondsRemainingTimer;
  bool _firstLoop = true;

  OtpGenerator(this.secret) {
    _loopTimer();
  }

  void dispose() {
    _secondsRemainingTimer?.cancel();
    otpCodeController.close();
    secondsRemainingController.close();
  }

  void _loopTimer() {
    _secondsRemainingTimer?.cancel();
    otpCodeController.add(generateOtp());
    _updateSecondsRemaining(DateTime.now().second);

    _secondsRemainingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final currentSecond = now.second;

      _updateSecondsRemaining(currentSecond);

      if (currentSecond == 0 || currentSecond == 30 || _firstLoop) {
        _firstLoop = false;
        otpCodeController.add(generateOtp());
      }
    });
  }

  void _updateSecondsRemaining(int currentSecond) {
    final int secondsRemaining;
    if (currentSecond > 30) {
      secondsRemaining = 60 - currentSecond;
    } else {
      secondsRemaining = 30 - currentSecond;
    }

    secondsRemainingController.add(secondsRemaining);
  }

  String generateOtp() => OTP.generateTOTPCodeString(
    secret,
    DateTime.now().millisecondsSinceEpoch,
    isGoogle: true,
    algorithm: Algorithm.SHA1
  );
}