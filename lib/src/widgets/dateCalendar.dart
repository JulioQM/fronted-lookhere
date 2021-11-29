import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';

class DataCalendars extends StatefulWidget {
  @override
  _DataCalendarsState createState() => _DataCalendarsState();
}

TextEditingController inputFielDateController = new TextEditingController();

class _DataCalendarsState extends State<DataCalendars> {
  String fecha = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: crearfechas(context),
    );
  }

  Widget crearfechas(BuildContext context) {
    return TextFormField(
      controller: inputFielDateController,
      enableInteractiveSelection: false,
      decoration: InputDecorations.inputDecoration(
          hintText: 'Fecha de nacmiento',
          labelText: 'Fecha de nacimiento',
          prefixIcon: Icons.calendar_today),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        selectDate(context);
      },
    );
  }

  selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now(),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      setState(() {
        fecha = picked.toString();
        inputFielDateController.text = fecha;
      });
    }
  }
}
