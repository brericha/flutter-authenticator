import 'package:flutter/material.dart';

class BottomSheetHelper {

  static Future<int?> show(BuildContext context, Widget child) async {
    return await showModalBottomSheet<int>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [child],
            ),
          );
        }
    );
  }
}