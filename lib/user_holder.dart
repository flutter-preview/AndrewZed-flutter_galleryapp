import 'package:flutter_galleryapp/models/user.dart';

class UserHolder {
  Map<String, User> users = {};
  void registerUser(String name, String phone, String emai) {
    User user = User(name: name, phone: phone, email: emai);
    print(user.toString());
    if (!users.containsKey(user.login)) {
      users.addAll({user.login: user});
      users[user.login] = user;
    } else {
      throw Exception('A user with this name already exist');
    }
  }
}
