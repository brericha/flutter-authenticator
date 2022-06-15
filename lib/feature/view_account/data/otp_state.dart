part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  const OtpState();
}

class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}

class OtpUpdate extends OtpState {
  final String otp;
  final int seconds;

  const OtpUpdate(this.otp, this.seconds);

  @override
  List<Object> get props => [otp, seconds];
}