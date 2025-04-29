import 'user.dart';

class AuthService {
  User? _currentUser;

  Future<User?> login(String username, String password) async {
    print(
        'AuthService: Attempting login with username: $username, password: $password');
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'test' && password == 'password') {
      print('AuthService: Login successful');
      _currentUser = User(username: username);
      return _currentUser;
    }
    print('AuthService: Login failed');
    return null;
  }

  Future<User?> signup(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (username != 'test') {
      _currentUser = User(username: username);
      return _currentUser;
    }
    return null;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = null;
  }

  User? getCurrentUser() {
    return _currentUser;
  }
}
