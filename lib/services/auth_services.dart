import 'package:hive/hive.dart';
import '../models/user_model.dart';
class AuthService {
  static const String _userBoxName = 'users';
  static const String _currentUserKey = 'currentUser';

  Future<void> init() async {
    // Only open the box if it's not already open
    if (!Hive.isBoxOpen(_userBoxName)) {
      await Hive.openBox<User>(_userBoxName);
    }
    if (!Hive.isBoxOpen(_currentUserKey)) {
      await Hive.openBox(_currentUserKey);
    }
  }

  Future<bool> signup(String email, String password, String name) async {
    final box = Hive.box<User>(_userBoxName);
    if (box.containsKey(email)) {
      return false; // User already exists
    }
    final user = User(email: email, password: password, name: name);
    await box.put(email, user);
    await _setCurrentUser(email);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final box = Hive.box<User>(_userBoxName);
    final user = box.get(email);
    if (user != null && user.password == password) {
      await _setCurrentUser(email);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _setCurrentUser(null);
  }

  Future<bool> forgetPassword(String email, String newPassword) async {
    final box = Hive.box<User>(_userBoxName);
    final user = box.get(email);
    if (user != null) {
      user.password = newPassword;
      await user.save();
      return true;
    }
    return false;
  }

  Future<String?> getCurrentUserEmail() async {
    final box = Hive.box(_currentUserKey);
    return box.get('email') as String?;
  }

  Future<User?> getCurrentUser() async {
    final email = await getCurrentUserEmail();
    if (email != null) {
      final box = Hive.box<User>(_userBoxName);
      return box.get(email);
    }
    return null;
  }

  Future<void> _setCurrentUser(String? email) async {
    final box = Hive.box(_currentUserKey);
    if (email != null) {
      await box.put('email', email);
    } else {
      await box.delete('email');
    }
  }
}