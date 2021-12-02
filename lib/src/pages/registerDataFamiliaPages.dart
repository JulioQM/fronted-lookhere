import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
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
    // con esta variable puedo ingresar a la instancia de la clase FamiliarProvider
    final familiaForm = Provider.of<FamiliaProvider>(context);
    final IdPersonaArguments argUsuario =
        ModalRoute.of(context).settings.arguments;
    return Container(
      child: Form(
        key: familiaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // caja de texto para el nombres
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Nombres ',
                  hintText: 'Ingrese el nombre',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto a las propiedades del provider Familiar
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilNombres = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El nombre es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo apellido
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Apellidos ',
                  hintText: 'Ingrese su apellido',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto a las propiedades del provider Familiar
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilApellidos = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El apellido es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo celular
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Celular',
                  hintText: 'Ingrese su numero celular',
                  prefixIcon: Icons.phone_android_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider Familiar
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilCelular = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? validaciones.validarNumero(numero: value)
                    : 'El número celular es obligatoria';
              },
            ),

            // caja de texto para el atributo convencional
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Convencional',
                  hintText: 'Ingrese su numero convecional',
                  prefixIcon: Icons.add_call),
              // agrego el valor de las cajas de texto a las propiedades del provider Familiar
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilConvencional = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? validaciones.validarNumero(numero: value)
                    : 'La número convencional es obligatoria';
              },
            ),

            // caja de texto para el atributo dirección
            TextFormField(
              maxLines: null,
              autocorrect: true,
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  prefixIcon: Icons.house_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider Familiar
              onChanged: (value) =>
                  familiaForm.managerFamiliar.setFamilDireccion = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'La la dirección es obligatoria';
              },
            ),
            SizedBox(height: 30),
            // sección de boton
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

                      familiaForm.managerFamiliar.setPersId = argUsuario.persId;
                      await Future.delayed(Duration(seconds: 2));
                      RespuestaModel respuesta =
                          await familiaForm.registrarFamiliar();
                      print(respuesta.data);
                      Navigator.pushReplacementNamed(context, 'expediente',
                          arguments:
                              IdPersonaArguments(persId: argUsuario.persId));
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
