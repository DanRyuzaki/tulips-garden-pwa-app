import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationPackage {
  static void showErrorToast(
      BuildContext context, String title, String message) {
    toastification.showCustom(
      context: context,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.bottomRight,
      builder: (BuildContext context, ToastificationItem holder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.red,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(message, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  static void showLoadingToast(
      BuildContext context, String title, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      title: Text(title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)),
      description: Text(message, style: const TextStyle(color: Colors.black)),
      alignment: Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 5),
      primaryColor: const Color(0xff562ea2),
      borderRadius: BorderRadius.circular(12.0),
      showProgressBar: true,
      dragToClose: true,
    );
  }
}
