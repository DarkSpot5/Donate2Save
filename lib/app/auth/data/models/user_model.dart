class UserModel {
  String? bloodGroup;
  String? gender;
  String? location;

  static final UserModel _instance = UserModel._internal();
  factory UserModel() => _instance;

  UserModel._internal();

  void reset() {
    bloodGroup = null;
    gender = null;
    location = null;
  }

  Map<String, dynamic> toMap() {
    return {
      'bloodGroup': bloodGroup,
      'gender': gender,
      'location': location,
    };
  }

  void fromMap(Map<String, dynamic> data) {
    bloodGroup = data['bloodGroup'];
    gender = data['gender'];
    location = data['location'];
  }
}