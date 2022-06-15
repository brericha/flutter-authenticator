import 'package:authenticator/feature/view_account/data/otp_generator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final String secret;

  late OtpGenerator generator;

  String? otp;
  int? second;

  OtpCubit(this.secret) : super(OtpInitial()) {
    generator = OtpGenerator(secret);
    generator.otpCodeController.stream.listen((newOtp) {
      otp = newOtp;
      if (second != null) {
        emit(OtpUpdate(newOtp, second!));
      }
    });
    generator.secondsRemainingController.stream.listen((newSecond) {
      second = newSecond;
      if (otp != null) {
        emit(OtpUpdate(otp!, newSecond));
      }
    });
  }

  void dispose() {
    generator.dispose();
  }
}
