part of 'add_by_qr_cubit.dart';

abstract class AddByQRState extends Equatable {
  const AddByQRState();
}

class AddByQRInitial extends AddByQRState {
  @override
  List<Object> get props => [];
}

class CameraPermissionNotGranted extends AddByQRState {
  @override
  List<Object> get props => [];
}

class CameraPermissionGranted extends AddByQRState {
  @override
  List<Object> get props => [];
}

/// Differs from CameraPermissionNotGranted because this state is emitted
/// after a permission request fails, rather than the permission not being
/// granted from the initial request
class CameraPermissionDenied extends AddByQRState {
  @override
  List<Object> get props => [];
}

class AccountAddSuccessful extends AddByQRState {
  final int id;

  const AccountAddSuccessful(this.id);

  @override
  List<Object> get props => [id];
}

class AccountAddFailed extends AddByQRState {
  final String message;

  const AccountAddFailed(this.message);

  @override
  List<Object> get props => [message];
}