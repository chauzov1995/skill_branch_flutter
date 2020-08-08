import 'package:FlutterGalleryApp/models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }
  User registerUserByEmail(String fullName, String email){
    User user = User(name: fullName, phone: '', email: email);

    if (!users.containsKey(user.login)) {
      return user;
    }else{
      Exception('A user with this email already exists');
    }


  }
}
