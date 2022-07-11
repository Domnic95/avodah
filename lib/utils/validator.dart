// ignore_for_file: unnecessary_string_escapes

bool emailValidator(String s) {
  //return RegExp("[a-zA-z0-9]+@[a-z0-9]+.[a-z]+").hasMatch(s);
  return RegExp(
          "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+")
      .hasMatch(s);
}
