import 'package:flutter/foundation.dart';
import '../model/models.dart';

class UserProvider with ChangeNotifier {

  List<UserModel> _users = [];

  UserModel? _selectedUser;

  List<UserModel> _favorites = [];

  List<UserModel> get users => _users;
  UserModel? get selectedUser => _selectedUser;
  List<UserModel> get favorites => _favorites;

  void setUsers(List<UserModel> newUsers) {
    _users = newUsers;
    notifyListeners();
  }

  void selectUser(UserModel user) {
    _selectedUser = user;
    notifyListeners();
  }

  void addToFavorites(UserModel user) {
    bool exists = _favorites.any((u) => u.id == user.id);
    if (!exists) {
      _favorites.add(user);
      notifyListeners();
    }
  }

  void removeFromFavorites(String id) {
    _favorites.removeWhere((u) => u.id == id);
    notifyListeners();
  }

  String? id;
  String? name;
  String? phone;
  String? job;

  void setUser({
    required String id,
    required String name,
    required String phone,
    required String job,
  }) {
    this.id = id;
    this.name = name;
    this.phone = phone;
    this.job = job;
    notifyListeners();
  }

  void clearUser() {
    id = null;
    name = null;
    phone = null;
    job = null;
    notifyListeners();
  }

  bool get isLoggedIn => id != null;


}
