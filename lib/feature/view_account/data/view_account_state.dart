part of 'view_account_cubit.dart';

abstract class ViewAccountState extends Equatable {
  const ViewAccountState();
}

class ViewAccountInitial extends ViewAccountState {
  @override
  List<Object> get props => [];
}

class AccountLoaded extends ViewAccountState {
  final Account account;

  const AccountLoaded(this.account);

  @override
  List<Object> get props => [account];
}

class AccountLoadError extends ViewAccountState {
  @override
  List<Object> get props => [];
}