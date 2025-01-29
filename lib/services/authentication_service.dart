import 'dart:convert';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/authentication_model.dart';
import '../common/exceptions/app_exception.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    hostedDomain: '',
    clientId:
        "709863071057-sm7n5e292lr82g5fjjj4teea5dmmuh3g.apps.googleusercontent.com",
  );

  Future<AuthenticationModel?> signIn(
    String email,
    String password,
  ) async {
    try {
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/sign-in");

      var response = await post(
        apiUrl,
        headers: header(false),
        body: {
          "email": email,
          "password": password,
        },
      );

      var jsonObject = jsonDecode(response.body);

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      log("Error sign in service: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }

  Future<AuthenticationModel?> signInWithGoogle() async {
    try {
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/google-sign-in");
      await _googleSignIn.signIn().then((result) {
        result?.authentication.then((googleKey) async {
          var response = await post(
            apiUrl,
            headers: header(false),
            body: {
              "idToken": googleKey.idToken,
            },
          );

          var jsonObject = jsonDecode(response.body);

          log(response.toString());

          return AuthenticationModel.fromJson(jsonObject);
        }).catchError((e) {
          throw AppException("$e");
        });
      }).catchError((e) {
        throw AppException("$e");
      });

      // if (googleUser == null) {
      //   throw AppException("Google sign-in dibatalkan oleh pengguna.");
      // }

      // final GoogleSignInAuthentication googleAuthentication =
      //     await googleUser.authentication;

      // log("Google User: ${googleUser.email}");
      // log("Google Auth: ${googleAuthentication.toString()}");

      // if (googleAuthentication.idToken == null) {
      //   throw AppException("Gagal mendapatkan ID Token dari Google.");
      // }

      // log("Google Auth Id Token: ${googleAuthentication.idToken}");

      // var response = await post(
      //   apiUrl,
      //   headers: header(false),
      //   body: {
      //     "idToken": googleAuthentication.idToken,
      //   },
      // );

      // var jsonObject = jsonDecode(response.body);

      // log(response.toString());

      // return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      log("Error sign in with google service: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
    return null;
  }
}
