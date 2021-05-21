import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:sizer/sizer.dart';

class AppStyles {
  // For selected bottom bar text
  static TextStyle textStyleSelected(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).theme.gray800,
    );
  }

  // For unselected bottom bar text
  static TextStyle textStyleUnselected(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).theme.gray800,
    );
  }

  // For title in selected page
  static TextStyle textStyleTitleTop() {
    return GoogleFonts.ibmPlexSans(
      color: Colors.white,
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w600,
    );
  }

  // For not-found text while articles is empty
  static TextStyle textStyleNoArticles(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 13.0.sp,
      color: StateContainer.of(context).theme.gray800,
      fontWeight: FontWeight.w600,
    );
  }

  // For article feed title
  static TextStyle textStyleFeedTitle(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      fontSize: 12.5.sp,
      color: StateContainer.of(context).theme.gray800,
      fontWeight: FontWeight.w600,
    );
  }

  // For article feed date
  static TextStyle textStyleFeedDate(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      color: StateContainer.of(context).theme.gray500,
      fontSize: 10.5.sp,
      fontWeight: FontWeight.w400,
    );
  }

  // For page description
  static TextStyle textStylePageDescription(BuildContext context) {
    return GoogleFonts.ibmPlexSans(
      color: StateContainer.of(context).theme.gray800,
      fontSize: 15.0.sp,
      fontWeight: FontWeight.w700,
    );
  }
}
