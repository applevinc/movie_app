import 'package:flutter/material.dart';

class AppText {
  AppText._();

  static TextStyle bold400(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle bold300(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w300,
        );
  }

  static TextStyle bold500(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
        );
  }

  static TextStyle bold700(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w700,
        );
  }

  static TextStyle bold900(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w900,
        );
  }
}
