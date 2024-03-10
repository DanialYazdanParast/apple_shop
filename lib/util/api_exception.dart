import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;

  Response<dynamic>? response;

  ApiException(this.code, this.message, {this.response}) {
    if (code != 400) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبوراشتباه است';
    }

    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'نام کاربری نامعتبراست یا قبلا گرفته شده';
        }
      }
    }
  }
}
