import 'package:flutter/cupertino.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource authDataSource;

  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);

  AuthRepository(
    this.authDataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await authDataSource.login(username, password);
    _persistAuthToken(authInfo);
  }

  @override
  Future<void> signUp(String username, String password) async {
    final AuthInfo authInfo = await authDataSource.signUp(username, password);
    _persistAuthToken(authInfo);
  }

  @override
  Future<void> refreshToken() async {
    final AuthInfo authInfo = await authDataSource.refreshToken("");
    _persistAuthToken(authInfo);
  }

  Future<void> _persistAuthToken(AuthInfo authInfo) async {
   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authInfo.accsesToken);
    sharedPreferences.setString("refresh_token", authInfo.refreshToken);
  }

  Future<void> loadAuthToken() async {
   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken =
        sharedPreferences.getString("access_token") ?? "";
    final String refreshToken =
        sharedPreferences.getString("refresh_token") ?? "";
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthInfo(accessToken, refreshToken);
    }
  }
}
