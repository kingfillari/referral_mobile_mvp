import 'package:flutter/material.dart';

class Helpers {

  static void showSuccess(BuildContext context, String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );

  }

  static void showError(BuildContext context, String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );

  }

  static void showInfo(BuildContext context, String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );

  }

  static Future<bool?> confirmDialog(
      BuildContext context,
      String title,
      String message) {

    return showDialog<bool>(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: Text(title),

          content: Text(message),

          actions: [

            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),

            ElevatedButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )

          ],

        );

      },

    );

  }

  static String capitalize(String text) {

    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1);

  }

  static String formatPhone(String phone) {

    if (phone.startsWith("+")) return phone;

    return "+$phone";

  }

  static String truncate(String text, int length) {

    if (text.length <= length) return text;

    return "${text.substring(0, length)}...";

  }

  static bool isNumeric(String s) {

    return double.tryParse(s) != null;

  }

}