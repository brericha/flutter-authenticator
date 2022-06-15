import 'package:authenticator/feature/settings/data/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (_) => SettingsCubit()
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            if (settingsState is SettingsUpdate) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settings', style: Theme.of(context).textTheme.headline3,),
                  const SizedBox(height: 12,),
                  SwitchListTile(
                    title: const Text('Automatically copy new OTP'),
                    secondary: const Icon(Icons.copy),
                    value: settingsState.automaticallyCopyOtp,
                    onChanged: (value) {
                      BlocProvider.of<SettingsCubit>(context).setAutomaticallyCopyOtp(value);
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}