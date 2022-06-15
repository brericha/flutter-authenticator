import 'package:authenticator/shared/domain/account.dart';

enum OrderType {
  alphabetical,
  newest,
  lastUsed
}

abstract class AccountRepository {
  Future<List<Account>> getAllAccounts(OrderType orderType);
  Stream<List<Account>> streamAllAccounts(OrderType orderType);
  Future<Account?> getAccount(int id);
  Future<int> addAccount(Account account);
  Future<int> updateAccount(Account account);
  Future<bool> deleteAccount(Account account);
}