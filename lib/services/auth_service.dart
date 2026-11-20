import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_models.dart';
import 'api_client.dart';
import 'api_endpoints.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({ApiClient? apiClient}) : apiClient = apiClient ?? ApiClient();

  String get platform {
    return defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  }

  void printCurlCommand({
    required String endpoint,
    required Map<String, dynamic> queryParameters,
  }) {
    final uri = Uri.parse('${ApiClient.baseUrl}$endpoint')
        .replace(queryParameters: queryParameters);

    final url = uri.toString().replaceAll("'", "'\\''");
    // ignore: avoid_print
    print(
      "curl --request GET --url '$url' "
      "--header 'Accept: application/json' "
      "--header 'Content-Type: application/json'",
    );
  }

  Future<RegistrationResult> registerUser({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required String countryCode,
    required String countryName,
    bool printCurl = false,
  }) async {
    final queryParameters = {
      'name': name,
      'emailId': email,
      'password': password,
      'mobile': mobile,
      'countrycode': countryCode,
      'countryname': countryName,
      'location': platform,
    };

    if (printCurl) {
      printCurlCommand(
        endpoint: ApiEndpoints.registration,
        queryParameters: queryParameters,
      );
    }

    final data = await apiClient.get(
      ApiEndpoints.registration,
      queryParameters: queryParameters,
    );

    final map = _mapResponse(data);
    if (map == null) {
      throw const ApiException('The registration response format is invalid.');
    }

    final user = AuthUser.fromMap(map);
    if (user.userid != null) {
      await saveUser(user);
    }
    return RegistrationResult(user);
  }

  Future<AuthUser> loginUser({
    required String email,
    required String password,
  }) async {
    final data = await apiClient.get(
      ApiEndpoints.login,
      queryParameters: {'emailid': email, 'password': password},
    );

    final map = _mapResponse(data);
    if (map == null) {
      throw const ApiException('The login response format is invalid.');
    }

    final user = AuthUser.fromMap(map);
    if (user.statusCode != null && user.statusCode != '1') {
      throw ApiException(
        'Login was not successful. StatusCode: ${user.statusCode}',
      );
    }
    final userid = user.userid;
    if (userid == null) {
      throw ApiException(
        user.statusCode == null
            ? 'Login failed: no valid user ID was returned.'
            : 'Login failed. StatusCode: ${user.statusCode}',
      );
    }

    await saveUser(user);
    return user;
  }

  Future<OtpResult> sendOtp({
    required String userid,
    bool printCurl = false,
  }) async {
    if (userid.trim().isEmpty) {
      throw const ApiException('A valid user ID is required to send OTP.');
    }

    final queryParameters = {'userid': userid, 'Device': platform};

    if (printCurl) {
      printCurlCommand(
        endpoint: ApiEndpoints.sendOtp,
        queryParameters: queryParameters,
      );
    }

    final data = await apiClient.get(
      ApiEndpoints.sendOtp,
      queryParameters: queryParameters,
    );

    final map = _mapResponse(data);
    if (map == null) {
      throw const ApiException('The SendOTP response format is invalid.');
    }

    final statusCode = _statusCode(map);
    if (statusCode != null && statusCode != '1') {
      throw ApiException('SendOTP was not successful. StatusCode: $statusCode');
    }

    final otp = _findOtp(map);
    if (otp == null) {
      throw const ApiException(
        'The server did not return an OTP field in a recognized format.',
      );
    }

    return OtpResult(otp: otp, statusCode: statusCode);
  }

  Future<Map<String, dynamic>> verifyOtp({required String userid}) async {
    if (userid.trim().isEmpty) {
      throw const ApiException('A valid user ID is required for verification.');
    }

    final data = await apiClient.get(
      ApiEndpoints.verifyOtp,
      queryParameters: {'userid': userid, 'userMobile': platform},
    );

    final map = _mapResponse(data);
    if (map == null) {
      throw const ApiException('The verification response format is invalid.');
    }

    final statusCode = _statusCode(map);
    if (statusCode != null && statusCode != '1') {
      throw ApiException(
        'Verification was not successful. StatusCode: $statusCode',
      );
    }

    return map;
  }

  Future<void> saveUser(AuthUser user) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('authenticated_user_id', user.userid ?? '');
    await preferences.setString('authenticated_user_name', user.userName ?? '');
    await preferences.setString(
      'authenticated_user_mobile',
      user.userMobile ?? '',
    );
  }

  Future<String?> getSavedUserId() async {
    final preferences = await SharedPreferences.getInstance();
    final userid = preferences.getString('authenticated_user_id');
    return userid == null || userid.isEmpty ? null : userid;
  }

  Future<void> clearSession() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('authenticated_user_id');
    await preferences.remove('authenticated_user_name');
    await preferences.remove('authenticated_user_mobile');
  }

  String? _statusCode(Map<String, dynamic> map) {
    final value = map['StatusCode'];
    if (value == null) return null;
    final statusCode = value.toString().trim();
    return statusCode.isEmpty ? null : statusCode;
  }

  Map<String, dynamic>? _mapResponse(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  String? _findOtp(Map<String, dynamic> map) {
    const keys = <String>[
      'OTP',
      'otp',
      'Otp',
      'otpNumber',
      'OtpNumber',
      'OTPNumber',
      'verificationOtp',
    ];

    for (final key in keys) {
      final value = map[key];
      if (value != null) {
        final otp = value.toString().trim();
        if (otp.isNotEmpty) return otp;
      }
    }

    for (final value in map.values) {
      if (value is Map) {
        final nested = Map<String, dynamic>.from(value);
        final otp = _findOtp(nested);
        if (otp != null) return otp;
      }
    }

    return null;
  }
}
