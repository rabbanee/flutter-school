part of 'model.dart';

List<StudentModel> studentModelFromJson(String str) => List<StudentModel>.from(
    json.decode(str).map((x) => StudentModel.fromJson(x)));

String studentModelToJson(List<StudentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentModel {
  StudentModel({
    this.nisn,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.gender,
    this.gradeId,
    this.createdAt,
    this.updatedAt,
  });

  int nisn;
  String name;
  String email;
  String phoneNumber;
  String address;
  Gender gender;
  int gradeId;
  DateTime createdAt;
  DateTime updatedAt;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        nisn: json["nisn"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        gender: genderValues.map[json["gender"]],
        gradeId: json["grade_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nisn": nisn,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "gender": genderValues.reverse[gender],
        "grade_id": gradeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Gender { MALE, FEMALE }

final genderValues = EnumValues({"Female": Gender.FEMALE, "Male": Gender.MALE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
