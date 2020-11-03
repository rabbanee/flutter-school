part of '../view.dart';

class Students extends StatefulWidget {
  @override
  _StudentsState createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  StudentModel student;
  List<Datum> data = [];
  int currentPage = 1;
  bool isLoading = false;

  get diretion => null;

  Future getListStudent({page = 1}) async {
    var result = await getStudents();
    setState(() {
      student = result;
      data.addAll(student.data);
      currentPage = student.meta.currentPage;
    });

    setState(() {
      isLoading = false;
    });
    print('students: ${data[0].nisn}');
  }

  void initState() {
    super.initState();
    getListStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Student'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Create();
          }));
        },
        tooltip: 'Add a post',
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          student == null
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        getListStudent(page: currentPage + 1);
                        setState(() {
                          isLoading = true;
                        });
                      }
                    },
                    child: ListView.builder(
                      itemBuilder: (context, i) {
                        return Dismissible(
                          confirmDismiss: (direction) =>
                              dismissibleAction(direction, context, data[i]),
                          secondaryBackground: Container(
                            color: Colors.red,
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Delete",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                          background: Container(
                            color: Colors.green,
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Edit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          key: UniqueKey(),
                          child: ListTile(
                            title: Text(data[i].name),
                            subtitle: Text('Grade: ${data[i].grade}'),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ),
          Container(
            height: isLoading ? 50.0 : 0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> dismissibleAction(direction, context, student) async {
  if (direction == DismissDirection.endToStart) {
    final bool res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Are you sure you want to delete ${student.name}?"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  // TODO: Delete the item from DB etc..
                  // setState(() {
                  //   // itemsList.removeAt(index);
                  // });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    return res;
  } else {
    // TODO: Navigate to edit page;
  }
}
