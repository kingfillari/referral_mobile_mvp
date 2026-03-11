import 'package:http/http.dart' as http;

class NetworkChecker {

  static Future<bool> hasInternet() async {

    try {

      final response =
          await http.get(Uri.parse("https://www.google.com"));

      if (response.statusCode == 200) {

        return true;

      } else {

        return false;

      }

    } catch (e) {

      return false;

    }

  }

  static Future<bool> checkAPI(String url) async {

    try {

      final response = await http.get(Uri.parse(url));

      return response.statusCode == 200;

    } catch (e) {

      return false;

    }

  }

}