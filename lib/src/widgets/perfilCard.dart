import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:provider/provider.dart';

class PerfilCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      /* padding: const EdgeInsets.all(8.0), */
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 50),
        width: double.infinity,
        height: size.height * 0.85, // tamaño de los cuadros
        //color: Colors.black,
        decoration: _cardBorders(),
        child: Stack(
          children: [_BackgroundImage()],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          /* color: Colors.red, */
          borderRadius: BorderRadius.circular(20), // bordes redondos
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10),
          ]);
}

class _BackgroundImage extends StatelessWidget {
  final clave = GlobalKey<FormState>();

  final TextEditingController nombre = new TextEditingController();
  final TextEditingController apellido = new TextEditingController();
  final TextEditingController cedula = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final persForm = Provider.of<PersonaProvider>(context);
    /* final IdPersonaArguments argPersona =
        ModalRoute.of(context).settings.arguments; */
    return Container(
      margin: EdgeInsets.all(9),
      child: ListView(
        children: [
          FutureBuilder<List<Persona>>(
            future: persForm.getListaPersona(2 /* argPersona.persId */),
            builder:
                (BuildContext context, AsyncSnapshot<List<Persona>> snapshot) {
              List<Persona> pers = snapshot.data ?? [];

              return Column(
                children: [
                  // creo mi avatar
                  for (Persona persona in pers)
                    CircleAvatar(
                      radius: 60,
                      child: Text(
                        persona.getPersNombres[0],
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                  // bloque con mis datos personales
                  for (Persona persona in pers)
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Datos Personales',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            // bloque de encabezado isquierdo icono pluma
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      title: Text('Actualizar Información'),
                                      children: [
                                        SizedBox(height: 10),
                                        //
                                        Container(
                                          child: Form(
                                            key: persForm.formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: nombre,
                                                  decoration: InputDecorations
                                                      .inputDecoration(
                                                          hintText:
                                                              'ingrese su nombre',
                                                          labelText: 'Nombre'),
                                                  onChanged: (value) {
                                                    persForm.managerPersona
                                                        .setPersNombres = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: apellido,
                                                  decoration: InputDecorations
                                                      .inputDecoration(
                                                          hintText:
                                                              'ingrese su apellidos',
                                                          labelText:
                                                              'Apellido'),
                                                  onChanged: (value) {
                                                    persForm.managerPersona
                                                        .setPersNombres = value;
                                                  },
                                                ),
                                                TextFormField(
                                                  controller: cedula,
                                                  decoration: InputDecorations
                                                      .inputDecoration(
                                                          hintText:
                                                              'ingrese su cédula',
                                                          labelText: 'Cédula'),
                                                  onChanged: (value) {
                                                    persForm.managerPersona
                                                        .setPersNombres = value;
                                                  },
                                                ),
                                                Divider(),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  onPressed: () async {
                                                    /* if (clave.currentState
                                                  .validate()) { */
                                                    RespuestaModel respuesta =
                                                        await persForm
                                                            .actualizar();
                                                    //}
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 50,
                                                            vertical: 15),
                                                    child: Text(
                                                      'Actualizar',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  color: Colors.indigo,
                                                ),

                                                ///
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            'Nombres: ' + persona.persNombres,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Apellidos: ' + persona.persApellidos,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Cédula: ' + persona.persIdentificacion,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Celular: ' + persona.persCelular,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Fecha Nacimiento: ' + persona.persDiaNacimiento,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sexo: ' +
                                (persona.persSexo.contains('M')
                                    ? 'Masculino'
                                    : 'Femenino'),
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      // color: Colors.blue,
                    ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),
                  // bloque de residencia
                  for (Persona persona in pers)
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Datos de Residencia',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            trailing: Icon(Icons.edit),
                          ),
                          Text(
                            'Provincia: ' + persona.provNombre,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Ciudad: ' + persona.ciudNombre,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Dirección:' + persona.persDireccion,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      //color: Colors.red,
                    ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),
                  // bloque de contacto familiar
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Contacto Familiar',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          trailing: Icon(Icons.edit),
                        ),
                        Text(
                          'Nombres completos:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Celular:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Teléfono convencional:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dirección:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    //color: Colors.green,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),
                  // bloque de historial médico
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Historial Médico',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          trailing: Icon(Icons.edit),
                        ),
                        Text(
                          'Enfermedad:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dosificación:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Medicación:',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    //color: Colors.grey,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),

                  // bloque de codigo QR
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Código QR',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Center(
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 100,
                          ),
                        )
                      ],
                    ),
                    //color: Colors.grey,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
