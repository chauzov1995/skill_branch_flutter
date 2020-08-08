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

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, phone: '', email: email);

    if (!users.containsKey(user.login)) {
      return user;
    } else {
      Exception('A user with this email already exists');
    }
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    } else {
      throw Exception("User does not exist");
    }
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone, email: '');

    if (!users.containsKey(user.login)) {
      return user;
    } else {
      Exception('A user with this phone already exists');
    }
  }

  User findUserInFriends(String fullName, User user) {
    User user2 = User(name: fullName, phone: '', email: '');
    if (user2.friends.contains(user)) {
      return user2.friends[user2.friends.indexOf(user)];
    } else
      Exception("${user.login} is not a friend of the login");
  }

  void setFriends(String fullName, User user) {
    User user2 = User(name: fullName, phone: '', email: '');
    Iterable<User> friends = [user];
    user2.addFriend(friends);
  }
}
