import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/data/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> autoCopyOtp() async {
    return _prefs.getBool(keyAutoCopyOtp) ?? false;
  }

  @override
  Future<void> setAutoCopyOtp(bool value) async {
    await _prefs.setBool(keyAutoCopyOtp, value);
  }

  @override
  Future<bool> useBiometrics() async {
    return _prefs.getBool(keyUseBiometrics) ?? false;
  }

  @override
  Future<void> setUseBiometrics(bool value) async {
    await _prefs.setBool(keyUseBiometrics, value);
  }

  static const String _orderTypeAlphabetical = 'alphabetical';
  static const String _orderTypeNewest = 'newest';
  static const String _orderTypeLastUsed = 'lastUsed';

  @override
  Future<OrderType> orderType() async {
    final typeString = _prefs.getString(keyOrderType) ?? _orderTypeAlphabetical;

    switch (typeString) {
      case _orderTypeNewest:
        return OrderType.newest;
      case _orderTypeLastUsed:
        return OrderType.lastUsed;
      default:
        return OrderType.alphabetical;
    }
  }

  @override
  Future<void> setOrderType(OrderType orderType) async {
    final String typeString;

    switch (orderType) {
      case OrderType.newest:
        typeString = _orderTypeNewest;
        break;
      case OrderType.lastUsed:
        typeString = _orderTypeLastUsed;
        break;
      default:
        typeString = _orderTypeAlphabetical;
        break;
    }

    await _prefs.setString(keyOrderType, typeString);
  }
}