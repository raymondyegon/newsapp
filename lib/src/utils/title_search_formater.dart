import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';

class TitleFormater {
  static Widget format({
    @required String title,
    @required BuildContext context,
    @required String searched,
  }) {
    return Text.rich(
      TextSpan(
        style: AppStyles.textStyleFeedTitle(context),
        children: title.split(' ').map(
          (String word) {
            return TextSpan(
              text: '$word ',
              style: word.toLowerCase() == searched.toLowerCase()
                  ? TextStyle(
                      color: StateContainer.of(context).theme.primary,
                    )
                  : TextStyle(),
            );
          },
        ).toList(),
      ),
    );
  }
}
