import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';

class PerfilPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) => PerfilCard(),
        ));
  }
}
