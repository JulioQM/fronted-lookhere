import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/pages/exportPages.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class RegisterIdentidadPages extends StatelessWidget {
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
                      Text('Completa tus datos personales',
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
    final personaForm = Provider.of<PersonaProvider>(context);
    return Container(
      child: Form(
        key: personaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Nombres',
                  hintText: 'Ingrese su nombre',
                  prefixIcon: Icons.account_box_rounded),
              onChanged: (value) =>
                  personaForm.managerPersona.setPersNombres = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese su apellido',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersApellidos = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Cédula',
                  hintText: 'Ingrese su cedula',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersIdentificacion = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Teléfono celular',
                  hintText: 'Ingrese su numero celular',
                  prefixIcon: Icons.add_call),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersCelular = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Fecha de nacimiento',
                  hintText: ' Ingrese su fecha de nacimiento',
                  prefixIcon: Icons.date_range_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersFechaNacimiento = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Género',
                  hintText: '',
                  prefixIcon: Icons.accessibility),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersSexo = value,
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
                  "Continuar registro",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'residencia');

                print(idUsuario);
              },
            )
          ],
        ),
      ),
    );
  }
}
