import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/usuariosArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class RegisterUsuarioPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 120),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Crear Cuenta',
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 20),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => UsuarioProvider(),
                        child: _FormularioRegister(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextButtons.etiquetaTextButton(
                  titulo: '¿Ya tienes una cuenta?',
                  direccionamientoPagina: 'login',
                  context: context,
                ),
                SizedBox(height: 50)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FormularioRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase UsuarioProvider
    final usuarioForm = Provider.of<UsuarioProvider>(context, listen: true);
    return Container(
      child: Form(
        key: usuarioForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // caja de texto para el atributo nombre usuario
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Nombre de usuario',
                  hintText: 'Ingrese su nombre de usuario',
                  prefixIcon: Icons.account_box_rounded),
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaAlias = value,
              validator: (value) {
                return (value != null && value.length > 1)
                    ? null
                    : 'La nombre de usuario es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo email
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'example@hotmail.com',
                    prefixIcon: Icons.attach_email_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Usuario
                onChanged: (value) =>
                    usuarioForm.managerUsuario.setUsuaEmail = value,
                validator: (value) {
                  if (value != null && value.length > 5) {
                    return validaciones.validarEmail(value);
                  }
                  return 'El correo es obligatorio';
                }),
            SizedBox(height: 20),
            // caja de texto para el atributo contraseña o clave
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Contraseña',
                  hintText: '**********',
                  prefixIcon: Icons.lock_outline),
              // agrego el valor de las cajas de texto a las propiedades del provider Usuario
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaClave = value,
              validator: (value) {
                return (value != null && value.length > 1)
                    ? null
                    : 'La contraseña es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // Caja de texto que va ha permitir la validación de la clave(simulación)
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Repita la contraseña',
                  hintText: '**********',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => value,
              validator: (value) {
                var verificador = usuarioForm.managerUsuario.getUsuaClave;
                return (value != null && value.length > 1)
                    ? validaciones.validarClave(
                        clave: verificador, claveRepetida: value)
                    : 'La contraseña es obligatoria';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  usuarioForm.isLoading ? 'Espere' : 'Siguiente',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: usuarioForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!usuarioForm.isValidForm()) return; // validacíon
                      RespuestaModel respuesta =
                          await usuarioForm.validarUsuario();
                      if (respuesta.success ?? true) {
                        // la sentencia de abajo sirve para decodificar el json de la data
                        Map<String, dynamic> user = jsonDecode(respuesta.data);
                        print(user['body']);
                        usuarioForm.isLoading = true;
                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushReplacementNamed(
                          context,
                          'identidad',
                          arguments: UsuariosArguments(
                            nombre: user['body']['usua_alias'],
                            correo: user['body']['usua_email'],
                            /*  clave: user['body']['usua_alias'], */
                            clave: user['body']['usua_clave'],
                          ),
                        );
                      } else {
                        // https://programmerclick.com/article/7085843645/
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              respuesta.mensaje,
                              textAlign: TextAlign.center,
                            ),
                            /*  backgroundColor: Colors.indigo, */
                          ),
                        );
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
