import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/auth_info.dart';
import 'package:nike_store/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository(this.authDataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await authDataSource.login(username, password);
  }
  
  @override
  Future<void> signUp(String username, String password) async{
          final AuthInfo authInfo = await authDataSource.signUp(username, password);
  }
  
  @override
  Future<void> refreshToken() {
   return authDataSource.refreshToken();
  }
}
