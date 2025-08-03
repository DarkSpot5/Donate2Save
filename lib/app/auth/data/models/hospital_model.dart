class HospitalModel {
  Map<String, int> bloodStock = {
    'A+': 0, 'A-': 0, 'B+': 0, 'B-': 0,
    'AB+': 0, 'AB-': 0, 'O+': 0, 'O-': 0,
  };

  static final HospitalModel _instance = HospitalModel._internal();
  factory HospitalModel() => _instance;

  HospitalModel._internal();

  void reset() {
    bloodStock = {};
  }
  Map<String, dynamic> toJson() {
    return {
      'BloodStock': bloodStock,
    };  
  }

  void fromJson(Map<String, dynamic>? map) {
      bloodStock = Map<String, int>.from(map!['BloodStock'] ?? bloodStock);
    }
}