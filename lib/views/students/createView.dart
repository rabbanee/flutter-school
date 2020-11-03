part of '../view.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final globalKey = GlobalKey<ScaffoldState>();

  TextEditingController nisn = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gradeId = TextEditingController();
  int _gender = -1;
  final _formKey = GlobalKey<FormState>();

  String message = '';

  bool loading = false;

  Future saveData() async {
    var gender = 'Male';
    var response;
    switch (_gender) {
      case 0:
        gender = 'Male';
        break;
      case 1:
        gender = 'Female';
        break;
    }

    try {
      response = await createStudent(
          nisn.text.toString(),
          name.text.toString(),
          email.text.toString(),
          phoneNumber.text.toString(),
          address.text.toString(),
          gender,
          gradeId.text.toString());
    } catch (e) {
      return 'Failed $e';
    }
    setState(() {
      loading = false;
    });
    print('response: $response');
    return response
        ? 'Success to create a student'
        : 'Failed to create a student';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text('Create a Student'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    controller: nisn,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Nisn',
                      labelText: 'Nisn',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Name',
                      labelText: 'Name',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Email',
                      labelText: 'Email',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneNumber,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: address,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Address',
                      labelText: 'Address',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: _gender,
                        onChanged: (value) {
                          print('Gender value: $value');
                          setState(() => _gender = value);
                        },
                        activeColor: Colors.blue,
                      ),
                      Text(
                        'Male',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        value: 1,
                        groupValue: _gender,
                        onChanged: (value) {
                          print('Gender value: $value');
                          setState(() => _gender = value);
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: gradeId,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Grade Id',
                      labelText: 'Grade Id',
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: loading
                        ? null
                        : () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              var response = await saveData();
                              final snackBar =
                                  SnackBar(content: Text('$response'));
                              globalKey.currentState.showSnackBar(snackBar);
                            }
                          },
                    child: Text(
                      loading ? 'Saving a student...' : 'Create a Student',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )));
  }
}
