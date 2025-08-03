class UserModel {
  String? bloodGroup;
  String? gender;

  static final UserModel _instance = UserModel._internal();
  factory UserModel() => _instance;

  UserModel._internal();

  void reset() {
    bloodGroup = null;
    gender = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'BloodGroup': bloodGroup,
      'Gender': gender,
    };
  }

  void fromJson(Map<String, dynamic>? data) {
    bloodGroup = data!['BloodGroup'] ?? bloodGroup;
    gender = data['Gender'] ?? gender;
  }
}