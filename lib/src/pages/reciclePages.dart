// login
import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/loginFormProvider.dart';
import 'package:fronted_lookhere/src/provider/provinciaProvider.dart';
import 'package:fronted_lookhere/src/utils/textButton.dart';
import 'package:fronted_lookhere/src/utils/inputDecoration.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPage> {
  Provincia miprovincia;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProvinciaProvider>(context, listen: true);

    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                /*   SizedBox(height: 250), */
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
                        create: (_) => LoginFormProvider(),
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
    final loginForm = Provider.of<LoginFormProvider>(context, listen: true);

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
                    labelText: 'Correo Electrónico',
                    hintText: 'example@hotmail.com',
                    prefixIcon: Icons.attach_email),
                onChanged: (value) => loginForm.email = value,
                /* validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'No valor ingresado no luce como un correo valido';
                }, */
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
                onChanged: (value) => loginForm.password = value,
                /*  validator: (value) {
                  if (value != null && value.length >= 6) {
                    return null;
                  } else {
                    return 'La contraseña debe de tener mas de 6 caracteres';
                  }
                }, */
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
                    loginForm.isLoading ? 'Espere..' : "Ingresar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        //quitar teclado para que no este clikeando
                        FocusScope.of(context).unfocus();
                        //TODO login
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;

                        await Future.delayed(Duration(seconds: 10));
                        // TODO validar si el correo es correo
                        loginForm.isLoading = false;
                        // Navigator.pushReplacementNamed(context, 'home');

                        bool verificacionBandera =
                            await loginForm.autenticacion();

                        if (verificacionBandera) {
                          Navigator.pushReplacementNamed(context, "home");
                        } else
                          return;

                        print(loginForm.email + '......' + loginForm.password);
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
