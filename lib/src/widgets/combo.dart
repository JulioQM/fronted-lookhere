import 'package:flutter/material.dart';

class DropdownMenuItems extends StatefulWidget {
  @override
  _DropdownMenuItemsState createState() => _DropdownMenuItemsState();
}

String opcionselecionada = 'selecione';
List<String> poder = ['selecione', 'provincia', 'capital'];

class _DropdownMenuItemsState extends State<DropdownMenuItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30),
        Expanded(
          child: DropdownButton(
            hint: Text('Seleccione una Ciudad'),
            items:
                getOpcionesDropdown(poder: poder, seleccion: opcionselecionada),
            onChanged: (opt) {
              setState(() {
                opcionselecionada = opt;
              });
            },
          ),
        ),
      ],
    );
  }
}

List<DropdownMenuItem<String>> getOpcionesDropdown(
    {List<String> poder, String seleccion}) {
  List<DropdownMenuItem<String>> lista = [];
  poder.forEach((e) {
    lista.add(
      DropdownMenuItem(
        child: Text(e),
        value: e,
      ),
    );
  });
  return lista;
}
