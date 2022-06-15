import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:authenticator/util/otp_uri.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

part 'add_by_qr_state.dart';

class AddByQRCubit extends Cubit<AddByQRState> {
  final log = Logger('AddByQRCubit');

  AddByQRCubit() : super(AddByQRInitial());

  void checkCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      emit(CameraPermissionNotGranted());
    } else {
      emit(CameraPermissionGranted());
    }
  }

  void requestCameraPermission() async {
    final isGranted = await Permission.camera.request().isGranted;
    if (isGranted) {
      emit(CameraPermissionGranted());
    } else {
      emit(CameraPermissionDenied());
    }
  }

  void openPermissionSettings() async {
    await openAppSettings();
    checkCameraPermission();
  }

  void parseQRCode(String code) async {
    try {
      final otpData = OtpUri(code);
      final account = Account(
          title: otpData.issuer ?? 'New OTP Account',
          secret: otpData.secret,
          added: DateTime.now(),
          lastUsed: DateTime.now()
      );

      int id = await GetIt.I<AccountRepository>().addAccount(account);
      emit(AccountAddSuccessful(id));
    } on OtpUriError catch (e) {
      log.warning(e.message);
      emit(const AccountAddFailed('Invalid OTP QR code'));
    }
  }
}
