
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth; // SOLUCIÓN AL CONFLICTO DE NOMBRES
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forms_app/domain/datasources/auth_datasource.dart';
import 'package:forms_app/domain/entities/user_entity.dart'; // Usamos tu entidad

class FirebaseAuthDatasource extends AuthDataSource {
  
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SOLUCIÓN AL ERROR DE CONSTRUCTOR: 
  // Según el código que pasaste, se usa '.instance' porque el constructor es privado.
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<UserEntity?> getCurrentUser() async {
    // Usamos el prefijo 'firebase_auth' para evitar confusión con tu UserEntity
    final firebase_auth.User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    final doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    return UserEntity(
      uid: firebaseUser.uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'student',
      enrollment: data['matricula'],
    );
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
  try {
    // 1. Inicializar e iniciar flujo interactivo
    await _googleSignIn.initialize();
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    // 2. Obtener el idToken (Autenticación)
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // 3. Obtener el accessToken (Autorización) - AQUÍ ESTÁ EL CAMBIO
    final authz = await googleUser.authorizationClient.authorizeScopes(['email']);

    // 4. Crear la credencial para Firebase
    final firebase_auth.AuthCredential credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: authz.accessToken, // Usamos el token de la autorización
      idToken: googleAuth.idToken,   // Usamos el token de la autenticación
    );

    // 5. Iniciar sesión en Firebase
    final firebase_auth.UserCredential userCredential = await _auth.signInWithCredential(credential);
    final firebase_auth.User? user = userCredential.user;

    if (user == null) throw Exception('No se pudo obtener el usuario de Firebase');

    // --- EL RESTO DE TU LÓGICA DE FIRESTORE SE MANTIENE IGUAL ---
    final whitelistDoc = await _firestore.collection('whitelist').doc(user.email).get();
    final String role = whitelistDoc.exists ? 'professor' : 'student';

    final userDocRef = _firestore.collection('users').doc(user.uid);
    final userDoc = await userDocRef.get();

    if (userDoc.exists) {
      final data = userDoc.data()!;
      return UserEntity(
        uid: user.uid,
        name: data['name'] ?? user.displayName ?? '',
        email: data['email'] ?? user.email ?? '',
        role: data['role'] ?? role,
        enrollment: data['matricula'],
      );
    } else {
      await userDocRef.set({
        'name': user.displayName,
        'email': user.email,
        'role': role,
        'matricula': null,
      });

      return UserEntity(
        uid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        role: role,
        enrollment: null,
      );
    }
  } catch (e) {
    print("Error en Datasource: $e");
    rethrow;
  }
}

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}