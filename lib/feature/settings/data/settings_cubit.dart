import 'package:authenticator/shared/data/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  bool _requireBiometrics = false;
  bool _automaticallyCopyOtp = false;

  late SettingsRepository _settings;

  SettingsCubit() : super(SettingsInitial()) {
    _settings = GetIt.I<SettingsRepository>();
    _loadInitialSettings();
  }

  Future<void> _loadInitialSettings() async {
    _requireBiometrics = await _settings.useBiometrics();
    _automaticallyCopyOtp = await _settings.autoCopyOtp();

    emit(SettingsUpdate(
      requireBiometrics: _requireBiometrics,
      automaticallyCopyOtp: _automaticallyCopyOtp
    ));
  }

  void setRequireBiometrics(bool newValue) async {
    await _settings.setUseBiometrics(newValue);
    _requireBiometrics = newValue;
    emit(SettingsUpdate(
        requireBiometrics: _requireBiometrics,
        automaticallyCopyOtp: _automaticallyCopyOtp
    ));
  }

  void setAutomaticallyCopyOtp(bool newValue) async {
    await _settings.setAutoCopyOtp(newValue);
    _automaticallyCopyOtp = newValue;
    emit(SettingsUpdate(
        requireBiometrics: _requireBiometrics,
        automaticallyCopyOtp: _automaticallyCopyOtp
    ));
  }
}
