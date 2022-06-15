import 'package:authenticator/feature/view_account/data/otp_generator.dart';
import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'view_account_state.dart';

class ViewAccountCubit extends Cubit<ViewAccountState> {
  ViewAccountCubit() : super(ViewAccountInitial());

  late Account account;

  void loadAccount(int id) async {
    final maybeAccount = await GetIt.I<AccountRepository>().getAccount(id);
    if (maybeAccount == null) {
      emit(AccountLoadError());
    } else {
      account = maybeAccount;
      emit(AccountLoaded(account));

      // Update Account.lastUsed
      account.lastUsed = DateTime.now();
      GetIt.I<AccountRepository>().updateAccount(account);
    }
  }
}
