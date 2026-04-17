import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:forms_app/domain/datasources/auth_datasource.dart';

class FirebaseAuthDatasource extends AuthDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // CAMBIO 1: Usar la instancia estática en lugar del constructor
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Reemplaza esto con el ID que copiaste de Firebase
      const String webClientId =
          '894417417950-u5rfvog3u5pdfk4jn6amnhdt6q6t6esg.apps.googleusercontent.com';

      await _googleSignIn.initialize(
        serverClientId:
            webClientId, // <--- Esto es lo que el error te está pidiendo
      );

      final GoogleSignInAccount? googleUser =
          await _googleSignIn.authenticate();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Para obtener el accessToken en v7+
      final authz = await googleUser.authorizationClient.authorizeScopes([
        'email'
        ]);

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authz.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Error detallado en el Datasource: $e");
      rethrow; // Re-lanzamos para que el catch de la UI también lo vea
    }
  }
}
