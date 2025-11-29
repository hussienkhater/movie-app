import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_colors.dart';

abstract class AppDialog {
  static void showLoadingDialog(BuildContext context,
      {String message = "Loading..."}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15),
              Text(
                message,
                style: Theme.of(context).textTheme.headlineMedium
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(
          "Error",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.red,
              ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () => hideDialog(context),
          ),
        ],
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
