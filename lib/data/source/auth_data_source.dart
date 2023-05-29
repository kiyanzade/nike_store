import 'package:dio/dio.dart';
import 'package:nike_store/data/auth_info.dart';

import '../../common/exceptions.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> signUp(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": "kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC",
      "username": username,
      "password": password,
    });
    validateResponse(response);
    return AuthInfo(response.data["access_token"],
        response.data["refresh_token"], username);
  }

  @override
  Future<AuthInfo> refreshToken(String token) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "refresh_token": token,
      "client_id": 2,
      "client_secret": "kyj1c9sVcksqGU4scMX7nLDalkjp2WoqQEf8PKAC",
    });
    validateResponse(response);
    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"], "");
  }

  @override
  Future<AuthInfo> signUp(String username, String password) async {
    final response = await httpClient
        .post("user/register", data: {"email": username, "password": password});
    validateResponse(response);
    return login(username, password);
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
