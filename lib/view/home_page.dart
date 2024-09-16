import 'package:appadsgp1/controller/course_controller.dart';
import 'package:appadsgp1/model/course_model.dart';
import 'package:appadsgp1/view/form_new_course_page.dart';
import 'package:appadsgp1/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CourseController controller = CourseController();

  late Future<List<CourseEntity>> _futureCourses;

  Future<List<CourseEntity>> getCourses() async {
    return await controller.getCourseList();
  }

  void navigateToForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormNewCoursePage(),
      ),
    ).then((value) {
      _futureCourses = getCourses();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _futureCourses = getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: const Text("Lista de cursos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToForm,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _futureCourses,
        builder: (context, AsyncSnapshot<List<CourseEntity>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormNewCoursePage(
                                    courseEdit: snapshot.data![index]),
                              ),
                            ).then((value) {
                              _futureCourses = getCourses();
                              setState(() {});
                            });
                            //atualize a lista
                          },
                        ),
                        SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Confirmação"),
                                  content: Text("Deseja excluir este curso?"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await controller.deleteCourse(
                                            snapshot.data![index].id!);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Confirmar"),
                                    ),
                                  ],
                                ),
                              ).then((value) {
                                if (value != null) {
                                  _futureCourses = getCourses();
                                  setState(() {});
                                }
                              });
                            })
                      ]),
                      child: ListTile(
                        title:
                            Text(snapshot.data![index].name ?? 'Não informado'),
                        subtitle: Text(snapshot.data![index].description ??
                            'Não informado'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        leading: const CircleAvatar(
                          child: Text("CC"), //TODO
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
