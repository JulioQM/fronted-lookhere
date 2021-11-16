import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/provider/loginFormProvider.dart';
import 'package:provider/provider.dart';

import 'package:fronted_lookhere/src/utils/inputDecoration.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';

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
                        create: (_) => LoginFormProvider(),
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

class _FormularioRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Provincia',
                  hintText: 'Ingrese la provincia',
                  prefixIcon: Icons.person_pin_circle_outlined),
              onChanged: (value) => loginForm.email = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Ciudad actual',
                  hintText: 'Ingrese su ciudad',
                  prefixIcon: Icons.person_pin_circle_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) => loginForm.password = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  prefixIcon: Icons.house_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) => loginForm.password = value,
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
                  'Continuar registro',
                  /*  loginForm.isLoading ? 'Espere..' : "Ingresar", */
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'familiar');
              },
              /* onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      //quitar teclado para que no este clikeando
                      FocusScope.of(context).unfocus();
                      //TODO login
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;

                      await Future.delayed(Duration(seconds: 2));
                      // TODO validar si el correo es correo
                      loginForm.isLoading = false;
                      Navigator.pushReplacementNamed(context, 'home');
                    }, */
            )
          ],
        ),
      ),
    );
  }
}
