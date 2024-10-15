class FormValidators {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Ingrese un correo electronico";
    } else if (!value.contains('@')) {
      return "Ingrese un correo valido";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Ingrese una contraseña";
    } else if (value.length < 6) {
      return "La contraseña debe tener minimo 6 caracteres";
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Ingrese usuario";
    } else if (value.length < 8) {
      return "El usuario debe tener minimo 8 caracteres";
    }
    return null;
  }
}
