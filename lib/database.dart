import 'package:authenticator/objectbox.g.dart';
import 'package:authenticator/shared/domain/account.dart';

class Database {
  static final Database _instance = Database._internal();
  factory Database() => _instance;
  Database._internal();

  late Store _store;

  late Box<Account> _accountBox;
  Box<Account> get accountBox => _accountBox;

  Future<void> init() async {
    _store = await openStore();
    _accountBox = _store.box();
  }
}