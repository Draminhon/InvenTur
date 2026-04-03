import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SecureStorageService._internal();

  /// Escreve uma String de forma segura.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Lê uma String de forma segura.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Grava um valor inteiro convertendo para String.
  Future<void> setInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  /// Lê um valor inteiro convertendo da String salva.
  Future<int?> getInt(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  /// Deleta uma chave específica.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Limpa TODO o armazenamento seguro.
  Future<void> clearAll() async {
    await _storage.deleteAll();
    // Limpamos o SharedPreferences antigo uma única vez para não deixar rastros
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Verifica se uma chave existe.
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
