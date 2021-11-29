import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class RegisterFamiliarPages extends StatelessWidget {
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
                      Text('Ingresa una referencia familiar',
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(height: 10),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => FamiliaProvider(),
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
    final familiaForm = Provider.of<FamiliaProvider>(context);
    return Container(
      child: Form(
        key: familiaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Nombres ',
                  hintText: 'Ingrese el nombre',
                  prefixIcon: Icons.account_box_rounded),
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilNombres = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'El nombre es obligatoria';
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Apellidos ',
                  hintText: 'Ingrese su apellido',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilApellidos = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'El apellido es obligatoria';
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Celular',
                  hintText: 'Ingrese su numero celular',
                  prefixIcon: Icons.phone_android_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilCelular = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'El número celular es obligatoria';
              },
            ),
            /*  SizedBox(height: 20), */
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Convencional',
                  hintText: 'Ingrese su numero convecional',
                  prefixIcon: Icons.add_call),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilConvencional = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'La número convencional es obligatoria';
              },
            ),
            /* SizedBox(height: 20), */
            TextFormField(
              maxLines: null,
              //textCapitalization: TextCapitalization.words,
              autocorrect: true,
              //keyboardType: TextInputType.text,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  prefixIcon: Icons.house_outlined),
              // agrego el valor de las cajas de texto al provider
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilDireccion = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'La la dirección es obligatoria';
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
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  familiaForm.isLoading ? 'Espere..' : "Siguiente",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: familiaForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!familiaForm.isValidForm()) return;
                      familiaForm.isLoading = true;

                      await Future.delayed(Duration(seconds: 1));
                      RespuestaModel respuesta =
                          await familiaForm.registrarFamiliar();
                      print(respuesta.data);

                      Navigator.pushReplacementNamed(context, 'expediente');
                    },
            ),
            Divider(),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.pink,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  "Omitir",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                Navigator.pushReplacementNamed(context, 'expediente');
              },
            ),
          ],
        ),
      ),
    );
  }
}
