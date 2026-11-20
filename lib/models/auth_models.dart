class AuthUser {
  final String? userid;
  final String? userName;
  final String? userMobile;
  final String? packageType;
  final String? userType;
  final String? countryCode;
  final bool? isVerified;
  final String? statusCode;

  const AuthUser({
    this.userid,
    this.userName,
    this.userMobile,
    this.packageType,
    this.userType,
    this.countryCode,
    this.isVerified,
    this.statusCode,
  });

  factory AuthUser.fromMap(Map<String, dynamic> data) {
    return AuthUser(
      userid: _stringValue(data['userid']),
      userName: _stringValue(data['userName']),
      userMobile: _stringValue(data['userMobile']),
      packageType: _stringValue(data['Package_type']),
      userType: _stringValue(data['userType']),
      countryCode: _stringValue(data['CountryCode']),
      isVerified: _boolValue(data['IsVerified']),
      statusCode: _stringValue(data['StatusCode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'userName': userName,
      'userMobile': userMobile,
      'Package_type': packageType,
      'userType': userType,
      'CountryCode': countryCode,
      'IsVerified': isVerified,
      'StatusCode': statusCode,
    };
  }

  static String? _stringValue(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static bool? _boolValue(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
        return true;
      }
      if (normalized == 'false' || normalized == '0' || normalized == 'no') {
        return false;
      }
    }
    return null;
  }
}

class RegistrationResult {
  final AuthUser user;

  const RegistrationResult(this.user);
}

class OtpResult {
  final String otp;
  final String? statusCode;

  const OtpResult({required this.otp, this.statusCode});
}
