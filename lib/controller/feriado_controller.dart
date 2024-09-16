import 'package:appadsgp1/model/feriado_model.dart';
import 'package:appadsgp1/model/feriado_repository.dart';

class FeriadoController {
  FeriadosRepository repository = FeriadosRepository();

  Future<List<FeriadoEntity>> getFeriadosList() async {
    List<FeriadoEntity> feriadosList = await repository.getAll();
    return feriadosList;
  }
}