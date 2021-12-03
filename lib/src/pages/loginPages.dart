import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class LoginPages extends StatelessWidget {
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
                      Text('Login',
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 30),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => LoginProvider(),
                        child: _FormularioLogin(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                TextButtons.etiquetaTextButton(
                    titulo: 'Crear una nueva cuenta',
                    direccionamientoPagina: 'usuario',
                    context: context),
                SizedBox(height: 50)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final loginForm = Provider.of<LoginProvider>(context, listen: true);
    return Container(
      child: Form(
          key: loginForm.formKey,
          // activar validacion en modo de interación con la pantalla
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(), //agrega @ en teclado
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Usuario',
                    hintText: 'Ingrese el usuario',
                    prefixIcon: Icons.person_outline),
                onChanged: (value) =>
                    loginForm.managerUsuario.setUsuaAlias = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El usuario es obligatoria';
                },
              ),
              // bloque de repeticion de contraseña
              SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Password',
                    hintText: '**********',
                    prefixIcon: Icons.lock_outline),
                // agrego el valor de las cajas de texto en las propiedades del provider
                onChanged: (value) =>
                    loginForm.managerUsuario.setUsuaClave = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'La contraseña es obligatoria';
                },
              ),
              SizedBox(height: 30),
              // boton con acción de ingresar
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
                    loginForm.isLoading ? 'Espere' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus(); // bloquea mi boton
                        if (!loginForm.isValidForm()) return;
                        RespuestaModel respuesta =
                            await loginForm.autentiacion();

                        if (respuesta.success ?? true) {
                          // si es correcto me navegara a la pantalla principal
                          loginForm.isLoading = true;
                          Map<String, dynamic> userId =
                              jsonDecode(respuesta.data);
                          print(userId);
                          print(respuesta.data);
                          print(respuesta.mensaje);
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.pushReplacementNamed(
                            context,
                            'home',
                            arguments: UsuarioIdArguments(
                              idUsuario: userId['usua_id'],
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(respuesta.mensaje),
                          ));
                        }
                      },
              ),

              SizedBox(height: 30),
              TextButtons.etiquetaTextButton(
                  titulo: 'Ingresar como administrador',
                  /* direccionamientoPagina: 'home', */
                  direccionamientoPagina: 'login',
                  context: context),
            ],
          )),
    );
  }
}
