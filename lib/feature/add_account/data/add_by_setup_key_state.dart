part of 'add_by_setup_key_cubit.dart';

abstract class AddBySetupKeyState extends Equatable {
  const AddBySetupKeyState();
}

class AddBySetupKeyInitial extends AddBySetupKeyState {
  @override
  List<Object> get props => [];
}

class AccountAddSuccessful extends AddBySetupKeyState {
  final int id;

  const AccountAddSuccessful(this.id);

  @override
  List<Object> get props => [id];
}
