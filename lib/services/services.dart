import 'package:chat_gpt/constants/constants.dart';
import 'package:chat_gpt/widgets/drop_down.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      backgroundColor: scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: TextWidget(
                label: "Chosen Model:",
                fontSize: 14,
              )),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: DropDownWidget(),
                flex: 2,
              )
            ],
          ),
        );
      },
    );
  }
}
