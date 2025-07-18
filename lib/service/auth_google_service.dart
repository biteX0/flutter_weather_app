import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather/snackbar_error_messages/barrel_file_snackbar.dart';

class AuthGoogleService {
  singInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      SnackbarManager.showAppSnackBar(
        PredefinedMessage(SnackBarMessages.userNotFound),
      );
    }
  }
}
