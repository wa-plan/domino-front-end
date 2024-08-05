import 'package:flutter/material.dart';

class PopupDialog extends StatelessWidget {
  final String content;
  final bool cancel;
  final bool close;
  final bool delete;
  final bool signout;
  final VoidCallback? onCancel;
  final VoidCallback? onClose;
  final VoidCallback? onDelete;
  final VoidCallback? onSignOut;

  const PopupDialog({
    super.key,
    required this.content,
    required this.cancel,
    required this.close,
    required this.delete,
    required this.signout,
    this.onCancel,
    this.onClose,
    this.onDelete,
    this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which button to display based on the flags
    List<Widget> buttons = [];
    if (close) {
      buttons.add(
        TextButton(
          onPressed: onClose,
          // ?? () => Navigator.of(context).pop(),
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
          child: const Text('닫기', style: TextStyle(color: Colors.white)),
        ),
      );
    }
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
                              onPressed:
                                  onCancel ?? () => Navigator.of(context).pop(),
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
    bool close,
    bool delete,
    bool signout, {
    VoidCallback? onCancel,
    VoidCallback? onClose,
    VoidCallback? onDelete,
    VoidCallback? onSignOut,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PopupDialog(
          content: content,
          cancel: cancel,
          close: close,
          delete: delete,
          signout: signout,
          onCancel: onCancel,
          onClose: onClose,
          onDelete: onDelete,
          onSignOut: onSignOut,
        );
      },
    );
  }
}
