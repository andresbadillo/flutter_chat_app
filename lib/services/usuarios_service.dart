import 'package:http/http.dart' as http;

import 'package:chat_real_time_app/services/auth_service.dart';
import 'package:chat_real_time_app/global/environment.dart';
import 'package:chat_real_time_app/models/usuarios_response.dart';
import 'package:chat_real_time_app/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      String? token = await AuthService.getToken();
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');

      final resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString(),
        },
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
