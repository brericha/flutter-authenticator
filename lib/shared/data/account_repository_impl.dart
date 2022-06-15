import 'package:authenticator/objectbox.g.dart';
import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';

class AccountRepositoryImpl extends AccountRepository {
  final Box<Account> _accountBox;

  AccountRepositoryImpl(this._accountBox);

  @override
  Future<Account?> getAccount(int id) async {
    final query = _accountBox.query(Account_.id.equals(id)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  @override
  Future<List<Account>> getAllAccounts(OrderType orderType) async {

    final query = _accountQueryBuilder(orderType).build();
    final results = query.find();

    query.close();
    return results;
  }

  @override
  Stream<List<Account>> streamAllAccounts(OrderType orderType) async* {
    final builder = _accountQueryBuilder(orderType);
    final query = builder.watch(triggerImmediately: true);
    await for (final q in query) {
      yield q.find();
    }
  }

  @override
  Future<int> addAccount(Account account) async =>
      _accountBox.put(account, mode: PutMode.insert);

  @override
  Future<int> updateAccount(Account account) async =>
      _accountBox.put(account, mode: PutMode.update);

  @override
  Future<bool> deleteAccount(Account account) async =>
      _accountBox.remove(account.id);

  /// This builder will be needed for both the Future getAllAccounts
  /// and the Stream streamAllAccounts
  QueryBuilder<Account> _accountQueryBuilder(OrderType orderType) {
    final builder = _accountBox.query();

    switch (orderType) {
      case OrderType.newest:
        builder.order(Account_.added, flags: Order.descending);
        break;
      case OrderType.lastUsed:
        builder.order(Account_.lastUsed, flags: Order.descending);
        break;
      default:
        builder.order(Account_.title);
        break;
    }

    return builder;
  }
}