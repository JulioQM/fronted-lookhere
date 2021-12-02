import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';

class PerfilPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
        ),
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
            }),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) => PerfilCard(),
      ),
    );
  }
}







