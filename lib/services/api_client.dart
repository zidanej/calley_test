import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  static const String baseUrl = 'https://mock-api.getcalley.com/api/service';

  final Dio dio;

  ApiClient({Dio? dio}) : dio = dio ?? _createDio();

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      if (response.data == null) {
        throw const ApiException('The server returned an empty response.');
      }

      return response.data;
    } on DioException catch (error) {
      throw ApiException(_getDioMessage(error));
    } on ApiException {
      rethrow;
    } catch (error) {
      throw const ApiException(
        'An unexpected error occurred. Please try again.',
      );
    }
  }

  String _getDioMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Unable to connect. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          return 'Server error ($statusCode). Please try again.';
        }
        return 'The server returned an invalid response.';
      case DioExceptionType.cancel:
        return 'The request was cancelled.';
      default:
        return 'Unable to complete the request. Please try again.';
    }
  }
}
