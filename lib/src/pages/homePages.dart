import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/widgets/loginBackground.dart';
import 'package:fronted_lookhere/src/widgets/scanButton.dart';
import 'package:fronted_lookhere/src/widgets/widgetArgument.dart';

class HomePages extends StatelessWidget {
  // creo mi variable de tipo final para optener los datos
  //final String alias;
  // muy importante para llamar parametros de otras paginas
  const HomePages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WidgetArguments arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        /*appBar: AppBar(
          //title: Text('Bienvidido ' + arguments.title),
          /* title: Text('Bienvidido '), */
          /* automaticallyImplyLeading: true,
          backwardsCompatibility: true, */
        ),*/
        body: LoginBackground(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 120),
              Container(
                child: Text(
                  'Bienvidos al administrador',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  strutStyle: StrutStyle(fontSize: 60),
                ),
              ),
            ],
          )
        ],
      ),
    )
        // floatingActionButton: ScanButton(),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
  }
}
