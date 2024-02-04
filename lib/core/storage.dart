import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  loadUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var id = storage.getInt("id");
    var name = storage.getString("name");
    var phone = storage.getString("phone");
    var email = storage.getString("eamil");

    if (id == null) {
      return null;
    } else {
      return {"id": id, "name": name, "phone": phone, "email": email};
    }
  }

  saveUser({
    required int id,
    required String name,
    required String email,
    required String phone,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt("id", id);
    storage.setString("name", name);
    storage.setString("email", email);
    storage.setString("phone", phone);
  }

  saveToken(String token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "token", value: token);
  }

  loadToken() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "token");
    return token;
  }

  clearUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final securestorage = new FlutterSecureStorage();
    await storage.remove("id");
    await storage.remove("name");
    await storage.remove("phone");
    await storage.remove("email");
    await securestorage.delete(key: "token");
  }
}
