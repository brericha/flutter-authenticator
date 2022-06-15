import 'package:authenticator/feature/add_account/data/add_by_qr_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class AddByQRDialog extends StatefulWidget {
  const AddByQRDialog({Key? key}) : super(key: key);

  @override
  State<AddByQRDialog> createState() => _AddByQRDialogState();
}

class _AddByQRDialogState extends State<AddByQRDialog> {
  late AddByQRCubit cubit = AddByQRCubit();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (size >= 300) size = 300;

    return BlocProvider(
      create: (_) => cubit,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: BlocBuilder<AddByQRCubit, AddByQRState>(
          builder: (_, state) {
            if (state is AccountAddFailed) {
              return Camera(
                showFailedMessage: true,
                onCodeScanned: (code) {
                  cubit.parseQRCode(code);
                },
              );
            } else if (state is AccountAddSuccessful) {
              Navigator.of(context).pop(state.id);
              return Container();
            } else if (state is CameraPermissionGranted) {
              // Camera
              return Camera(
                onCodeScanned: (code) {
                  cubit.parseQRCode(code);
                },
              );
            } else if (state is CameraPermissionNotGranted) {
              // Ask for permission
              return RequestPermission(
                  onPressed: () => cubit.requestCameraPermission()
              );
            } else if (state is CameraPermissionDenied) {
              // Ask again
              return OpenPermissionSettings(
                  onPressed: () => cubit.openPermissionSettings()
              );
            } else {
              // No state yet
              cubit.checkCameraPermission();
              return const Text('Loading');
            }
          },
        )
      ),
    );
  }
}

class Camera extends StatelessWidget {
  final bool showFailedMessage;
  final Function(String) onCodeScanned;

  const Camera({required this.onCodeScanned, this.showFailedMessage = false,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (size > 300) size = 300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Align QR code with camera', style: TextStyle(fontSize: 24),),
        const SizedBox(height: 12,),
        (showFailedMessage)
            ? const Text('There was a problem parsing the QR code',
                style: TextStyle(color: Colors.red),)
            : Container(),
        Center(
          child: SizedBox(
            height: size,
            width: size,
            child: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue != null) {
                  onCodeScanned(barcode.rawValue!);
                }
              },
            ),
          ),
        )
      ],
    );
  }
}

class RequestPermission extends StatelessWidget {
  final VoidCallback onPressed;

  const RequestPermission({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Before scanning a QR code, please press the button below to allow access to your devices camera',
          textAlign: TextAlign.center,),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Allow Camera Permission'),
        )
      ],
    );
  }
}

class OpenPermissionSettings extends StatelessWidget {
  final VoidCallback onPressed;

  const OpenPermissionSettings({required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Camera permission is currently denied. Please press the button below to open Settings and allow the camera permission',
          textAlign: TextAlign.center,),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Open Permission Settings'),
        )
      ],
    );
  }
}
