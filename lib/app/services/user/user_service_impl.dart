import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist_provider/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userrepository})
      : _userRepository = userrepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _userRepository.googleLogin();

  @override
  Future<void> logout() {
    return _userRepository.logout();
  }

  @override
  Future<void> updateDisplayName(String name) {
    return _userRepository.updateDisplayName(name);
  }
}
