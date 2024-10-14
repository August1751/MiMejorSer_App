class FormValidators {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Enter email";
    } else if (!value.contains('@')) {
      return "Enter valid email address";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Enter password";
    } else if (value.length < 6) {
      return "Password should have at least 6 characters";
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Enter username";
    } else if (value.length < 8) {
      return "Username must have at least 8 characters";
    }
    return null;
  }
}
