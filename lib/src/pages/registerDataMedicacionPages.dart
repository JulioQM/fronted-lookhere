import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/inputDecoration.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class RegisterMedicacionPages extends StatelessWidget {
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
                      Text('Completa tus datos médicos',
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
                  labelText: 'Medicación',
                  hintText: 'Usa alguna medicicación',
                  prefixIcon: Icons.medical_services_outlined),
              onChanged: (value) =>
                  personaForm.managerPersona.setPersDescMedicacion = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Docificación',
                  hintText: 'Usa algun tratamiento',
                  prefixIcon: Icons.medical_services_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersDescDosificacion = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              decoration: InputDecorations.loginInputDecoration(
                  labelText: 'Enfermedad',
                  hintText: 'Tiene alguna enfermedad',
                  prefixIcon: Icons.medical_services_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  personaForm.managerPersona.setPersDescEnfermedad = value,
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
                  'Finalizar registro',
                  /*  loginForm.isLoading ? 'Espere..' : "Ingresar", */
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            )
          ],
        ),
      ),
    );
  }
}
