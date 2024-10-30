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
        TextButton(
          onPressed: onDelete ?? () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          child: const Text(
            '삭제',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    if (signout) {
      buttons.add(
        TextButton(
          onPressed: onSignOut ?? () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          child: const Text('탈퇴',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      );
    }

    if (success) {
      buttons.add(
        TextButton(
          onPressed: onSuccess ?? () => Navigator.of(context).pop(),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          child: const Text('확인',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return AlertDialog(
      backgroundColor: const Color(0xff262626),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/img/Dominho.png', width: 70, height: 100),
              const SizedBox(width: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(), // Empty space on the left
                          Text(
                            "from 도민호",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                        width: 150,
                      ),
                      Row(
                        children: [
                          if (cancel)
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                ),
                              ),
                              child: const Text('취소',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          const Spacer(), // Pushes the buttons to the end
                          ...buttons,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
