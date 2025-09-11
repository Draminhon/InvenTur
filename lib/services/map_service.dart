import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

// Modelo para armazenar as informações do local de forma estruturada
class LugarInfo {
  final LatLng coordenadas;
  final String rua;
  final String bairro;
  final String cidade;
  final String estado;
  final String pais;
  final String displayName;

  LugarInfo({
    required this.coordenadas,
    this.rua = 'N/A',
    this.bairro = 'N/A',
    this.cidade = 'N/A',
    this.estado = 'N/A',
    this.pais = 'N/A',
    this.displayName = 'Nenhuma informação encontrada.',
  });

  // Factory constructor para criar uma instância a partir do JSON da API Mapbox
  factory LugarInfo.fromMapboxJson(
      Map<String, dynamic> json, LatLng originalPoint) {
    // CORREÇÃO CRÍTICA: O campo 'context' está no nível superior do 'feature', não dentro de 'properties'.
    // Esta era a causa principal de os campos virem vazios.
    final context = json['context'] ?? [];
    final properties = json['properties'] ?? {};

    // Função auxiliar para procurar um tipo de informação no array de 'context'.
    String findInContext(String key) {
      for (var item in (context as List)) {
        if ((item['id'] as String).startsWith(key)) {
          return item['text'] ?? '';
        }
      }
      return '';
    }

    // Lógica melhorada para determinar a rua.
    // Se o resultado principal for um endereço ('id' começa com 'address'), o 'text' é o nome da rua.
    // Senão, procuramos por uma rua no 'context'.
    String rua = '';
    final featureId = json['id'] as String? ?? '';
    if (featureId.startsWith('address')) {
      rua = json['text'] ?? 'N/A';
    } else {
      rua = findInContext('address');
    }

    return LugarInfo(
      coordenadas: originalPoint,
      displayName: json['place_name'] ??
          json['text'] ??
          'Nenhuma informação encontrada.',
      rua: rua.isNotEmpty ? rua : 'N/A',
      bairro: findInContext('neighborhood'),
      cidade: findInContext(
          'place'), // A cidade é quase sempre encontrada no contexto como 'place'.
      estado: findInContext('region'),
      pais: findInContext('country'),
    );
  }
}

// Exceção personalizada para erros de localização
class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);
}

// Classe de serviço para encapsular a lógica de localização e API
class MapService {
  final String mapboxAccessToken;

  MapService({required this.mapboxAccessToken});

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceException(
          'Serviços de localização estão desabilitados. Por favor, ative o GPS.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationServiceException('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationServiceException(
          'Permissão de localização negada permanentemente. Por favor, habilite nas configurações do aplicativo.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Stream<Position> getPositionStream() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<LugarInfo> getInfoFromCoordinates(LatLng point) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${point.longitude},${point.latitude}.json?access_token=$mapboxAccessToken&types=poi,address,neighborhood,place,region,country');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final features = data['features'] as List;
        if (features.isNotEmpty) {
          return LugarInfo.fromMapboxJson(features.first, point);
        } else {
          throw Exception(
              'Nenhum resultado encontrado para estas coordenadas.');
        }
      } else {
        throw Exception('Erro ao buscar informações do servidor Mapbox.');
      }
    } catch (e) {
      throw Exception('Erro de conexão ao buscar informações: $e');
    }
  }
}
