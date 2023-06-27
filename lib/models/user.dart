import 'package:flutter_galleryapp/string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;
  String _lastName;
  String _firstName;
  late LoginType _type;

  List<User> friends = [];

  User._({String? firstName, String? lastName, String? phone, String? email})
      : _firstName = firstName!,
        _lastName = lastName!,
        this.phone = phone!,
        this.email = email! {
    print('User created');
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String? name, String? phone, String? email}) {
    if (name!.isEmpty) throw Exception('User name is empty');
    if (phone!.isEmpty || email!.isEmpty) {
      throw Exception('User phone is empty');
    }

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
        email: checkEmail(email));
  }

  static String _getLastName(String? userName) => userName!.split(' ')[1];

  static String _getFirstName(String? userName) => userName!.split(' ')[0];

  static String checkPhone(String? phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";
    phone = phone?.replaceAll(RegExp('[^+\\d]'), '');
    if (phone == null || phone.isEmpty) {
      throw Exception('Enter don`t empty phone number');
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          'Enter valid phone number starting whith a + and containing 11 digits');
    }
    return phone;
  }

  static String checkEmail(String? email) {
    if (email == null || email.isEmpty) {
      throw Exception('Enter don`t empty phone number');
    }
    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${"".capitalize(_firstName)} ${''.capitalize(_lastName)}";

  @override
  bool operator ==(Object other) {
    if (other is User) {
      return _firstName == other._firstName &&
          _lastName == other._lastName &&
          (phone == other.phone || email == other.email);
    }
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

  void addFriends(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriends(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toString()}
    ''';

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    friends: ${friends.toString()}
    ''';
  }
}
