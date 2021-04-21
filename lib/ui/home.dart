import 'package:flutter/material.dart';
import 'package:flutter_app/ui/view_dados_nasa.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_app/data/helpers/conection_api.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  static final now = DateTime.now();

  final dropdownDatePicker = DropdownDatePicker(
    firstDate: ValidDate(day: 1, month: 1, year: now.year - 100),
    lastDate: ValidDate(day: now.day, month: now.month, year: now.year),
    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    dropdownColor: Colors.blue[200],
    dateHint: DateHint(day: 'Dia', month: 'Mês', year: 'Ano'),
    ascending: false,
  );
}

class _HomeState extends State<Home> {

  bool contains = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Center(child: Text("Nasa - API")),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'Resgate informações da Nasa.',
                style: TextStyle(fontSize: 20),
              )),
            ),
            widget.dropdownDatePicker,
            Padding(
              padding: EdgeInsets.all(8),
              child: SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    String data = widget.dropdownDatePicker.getDate('-').toString();

                    if(data.contains("null")){
                      setState(() {
                        contains = true;
                      });
                    } else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ViewDadosNasa(
                            data: data,
                            dsNasa: API().resgataDados(data),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pesquisar  ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.youtube_searched_for_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),

                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: contains ? Text("Favor digitar uma data Válida", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),) : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
