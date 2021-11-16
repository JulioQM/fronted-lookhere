import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/pages/exportPages.dart';

void main() => runApp(MyApp());

// USO DE STATELESWIDGET YA QUE SON ELEMENTOS DINAMICOS
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bienvenidos al LookHere',
      // en este apartado inicializo cual va hacer la pantalla principal
      initialRoute: 'login',
      // en esta apartado se encuentras rutas de las paginas existentes, la cual permitira direccionarnos a las diferentes paginas
      routes: {
        'login': (_) => LoginPages(),
        'usuario': (_) => RegisterUsuarioPages(),
        'register': (_) => RegisterPages(),
        'residencia': (_) => RegisterResidenciaPages(),
        'familiar': (_) => RegisterFamiliarPages(),
        'historial_clinico': (_) => RegisterMedicacionPages(),
        'home': (_) => HomePages(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
