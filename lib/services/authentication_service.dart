import 'dart:convert';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:stones_classifier/common/constant.dart';
import 'package:stones_classifier/models/authentication_model.dart';
import 'package:stones_classifier/models/generic_response_model.dart';
import '../common/exceptions/app_exception.dart';

class AuthenticationService {
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

      if (response.statusCode == 200) {
        await storage.write(key: "token", value: jsonObject['data']);
        await storage.write(key: "email", value: email);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      log("Error sign in service: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }

  Future<AuthenticationModel?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/google-sign-in");
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google sign-in dibatalkan oleh pengguna.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      var response = await post(
        apiUrl,
        headers: header(false),
        body: {
          "idToken": googleAuth.idToken.toString(),
        },
      );

      var jsonObject = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await storage.write(key: "token", value: jsonObject['data']);
        await storage.write(key: "email", value: googleUser.email);
      }

      return AuthenticationModel.fromJson(jsonObject);
    } catch (e) {
      log("Error sign in with google service: $e");
      throw AppException("Terjadi kesalahan saat masuk. Silakan coba lagi.");
    }
  }

  Future<GenericResponseModel?> requestOtp(String email) async {
    try {
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/request-otp");
      var response = await post(
        apiUrl,
        headers: header(false),
        body: {
          "email": email,
        },
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => null,
      );
    } catch (e) {
      log("Error request otp service: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }

  Future<GenericResponseModel?> validateOtp(
    String email,
    String otp,
  ) async {
    try {
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/validate-otp");
      var response = await post(
        apiUrl,
        headers: header(false),
        body: {
          "email": email,
          "otp": otp,
        },
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => null,
      );
    } catch (e) {
      log("Error validate otp service: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }

  Future<GenericResponseModel?> changePassword(
    String email,
    String password,
  ) async {
    try {
      Uri apiUrl = Uri.parse("${baseApiUrl()}/authentication/forgot-password");
      var response = await post(
        apiUrl,
        headers: header(false),
        body: {
          "email": email,
          "password": password,
        },
      );

      var jsonObject = jsonDecode(response.body);

      return GenericResponseModel.fromJson(
        jsonObject,
        (data) => null,
      );
    } catch (e) {
      log("Error change password service: $e");
      throw AppException(
          "Terjadi kesalahan saat memuat data. Silakan coba lagi.");
    }
  }
}
