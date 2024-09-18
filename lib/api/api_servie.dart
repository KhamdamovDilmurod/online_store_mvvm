

import 'dart:async';

import 'package:dio/dio.dart';

import '../model/product_model.dart';

class ApiService {
  final dio = Dio();


  ApiService() {
    int time = 60000;

    dio.options = BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      connectTimeout: Duration(milliseconds: time),
      receiveTimeout: Duration(milliseconds: time),
      sendTimeout: Duration(milliseconds: time),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

  }


  String handleError(DioException error) {
    String errorDescription = '';
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorDescription = "Connection timed out";
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            errorDescription = "Bad request";
            break;
          case 401:
            errorDescription = "Unauthorized";
            break;
          case 403:
            errorDescription = "Forbidden";
            break;
          case 404:
            errorDescription = "Page not found";
            break;
          case 500:
            final errorData = error.response?.data;
            if (errorData is Map && errorData['detail'] != null) {
              errorDescription = "Invalid page";
            } else {
              errorDescription = "Internal server error";
            }
            break;
          default:
            errorDescription =
            "Received invalid status code: ${error.response?.statusCode}";
        }
        break;
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.unknown:
        errorDescription =
        "Connection to API server failed due to internet connection";
        break;
      default:
        errorDescription = "Unexpected error occurred";
    }
    return errorDescription;
  }


  Future<List<ProductModel>?> getProducts(
      StreamController<String> errorStream) async {
    try {
      final response = await dio.get("products/");


      if (response.statusCode == 200) {
        return (response.data as List<dynamic>)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        errorStream.add('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      errorStream.add(handleError(e));
      return null;
    } catch (e) {
      errorStream.add('Unexpected error: $e');
      return null;
    }
  }
}
