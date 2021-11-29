import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/personasArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/inputDecoration.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class RegisterResidenciaPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 150),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Completa tus datos de residencia',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => PersonaProvider(),
                        child: _FormularioRegister(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}

int idPersona;

class _FormularioRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase PersonaProvider y UsuarioProvider
    final personaForm = Provider.of<PersonaProvider>(context);
    final usuarioForm = Provider.of<UsuarioProvider>(context);
    return Container(
      child: Form(
        key: personaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // combobox  para el atributo provincia y ciudades
            FutureBuilderLocalidad(),

            /* BuildersCiudad(), */
            /* SizedBox(height: 20), */
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  prefixIcon: Icons.house_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersDireccion = value,
              validator: (value) {
                return (value != null && value.length > 1)
                    ? null
                    : 'La dirección es obligatoria';
              },
            ),
            SizedBox(height: 30),
            // boton de continuar o siguiente registro
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  /* personaForm.isLoading ? 'Espere' :  */ 'Siguiente',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: personaForm.isLoading
                  ? null
                  : () async {
                      /*  FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!usuarioForm.isValidForm()) return; */
                      /* personaForm.isLoading = true; */
                      // llamo a mis parametros de otras clases como usuario y primera parte de identificacion
                      final IdentidadArguments argPersona =
                          ModalRoute.of(context).settings.arguments;
                      print('..........................');
                      print(argPersona.alias);
                      print(argPersona.correo);
                      print(argPersona.clave);
                      print(argPersona.cedula);
                      print(argPersona.nombres);
                      print(argPersona.apellidos);
                      print(argPersona.fechaNacimiento);
                      print(argPersona.genero);
                      print(argPersona.telefono);
                      print('..........................');

                      // constructor enviando valores a usuario
                      Usuario(
                          usuaAlias: usuarioForm.managerUsuario.setUsuaAlias =
                              argPersona.alias,
                          usuaEmail: usuarioForm.managerUsuario.setUsuaEmail =
                              argPersona.correo,
                          usuaClave: usuarioForm.managerUsuario.setUsuaClave =
                              argPersona.clave);
                      // metodo agregar usuario
                      RespuestaModel usuario =
                          await usuarioForm.registrarUsuario();
                      // deserealizo el valor devuelto por el metodo registrar usuario
                      Map<String, dynamic> user = jsonDecode(usuario.data);
                      print(user['id']);
                      // constructor enviando valores a persona
                      Persona(
                          usuaId: personaForm.managerPersona.setUsuaId =
                              user['id'], // aqui estaba tu string
                          persIdentificacion: personaForm.managerPersona.setPersIdentificacion =
                              argPersona.cedula,
                          persNombres: personaForm.managerPersona.setPersNombres =
                              argPersona.nombres,
                          persApellidos: personaForm.managerPersona.setPersApellidos =
                              argPersona.apellidos,
                          persCelular: personaForm.managerPersona.setPersCelular =
                              argPersona.telefono,
                          persFechaNacimiento:
                              personaForm.managerPersona.setPersFechaNacimiento =
                                  argPersona.fechaNacimiento,
                          persSexo: personaForm.managerPersona.setPersSexo =
                              argPersona.genero,
                          provId: personaForm.managerPersona.setProvId =
                              retornoProvincia, // estaba String
                          ciudId: personaForm.managerPersona.setCiudId =
                              retornoCiudad); // estaba String);

                      // metodo agregar usuario
                      RespuestaModel persona =
                          await personaForm.registrarPersona();
                      Map<String, dynamic> pers = jsonDecode(persona.data);
                      print('.......');
                      print(pers['id']);
                      idPersona = pers['id'];
                      print('......');
                      await Future.delayed(Duration(seconds: 2));
                      Navigator.pushReplacementNamed(
                        context,
                        'perfil',
                        arguments: IdPersonaArguments(persId: pers['id']),
                      );
                    },
            )
          ],
        ),
      ),
    );
  }
}

final idPers = idPersona;
