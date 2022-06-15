import 'package:authenticator/app_themes.dart';
import 'package:authenticator/feature/account_list/data/account_list_cubit.dart';
import 'package:authenticator/feature/add_account/ui/add_by_qr_dialog.dart';
import 'package:authenticator/feature/add_account/ui/add_by_setup_key_dialog.dart';
import 'package:authenticator/feature/delete_account/ui/delete_account_dialog.dart';
import 'package:authenticator/feature/settings/ui/settings_dialog.dart';
import 'package:authenticator/feature/view_account/ui/view_account_dialog.dart';
import 'package:authenticator/shared/data/account_repository.dart';
import 'package:authenticator/shared/domain/account.dart';
import 'package:authenticator/util/bottom_sheet.dart';
import 'package:authenticator/util/color_generator.dart';
import 'package:authenticator/widget/scroll_to_hide_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({Key? key}) : super(key: key);

  @override
  State<AccountListPage> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return BlocProvider(
      create: (_) => AccountListCubit(),
      child: BlocBuilder<AccountListCubit, AccountListState>(
        builder: (context, accountState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('EasyAuth', style: TextStyle(color: customColors.onAppBar),),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                PopupMenuButton(
                  icon: Icon(Icons.sort, color: customColors.onAppBar,),
                  onSelected: (value) {
                    if (value != null && value is OrderType) {
                      BlocProvider.of<AccountListCubit>(context).setOrderType(value);
                    }
                  },
                  itemBuilder: (_) {
                    return const [
                      PopupMenuItem(
                        value: OrderType.alphabetical,
                        child: Text('Title'),
                      ),
                      PopupMenuItem(
                        value: OrderType.newest,
                        child: Text('Newest'),
                      ),
                      PopupMenuItem(
                        value: OrderType.lastUsed,
                        child: Text('Last Used'),
                      ),
                    ];
                  },
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: customColors.onAppBar,),
                  onSelected: (value) {
                    if (value == 'settings') {
                      BottomSheetHelper.show(context, const SettingsDialog());
                    }
                  },
                  itemBuilder: (_) {
                    return [
                      const PopupMenuItem(
                        value: 'settings',
                        child: Text('Settings'),
                      )
                    ];
                  },
                )
              ],
            ),
            body: BlocBuilder<AccountListCubit, AccountListState>(
              builder: (_, accountState) {
                if (accountState is AccountListUpdated) {
                  List<Account> accounts = accountState.accounts;

                  if (accounts.isEmpty) {
                    return const Center(
                      child: Text('Tap a button below to add your first 2FA account'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 1.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20
                        ),
                        controller: _controller,
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          return AccountCard(accounts[index],
                            onTap: () {
                              BottomSheetHelper.show(context, ViewAccountDialog(accounts[index].id));
                            },
                            onLongPress: () {
                              BottomSheetHelper.show(context, DeleteAccountDialog(accounts[index]));
                            },
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Tap a button below to add your first 2FA account'),
                  );
                }
              },
            ),
            bottomNavigationBar: ScrollToHideWidget(
                controller: _controller,
                height: 48, // ScrollToHideWidget:height and AddButtons:height should be the same
                child: AddButtons(
                  height: 48,
                  addQR: () {
                    BottomSheetHelper.show(context, const AddByQRDialog())
                        .then((newId) {
                      if (newId != null) {
                        BottomSheetHelper.show(context, ViewAccountDialog(newId));
                      }
                    });
                  },
                  addText: () {
                    BottomSheetHelper.show(context, const AddBySetupKeyDialog())
                        .then((newId) {
                      if (newId != null) {
                        BottomSheetHelper.show(context, ViewAccountDialog(newId));
                      }
                    });
                  },
                )
            ),
          );
        },
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AccountCard(this.account, {required this.onTap,
    required this.onLongPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final cardColors = ColorGenerator.getColor(account.title);
    final Color color;
    if (isDarkMode) {
      color = cardColors.cardDarkBackground;
    } else {
      color = cardColors.cardBackground;
    }

    return Card(
      color: color,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Center(
            child: AutoSizeText(account.title,
              style: const TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        )
      ),
    );
  }
}

class CardIcon extends StatelessWidget {
  final String title;

  const CardIcon(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorGenerator.getColor(title).iconBackground,
      child: Center(
        child: Text(title.substring(0, 1), style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}


class AddButtons extends StatelessWidget {
  final VoidCallback addQR;
  final VoidCallback addText;
  final double height;

  const AddButtons({required this.addQR, required this.addText,
    this.height = 64, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 40,
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextButton(
                onPressed: addQR,
                child: Text('Add with QR Code', style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color
                ),),
              ),
            ),
            Expanded(
                child: TextButton(
                  onPressed: addText,
                  child: Text('Add with Setup Key', style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color
                  ),),
                )
            ),
          ],
        ),
      ),
    );
  }
}
