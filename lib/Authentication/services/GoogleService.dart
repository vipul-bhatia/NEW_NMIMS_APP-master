import 'package:auth/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService{
  signInWithGoogle() async{
    //Begin interactive sign-in process
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    //Obtain auth details from the request
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    //finally lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}