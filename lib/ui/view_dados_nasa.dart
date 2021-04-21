import 'package:flutter/material.dart';
import 'package:flutter_app/data/helpers/conection_api.dart';
import 'package:flutter_app/data/model/dados_nasa.dart';
import 'package:flutter_app/services/services.dart';
import 'package:video_player/video_player.dart';

class ViewDadosNasa extends StatefulWidget {
  final String data;
  final Future<DadosNasa> dsNasa;

  ViewDadosNasa({Key key, this.data, this.dsNasa}) : super(key: key);

  @override
  _ViewDadosNasaState createState() => _ViewDadosNasaState();
}

class _ViewDadosNasaState extends State<ViewDadosNasa> {

  DadosNasa dadosNasa = DadosNasa();

  @override
  Widget build(BuildContext context) {
    VarFixas varFixas = VarFixas();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dados da Busca")),
      ),
      body: FutureBuilder<DadosNasa>(
        future: widget.dsNasa,
        builder: (BuildContext context, AsyncSnapshot<DadosNasa> snapshot) {

          print(snapshot.data);
          if (snapshot.hasData) {
            return ListView(
              children: [
                snapshot.data.mediaType == varFixas.image
                    ? SizedBox(
                        height: 400,
                        width: 400,
                        child: Image.network(snapshot.data.url),
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        child: AspectRatio(
                          aspectRatio: VideoPlayerController.asset(snapshot.data.url).value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              VideoPlayer(VideoPlayerController.asset(snapshot.data.url)),
                              VideoProgressIndicator(VideoPlayerController.asset(snapshot.data.url),
                                  allowScrubbing: true),
                            ],
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data.title == null ? "Sem dados" : snapshot.data.title,
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      snapshot.data.explanation == null
                          ? ""
                          : snapshot.data.explanation,
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      snapshot.data.copyright == null ? "" : snapshot.data.copyright,
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data.date == null ? "" : snapshot.data.date,
                      style: Theme.of(context).textTheme.subtitle2),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/home');
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
                            'Voltar  ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_return,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center (
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
