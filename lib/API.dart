import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

Future<String> getStatus() async {
  http.Response resonse =
      await http.get(Uri.parse('${globals.URL_BACKEND}/status'));
  if (resonse.statusCode == 404) {
    return 'nothing found';
  }
  print(resonse.statusCode);
  return resonse.body;
}

Future<String> getInt(int VALOR) async {
  final uri = Uri.http(globals.ADDRESS_API, 'teste/${VALOR.toString()}');
  print(uri.toString());
  http.Response resonse = await http.get(uri);
  print(resonse.statusCode);

  if (resonse.statusCode == 404) {
    return 'nothing found';
  }
  print(resonse.statusCode);
  return resonse.body;
}

Future<String> getString1(String VALOR) async {
  final uri = Uri.http(globals.ADDRESS_API, 'teste/${VALOR}');
  print(uri.toString());
  http.Response resonse = await http.get(uri);
  if (resonse.statusCode == 404) {
    return 'nothing found';
  }
  print(resonse.statusCode);
  return resonse.body;
}
