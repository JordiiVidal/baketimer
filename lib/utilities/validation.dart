String? validatorEmail(text) {
  return (!text.contains(RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')))
      ? ''
      : null;
}

String? validatorPassword(txt) {
  if (txt == null || txt.isEmpty) {
    return "Entry password";
  }
  if (txt.length < 6) {
    return "Password must has 6 characters";
  }
  // if (!txt.contains(RegExp(r'[A-Z]'))) {
  //   return "Password must has uppercase";
  // }
  // if (!txt.contains(RegExp(r'[0-9]'))) {
  //   return "Password must has digits";
  // }
  // if (!txt.contains(RegExp(r'[a-z]'))) {
  //   return "Password must has lowercase";
  // }
  // if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
  //   return "Password must has special characters";
  // }
  return null;
}
