import 'package:authenticator/feature/delete_account/data/delete_account_cubit.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountDialog extends StatefulWidget {
  final Account account;

  const DeleteAccountDialog(this.account, {Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final cubit = DeleteAccountCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<DeleteAccountCubit, DeleteAccountState>(
          builder: (_, state) {
            if (state is DeleteAccountComplete) {
              Navigator.of(context).pop();
              return Container();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Delete this account? This cannot be undone. Make sure to disable 2FA from the accounts settings before continuing.'),
                  MaterialButton(
                    onPressed: () => cubit.delete(widget.account),
                    color: Colors.red,
                    child: const Text('Delete this account'),
                  )
                ],
              );
            }
          }
        ),
      )
    );
  }
}
