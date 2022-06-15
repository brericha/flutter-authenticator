part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsUpdate extends SettingsState {
  final bool requireBiometrics;
  final bool automaticallyCopyOtp;

  const SettingsUpdate({required this.requireBiometrics,
    required this.automaticallyCopyOtp});

  @override
  List<Object> get props => [requireBiometrics, automaticallyCopyOtp];
}
