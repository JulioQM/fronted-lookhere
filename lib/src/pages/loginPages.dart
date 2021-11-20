import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class LoginPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 200),
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
                /* SizedBox(height: 50), */
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
          // activar validacion en modo de interacion
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                style: TextStyle(), //agrega @ en teclado
                decoration: InputDecorations.loginInputDecoration(
                    labelText: 'Alias',
                    hintText: 'nick',
                    prefixIcon: Icons.person_outline),
                onChanged: (value) =>
                    loginForm.managerUsuario.setUsuaAlias = value,
              ),
              SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.loginInputDecoration(
                    labelText: 'Password',
                    hintText: '**********',
                    prefixIcon: Icons.lock_outline),
                // agrego el valor de las cajas de texto al provider
                onChanged: (value) =>
                    loginForm.managerUsuario.setUsuaClave = value,
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
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    "Ingresar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  RespuestaModel respuesta = await loginForm.autentiacion();
                  if (respuesta.success ?? true) {
                    print(respuesta.mensaje);
                    // si es correcto me navegara a la pantalla principal
                    await Future.delayed(Duration(seconds: 3));
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    print(respuesta.mensaje);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(respuesta.mensaje),
                    ));
                  }
                },
              ),
              SizedBox(height: 30),
              TextButtons.etiquetaTextButton(
                  titulo: 'Ingresar como administrador',
                  direccionamientoPagina: 'usuario',
                  context: context),
            ],
          )),
    );
  }
}
