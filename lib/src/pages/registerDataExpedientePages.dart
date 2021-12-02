import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:provider/provider.dart';

class RegisterExpedientePages extends StatelessWidget {
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
                      Text('Ingrese su expediente médico',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => ExpedienteProvider(),
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
    // con esta variable puedo ingresar a la instancia de la clase ExpedienteFormProvider
    final expedienteForm = Provider.of<ExpedienteProvider>(context);
    final IdPersonaArguments argUsuario =
        ModalRoute.of(context).settings.arguments;

    return Container(
      child: Form(
        key: expedienteForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // caja de texto para el atributo nombre enfermedad
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Enfermedad',
                  hintText: 'Ingrese su enfermedad',
                  prefixIcon: Icons.medical_services_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider Expediente
              onChanged: (value) =>
                  expedienteForm.managerExpediente.setEnferNombre = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El campo es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de la enfermedad
            TextFormField(
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Describa la enfermedad',
                    hintText: 'Descripción de la enfermedad',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) => expedienteForm
                    .managerExpediente.setEnferDescEnfermedad = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de medicación
            TextFormField(
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Medicación',
                    hintText: 'Usa alguna medicicación',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) => expedienteForm
                    .managerExpediente.setEnferDescMedicacion = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de docificación
            TextFormField(
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Docificación',
                    hintText: 'Usa algun tratamiento',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) => expedienteForm
                    .managerExpediente.setEnferDescDosificacion = value,
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: 30),
            // Sección de boton
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
                  expedienteForm.isLoading ? 'Espere..' : "Finalizar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: expedienteForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!expedienteForm.isValidForm()) return;
                      expedienteForm.isLoading = true;

                      print(argUsuario.persId);
                      expedienteForm.managerExpediente.setPersId =
                          argUsuario.persId;
                      await Future.delayed(Duration(seconds: 2));
                      RespuestaModel respuesta =
                          await expedienteForm.registrarExpediente();
                      print(respuesta.data);

                      Navigator.pushReplacementNamed(context, 'perfil',
                          arguments:
                              IdPersonaArguments(persId: argUsuario.persId));
                    },
            )
          ],
        ),
      ),
    );
  }
}
