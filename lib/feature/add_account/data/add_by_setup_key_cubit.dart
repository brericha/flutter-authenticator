import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'add_by_setup_key_state.dart';

class AddBySetupKeyCubit extends Cubit<AddBySetupKeyState> {
  AddBySetupKeyCubit() : super(AddBySetupKeyInitial());

  void onSubmit(String title, String secret) async {
    final account = Account(
        title: title,
        secret: secret,
        added: DateTime.now(),
        lastUsed: DateTime.now()
    );

    final id = await GetIt.I<AccountRepository>().addAccount(account);
    emit(AccountAddSuccessful(id));
  }
}
