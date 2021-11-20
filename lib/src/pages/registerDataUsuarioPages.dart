import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

var idUsuario = '';

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
                      Text('Completa tus credenciales',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10),
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
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final usuarioForm = Provider.of<UsuarioProvider>(context, listen: true);
    return Container(
      child: Form(
        key: usuarioForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Nombre de usuario',
                  hintText: 'Ingrese su nombre de usuario',
                  prefixIcon: Icons.account_box_rounded),
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaAlias = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Correo Electrónico',
                  hintText: 'example@hotmail.com',
                  prefixIcon: Icons.attach_email_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaEmail = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Password',
                  hintText: '**********',
                  prefixIcon: Icons.lock_outline),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaClave = value,
            ),
            SizedBox(height: 20),
            /* TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Repita su Password',
                  hintText: '**********',
                  prefixIcon: Icons.lock_open_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) => loginForm.password = value,
            ), */
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
                    "Continuar registro",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'identidad');
                }

                /* () async {
                RespuestaModel respuesta = await usuarioForm.registrarUsuario();
                print(respuesta.data);
                idUsuario = respuesta.data;
                (respuesta.success)
                    ? Navigator.pushReplacementNamed(context, 'register')
                    : print(respuesta.mensaje);
              }, */
                )
          ],
        ),
      ),
    );
  }
}

final idusuario = idUsuario;
