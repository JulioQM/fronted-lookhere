 /* Future<bool> autenticacion() async {
    print('$alias ----entrando---- $password');
    var url = Uri.https(path.rutaEndPoint, path.pathAutenticacion);
    print(url);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"usua_alias": alias, "usua_clave": password}));
    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  } */


  
/* GestureDetector(
                child: itemAjustes('BOTÓN PARA PRUEBAS', Icons.gamepad),
                onTap: () async {
                  RespuestaModel respuesta =
                      await UserServices().autentiacion();

                  if (respuesta.success!) {
                    print(respuesta.mensaje);
                    // nevgar a otra pantalla

                  } else {
                    print(respuesta.mensaje);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(respuesta.mensaje!),
                    ));


                    // respuesta.data
                    // mostarr un snacbar
                  }
                }),
 */