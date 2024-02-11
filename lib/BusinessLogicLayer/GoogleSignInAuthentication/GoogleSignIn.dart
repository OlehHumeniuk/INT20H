import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // Добавьте другие scopes, которые вам нужны
  ],
);


Future<String?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    return googleSignInAuthentication.accessToken; // Это ваш Google Access Token
  } catch (error) {
    print(error);
    return null;
  }
}

Future<void> sendTokenToServer(String token) async {
  const String url = 'https://127.0.0.1:5000'; // URL сервера
  final response = await http.post(
    Uri.parse(url),
    body: {'token': token},
  );

  if (response.statusCode == 200) {
    // Успешная аутентификация
  } else {
    // Обработка ошибок
  }
}
