// no es Widget
import 'package:flutter/material.dart';

// metodo estatic, y hacer referencia a a la propiedad TextButton
class TextButtons {
  static TextButton etiquetaTextButton(
      {String titulo, String direccionamientoPagina, BuildContext context}) {
    return TextButton(
      // un texto boton
      onPressed: () =>
          Navigator.pushReplacementNamed(context, direccionamientoPagina),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 18, color: Colors.black87),
      ),
    );
  }
}
