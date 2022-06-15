import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/data/settings_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'account_list_state.dart';

class AccountListCubit extends Cubit<AccountListState> {
  List<Account> _accountList = [];
  late Stream<List<Account>> _accountStream;

  OrderType _orderType = OrderType.alphabetical;

  AccountListCubit() : super(const AccountListInitial()) {
    _updateStream();

    // Restore previous OrderType
    GetIt.I<SettingsRepository>().orderType().then((orderType) {
      _orderType = orderType;
      _updateStream();
    });
  }

  void setOrderType(OrderType orderType) {
    _orderType = orderType;
    _updateStream();
    // Save the new OrderType selection so it can be used as the default next launch
    GetIt.I<SettingsRepository>().setOrderType(orderType);
  }

  void _updateStream() {
    _accountStream = GetIt.I<AccountRepository>().streamAllAccounts(_orderType);
    _accountStream.listen((newList) {
      _accountList = newList;
      emit(AccountListUpdated(_accountList));
    });
  }
}
