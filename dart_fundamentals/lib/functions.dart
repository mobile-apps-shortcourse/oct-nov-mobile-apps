// this is a function that takes in email & password as
// arguments / paramaters and returns a value (i.e. bool)
import 'dart:math';

bool login(String email, String password) {
  if (isValidEmail(email)) {
    print(email);
    return true;
  }
  return false;
}

bool isValidEmail(String email) {
  if (email.contains('@') && email.contains('.')) {
    return true;
  }
  return false;
}

/// this function has no return type
void saveUserId(String userId) {
  // perform save to local storage
  print(userId);
}

bool checkLoginState() {
  return Random().nextBool();
}

void main() {
  var isLoggedIn = login('email@domain.com', 'password');
  if (isLoggedIn) saveUserId('userId');
  print(isLoggedIn);
}
