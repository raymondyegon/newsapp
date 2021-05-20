import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:sizer/sizer.dart';

class AppStyles {
  // For selected bottom bar text
  static TextStyle textStyleSelected(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 11.5.sp,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).theme.gray800,
    );
  }

  // For unselected bottom bar text
  static TextStyle textStyleUnselected(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 11.5.sp,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).theme.gray800,
    );
  }
}
