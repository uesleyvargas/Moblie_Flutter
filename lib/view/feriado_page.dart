import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appadsgp1/controller/feriado_controller.dart';
import 'package:appadsgp1/model/feriado_model.dart';
import 'package:appadsgp1/view/drawer.dart';


class FeriadoPage extends StatefulWidget {
  const FeriadoPage({super.key});

  @override
  State<FeriadoPage> createState() => _FeriadoPageState();
}

class _FeriadoPageState extends State<FeriadoPage> {

  FeriadoController controller = FeriadoController();
  
  late Future<List<FeriadoEntity>> feriadosFuture;
  

  Future<List<FeriadoEntity>> getFeriados() async {
    return await controller.getFeriadosList();
  }

  @override
  void initState() {
    super.initState();
    feriadosFuture = getFeriados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: const Text("Feriados Nacionais"),
      ),
      body: FutureBuilder(
        future: feriadosFuture,
        builder: (context, AsyncSnapshot<List<FeriadoEntity>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String formattedDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(snapshot.data![index].date ?? ''));

                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(snapshot.data![index].name ?? 'Não informado'),
                    subtitle:
                        Text(formattedDate),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}