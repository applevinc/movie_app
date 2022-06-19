import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_app/src/core/constants/api_urls.dart';
import 'package:movie_app/src/models/failure.dart';

class RequestHelper {
  final http.Client client;

  RequestHelper({required this.client});

  Future<dynamic> getRequest({required String url}) async {
    var webUrl = APIUrls.baseURL + url;

    log(webUrl);

    try {
      final response = await http.get(Uri.parse(webUrl));

      if (response.statusCode < 200 || response.statusCode > 299) {
        var message = jsonDecode(response.body)['message'];
        log(message.toString());
        throw Failure(message.toString());
      }
      final decodedData = jsonDecode(response.body);
      log("payload response --" + json.encode(decodedData));
      return decodedData;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException catch (e) {
      log(e.message);
      throw Failure('Server error, try again later');
    } on FormatException {
      throw Failure('Server error, try again later');
    }
  }
}
