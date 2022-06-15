import 'package:authenticator/shared/data/account_repository.dart';

abstract class SettingsRepository {
  final String keyAutoCopyOtp = 'autoCopyOtp';
  final String keyUseBiometrics = 'useBiometrics';
  final String keyOrderType = 'orderType';

  Future<bool> autoCopyOtp();
  Future<void> setAutoCopyOtp(bool value);

  Future<bool> useBiometrics();
  Future<void> setUseBiometrics(bool value);

  Future<OrderType> orderType();
  Future<void> setOrderType(OrderType orderType);
}