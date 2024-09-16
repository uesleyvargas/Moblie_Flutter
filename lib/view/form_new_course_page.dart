import 'package:appadsgp1/controller/course_controller.dart';
import 'package:appadsgp1/model/course_model.dart';
import 'package:flutter/material.dart';

class FormNewCoursePage extends StatefulWidget {
  final CourseEntity? courseEdit;

  FormNewCoursePage({super.key, this.courseEdit});

  @override
  State<FormNewCoursePage> createState() => _FormNewCoursePageState();
}

class _FormNewCoursePageState extends State<FormNewCoursePage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();
  String id = '';

  CourseController controller = CourseController();

  postNewCourse() async {
    try {
      await controller.postNewCourse(CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt: controller.dateFormatStringPtBRToAPI(textStartAtController.text)));
      //
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Curso inserido com sucesso."),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  putUpdateCourse() async {
    try {
      await controller.putUpdateNewCourse(CourseEntity(
          id: id,
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt: controller.dateFormatStringPtBRToAPI(textStartAtController.text)));
      //
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Curso atualizado com sucesso."),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.courseEdit != null) {
      id = widget.courseEdit?.id ?? '';
      textNameController.text = widget.courseEdit?.name ?? '';
      textDescriptionController.text = widget.courseEdit?.description ?? '';
      textStartAtController.text =  controller.dateTimeFormatToStringPtBR(
        DateTime.parse(widget.courseEdit?.startAt ?? '')) 
      ?? '--/--/----';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de curso", overflow: TextOverflow.ellipsis),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textNameController,
                validator: (value) {
                  if (value == null) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: textDescriptionController,
                validator: (value) {
                  if (value == null) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Selecione a data"
                ),
                onTap: () {
                  showDatePicker(context: context, 
                  locale: const Locale('pt', 'BR'),
                  initialDate: DateTime.now(), 
                  firstDate: DateTime.now(), 
                  lastDate: DateTime(2030)).then((DateTime? value) {
                    if (value != null) {
                      textStartAtController.text = controller.dateTimeFormatToStringPtBR(value);
                    }
                  });
                },
                controller: textStartAtController,
                validator: (value) {
                  if (value == null) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 48,
                width: MediaQuery.sizeOf(context).width, //100%
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (widget.courseEdit != null) {
                        putUpdateCourse();
                      } else {
                        postNewCourse();
                      }
                    }
                  },
                  child: Text("Salvar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
