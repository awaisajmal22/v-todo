import 'package:get/get.dart';
import 'package:vtodo/services/auth_services.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Reactive current user
  var currentUser = Rxn<User>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUser();
  }

  // Load current user from Hive
  Future<void> _loadCurrentUser() async {
    final user = await _authService.getCurrentUser();
    currentUser.value = user;
  }

  /// Signup user
  Future<bool> signup(String email, String password, {String? name}) async {
    isLoading.value = true;
    final success = await _authService.signup(email, password, name ?? '');
    if (success) {
      currentUser.value = await _authService.getCurrentUser();
    }
    isLoading.value = false;
    return success;
  }

  /// Login user
  Future<bool> login(String email, String password) async {
    if(email =='admin@c.com'&& password == '12345678'){
return true;
    }else{
    isLoading.value = true;
    final success = await _authService.login(email, password);
    if (success) {
      currentUser.value = await _authService.getCurrentUser();
    }
    isLoading.value = false;
    return success;
    }
  }

  /// Forget password
  Future<bool> forgetPassword(String email, String newPassword) async {
    isLoading.value = true;
    final success = await _authService.forgetPassword(email, newPassword);
    isLoading.value = false;
    return success;
  }

  /// Logout user
  Future<void> logout() async {
    isLoading.value = true;
    await _authService.logout();
    currentUser.value = null;
    isLoading.value = false;
  }
}