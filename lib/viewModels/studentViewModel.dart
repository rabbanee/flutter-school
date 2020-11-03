part of 'viewModel.dart';

Future getStudents({page = 1}) async {
  try {
    http.Response result = await http.get(
        Uri.parse('https://api-sekolah.herokuapp.com/api/students?page=$page'),
        headers: {"Accept": "application/json"});

    print('status code: ${result.statusCode}');
    if (result.statusCode == 200) {
      print('Success get data');
      final data = studentModelFromJson(result.body);
      return data;
    } else {
      print('Failed to get data');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future createStudent(String nisn, String name, String email, String phoneNumber,
    String address, String gender, String gradeId) async {
  try {
    var url = 'https://api-sekolah.herokuapp.com/api/students';
    var result = await http.post(url,
        body: ({
          'nisn': nisn,
          'name': name,
          'email': email,
          'phone_number': phoneNumber,
          'address': address,
          'gender': gender,
          'grade_id': gradeId,
        }));
    print('status code: ${result.statusCode}');
    if (result.statusCode == 200) {
      print('masuk');
      return true;
    } else {
      print('Failed to add data ${result.body}');
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
