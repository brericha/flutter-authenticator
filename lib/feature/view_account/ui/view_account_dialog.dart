import 'dart:async';

import 'package:authenticator/feature/view_account/data/otp_cubit.dart';
import 'package:authenticator/feature/view_account/data/view_account_cubit.dart';
import 'package:authenticator/shared/data/settings_repository.dart';
import 'package:authenticator/util/color_generator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ViewAccountDialog extends StatefulWidget {
  final int id;

  const ViewAccountDialog(this.id, {Key? key}) : super(key: key);

  @override
  State<ViewAccountDialog> createState() => _ViewAccountDialogState();
}

class _ViewAccountDialogState extends State<ViewAccountDialog> {
  final accountCubit = ViewAccountCubit();
  OtpCubit? otpCubit;

  bool _showCopiedText = false;

  late final bool _autoCopyOtp;
  String _lastCopiedOtp = '';

  @override
  void initState() {
    super.initState();

    // Get whether to auto copy new OTP codes
    GetIt.I<SettingsRepository>().autoCopyOtp().then((value) => _autoCopyOtp = value);
  }

  @override
  void dispose() {
    otpCubit?.dispose();
    super.dispose();
  }

  void showCopiedText() {
    setState(() => _showCopiedText = true);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _showCopiedText = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => accountCubit,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<ViewAccountCubit, ViewAccountState>(
          builder: (_, state) {
            if (state is AccountLoaded) {
              final account = state.account;
              final progressColor = ColorGenerator.getColor(account.title).timerFill;

              otpCubit = OtpCubit(account.secret);
              return BlocProvider(
                create: (_) => otpCubit!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(state.account.title,
                        style: const TextStyle(fontSize: 52),
                        maxLines: 1
                    ),
                    BlocBuilder<OtpCubit, OtpState>(
                        builder: (_, state) {
                          if (state is OtpUpdate) {
                            // Auto copy new OTP if enabled
                            if (_autoCopyOtp && _lastCopiedOtp != state.otp) {
                              Clipboard.setData(ClipboardData(text: state.otp));
                              _lastCopiedOtp = state.otp;
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OtpText(state.otp,
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: state.otp));
                                      showCopiedText();
                                    }
                                ),
                                SecondsIndicator(state.seconds, progressColor),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }
                    ),
                    (_showCopiedText)
                        ? const Text('OTP code copied!')
                        : Container(),
                  ],
                ),
              );
            } else if (state is AccountLoadError) {
              Navigator.pop(context);
              return const Text('Account does not exist');
            } else {
              accountCubit.loadAccount(widget.id);
              return const Text('Loading');
            }
          },
        ),
      ),
    );
  }
}

class OtpText extends StatelessWidget {
  final String otp;
  final VoidCallback onTap;

  const OtpText(this.otp, {required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(otp,
        style: const TextStyle(fontSize: 48),
      ),
    );
  }
}

class SecondsIndicator extends StatelessWidget {
  final int seconds;
  final Color progressColor;

  const SecondsIndicator(this.seconds, this.progressColor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30,
      lineWidth: 8,
      progressColor: progressColor,
      percent: seconds / 30,
      center: Text(seconds.toString(), style: const TextStyle(fontSize: 20),),
    );
  }
}
