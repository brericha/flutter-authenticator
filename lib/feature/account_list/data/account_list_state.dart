part of 'account_list_cubit.dart';

abstract class AccountListState extends Equatable {
  const AccountListState();
}

class AccountListInitial extends AccountListState {
  const AccountListInitial() : super();

  @override
  List<Object> get props => [];
}

class AccountListUpdated extends AccountListState {
  final List<Account> accounts;

  const AccountListUpdated(this.accounts) : super();

  @override
  List<Object> get props => [accounts];
}