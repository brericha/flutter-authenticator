import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  void delete(Account account) {
    GetIt.I<AccountRepository>().deleteAccount(account);
    emit(DeleteAccountComplete());
  }
}
