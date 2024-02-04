import 'package:dio/dio.dart';

class API {
  final Dio dio = Dio();
  final String baseUrl = "https://key1.tech/api";
  login({required String username, required String password}) async {
    try {
      final String endPoint = "$baseUrl/login";

      final params = {
        "email": username,
        "password": password,
      };

      final response = await dio.post(endPoint, data: FormData.fromMap(params));
      return response.data;
    } catch (e) {
      return e;
    }
  }

  register(
      {required String username,
      required String password,
      required String name,
      required int programId}) async {
    try {
      final String endPoint = "$baseUrl/register";

      final params = {
        "name": name,
        "email": username,
        "password": password,
        "password_confirmation": password,
        "program_id": programId,
      };

      final response = await dio.post(endPoint, data: FormData.fromMap(params));
      return response.data;
    } catch (e) {
      return e;
    }
  }

  getPrograms() async {
    try {
      final String endPoint = "$baseUrl/programs";

      final response = await dio.post(endPoint);
      return response.data;
    } catch (e) {
      return e;
    }
  }
}
