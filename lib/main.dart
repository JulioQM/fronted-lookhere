import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/pages/exportPages.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppStage());

class AppStage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // para mucho provedores de informacion
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => ProvinciaProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => CiudadProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => FamiliaProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => PersonaProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ExpedienteProvider(),
          lazy: true,
        ),
      ],
      child: MyApp(),
    );
  }
}

// USO DE STATELESWIDGET YA QUE SON ELEMENTOS DINAMICOS
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('es', 'ES'), // Spanish, no country code
      ],
      title: 'Bienvenidos al LookHere',
      // en este apartado inicializo cual va hacer la pantalla principal
      initialRoute: 'login',
      // en esta apartado se encuentras rutas de las paginas existentes, la cual permitira direccionarnos a las diferentes paginas
      routes: {
        'login': (_) => LoginPages(),
        'usuario': (_) => RegisterUsuarioPages(),
        'identidad': (_) => RegisterIdentidadPages(),
        'residencia': (_) => RegisterResidenciaPages(),
        'familiar': (_) => RegisterFamiliarPages(),
        'expediente': (_) => RegisterExpedientePages(),
        'home': (_) => HomePages(),
        'perfil': (_) => PerfilPages(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
