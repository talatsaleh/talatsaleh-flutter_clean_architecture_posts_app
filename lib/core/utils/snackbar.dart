import 'package:flutter/material.dart';

class SnackBarWidget {
  SnackBar _customSnackBar(String message, bool isError) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
  }

  SnackBarWidget.snackBarSuccess({
    required String message,
    required BuildContext ctx,
  }) {
    ScaffoldMessenger.of(ctx).showSnackBar(_customSnackBar(message, false));
  }

  SnackBarWidget.snackBarFailure({
    required String message,
    required BuildContext ctx,
  }) {
    ScaffoldMessenger.of(ctx).showSnackBar(_customSnackBar(message, true));
  }
}
