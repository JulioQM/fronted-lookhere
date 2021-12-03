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
    final familForm = Provider.of<FamiliaProvider>(context);
    final expForm = Provider.of<ExpedienteProvider>(context);
    final IdPersonaArguments argPersona =
        ModalRoute.of(context).settings.arguments;
    return Container(
      margin: EdgeInsets.all(9),
      child: ListView(
        children: [
          FutureBuilder<List<Persona>>(
            future: persForm.getListaPersona(argPersona.persId),
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
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Datos Personales',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            leading: Icon(Icons.people_alt_outlined),
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
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Datos de Residencia',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            leading: Icon(Icons.house_outlined),
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

                  /// punto de roptura del future builder persona
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),
                  // bloque de contacto familiar
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder<List<Familiar>>(
                        future: familForm.getListaFamiliar(
                            busqueda: argPersona.persId),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Familiar>> snapshot) {
                          List<Familiar> famil = snapshot.data ?? [];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  'Contacto Familiar',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                leading: Icon(Icons.account_box_outlined),
                                trailing: Icon(Icons.edit),
                              ),
                              for (Familiar familia in famil)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nombres completos:' +
                                          familia.familNombres,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Celular: ' + familia.familCelular,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Teléfono convencional: ' +
                                          familia.familConvencional,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Dirección: ' + familia.familDireccion,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                            ],
                          );
                        }),
                    //color: Colors.green,
                  ),

                  /// punto de roptura del future builder familiar
                  Divider(
                    thickness: 1.5,
                    color: Colors.indigo,
                  ),
                  // bloque de historial médico
                  Container(
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder<List<Enfermedad>>(
                      future: expForm.getListaExpediente(
                          busqueda: argPersona.persId),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Enfermedad>> snapshot) {
                        List<Enfermedad> exp = snapshot.data ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                'Historial Médico',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              leading: Icon(Icons.history),
                              trailing: Icon(Icons.edit),
                            ),
                            for (Enfermedad expediente in exp)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enfermedad: ' + expediente.enferNombre,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Enfermedad: ' +
                                        expediente.enferDescEnfermedad,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Dosificación: ' +
                                        expediente.enferDescDosificacion,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Medicación: ' +
                                        expediente.enferDescMedicacion,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              )
                          ],
                        );
                      },
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
          ), //aqui viene otro future familiar
        ],
      ),
    );
  }
}
