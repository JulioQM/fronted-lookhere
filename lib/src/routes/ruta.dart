// ruta del endpoint
class EndPoints {
  // ruta padre
  String rutaEndPoint = 'api-rest-lookhere-produccion.herokuapp.com';
  // ruta de acceso
  String pathAutenticacion = '/api/autenticacion/login';
  String pathUsuario = '/api/lookhere/usuario';
  String pathPersona = '/api/lookhere/persona/';
  String pathEnfermedad = '/api/lookhere/enfermedad';
  String pathProvincia = '/api/lookhere/provincia/';
  String pathCiudad = '/api/lookhere/ciudad/';
  String pathFamiliar = '/api/lookhere/familiar';

  // ruat de consulta
  String pathPersonaJoin = '/api/lookhere/personaJoin/';
  // ruta de prueba
  String pathPersonaIdentidad = '/api/lookhere/personaIdentidad';
  // Validadores
  String pathUsuarioValidador = '/api/lookhere/validarUsuario';
  String pathPersonaValidador = '/api/lookhere/validarPersona';
}

final path = new EndPoints();
