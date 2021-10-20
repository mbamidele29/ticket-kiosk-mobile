bool isEmailValid(String value){
  if (value == null || value.isEmpty) {
    return false;
  }
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool isNameValid(String value){
  return value!=null && value.isNotEmpty && value.length>2;
}

bool isPasswordValid(String value){
  if (value == null || value.isEmpty) {
    return false;
  }
  return value.length>5;
}

// bool isNot