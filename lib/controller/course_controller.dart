import 'package:appadsgp1/model/course_model.dart';
import 'package:appadsgp1/model/course_repository.dart';
import 'package:intl/intl.dart';

class CourseController {

  CourseRepository repository = CourseRepository();

  Future<List<CourseEntity>> getCourseList() async {
    List<CourseEntity> list  = await repository.getAll();
    //aqui eu poderia filtrar, formatar, regras, etc na LIST
    return list;
  }

  postNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.postNewCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }

  putUpdateNewCourse(CourseEntity courseEntity) async {
    try {
      await repository.putUpdateCourse(courseEntity);
    } catch (e) {
      rethrow;
    }
  }

  getLettersFromAvatar(String name) {
    print(name);
    String initials = name.split(' ').map((word) => word[0]).join('');
    return initials.substring(0,2);

  }

  deleteCourse(String id) async {
    try {
      repository.deleteCourse(id);
    } catch (e) {
      rethrow;
    }
  }

  dateTimeFormatToStringPtBR(DateTime dateSelected) {
    DateFormat outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(dateSelected);
  }

  dateFormatStringPtBRToAPI(String dateSelected) {
    // 05/11/2024
    String day = dateSelected.substring(0,2);
    String month = dateSelected.substring(3,5);
    String year = dateSelected.substring(6,10);
    String dateFormat = '$year-$month-${day}T00:00:00.000Z';
    return dateFormat;
  }

}