class HospitalModel {
  String? location;
  Map<String, int> bloodStock = {
    'A+': 0, 'A-': 0, 'B+': 0, 'B-': 0,
    'AB+': 0, 'AB-': 0, 'O+': 0, 'O-': 0,
  };

  static final HospitalModel _instance = HospitalModel._internal();
  factory HospitalModel() => _instance;

  HospitalModel._internal();

  void reset() {
    location = '';
    bloodStock = {};
  }
void fromMap(Map<String, dynamic> map) {
    location = map['location'] ?? '';
    bloodStock = Map<String, int>.from(map['bloodStock'] ?? {});
  }
}