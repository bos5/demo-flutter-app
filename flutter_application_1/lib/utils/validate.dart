bool validateEmail(String value) {
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);
  if (value.isEmpty) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

bool validatePassword(String value) {
  const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  final regExp = RegExp(pattern);
  if (value.isEmpty) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

bool validateConfirmPassword(String value, String password) {
  if (value.isEmpty || password.isEmpty) {
    return false;
  } else if (value != password) {
    return false;
  } else {
    return true;
  }
}
