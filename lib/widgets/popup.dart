import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String content;
  final bool cancel;
  final bool delete;
  final bool signout;
  final bool success;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;
  final VoidCallback? onSignOut;
  final VoidCallback? onSuccess;

  const PopupDialog({
    super.key,
    required this.content,
    required this.cancel,
    required this.delete,
    required this.signout,
    required this.success,
    this.onCancel,
    this.onDelete,
    this.onSignOut,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which button to display based on the flags
    List<Widget> buttons = [];
    if (delete) {
      buttons.add(
        Button(
          const Color.fromARGB(255, 255, 61, 47),
          Colors.black,
          '삭제',
          () => onDelete != null ? onDelete!() : Navigator.of(context).pop(),
        ).button(),
      );
    }
    if (signout) {
      buttons.add(
        Button(
          const Color.fromARGB(255, 255, 61, 47),
          Colors.black,
          '탈퇴',
          () => onSignOut != null ? onSignOut!() : Navigator.of(context).pop(),
        ).button(),
      );
    }
    if (success) {
      buttons.add(
        Button(
          Colors.black,
          Colors.white,
          '확인',
          () => onSuccess != null ? onSuccess!() : Navigator.of(context).pop(),
        ).button(),
      );
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      elevation: 10.0,
      content: Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 30, 0),
        decoration: const BoxDecoration(
            color: Color(0xff262626),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        height: 180,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset('assets/img/Dominho.png', width: 90, height: 120),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.shrink(), // Empty space on the left
                      Text(
                        "from 도민호",
                        style: TextStyle(color: Color(0xffBDBDBD)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      if (cancel)
                        Button(Colors.black, Colors.white, '취소',
                            () => Navigator.of(context).pop()).button(),

                      const Spacer(), // Pushes the buttons to the end
                      ...buttons,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context,
    String content,
    bool cancel,
    bool delete,
    bool signout,
    bool success, {
    VoidCallback? onCancel,
    VoidCallback? onDelete,
    VoidCallback? onSignOut,
    VoidCallback? onSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopupDialog(
          content: content,
          cancel: cancel,
          delete: delete,
          signout: signout,
          success: success,
          onCancel: onCancel,
          onDelete: onDelete,
          onSignOut: onSignOut,
          onSuccess: onSuccess,
        );
      },
    );
  }
}
