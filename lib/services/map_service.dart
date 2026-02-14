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


  Map<String, dynamic> toMap(){
    return {
      'latitude': coordenadas.latitude,
      'longitude': coordenadas.longitude,
      'displayName': displayName,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'pais': pais
    };
  }

  factory LugarInfo.fromMapboxJson(
      Map<String, dynamic> json, LatLng originalPoint) {
    final context = json['context'] ?? [];
    final properties = json['properties'] ?? {};

    String findInContext(String key) {
      for (var item in (context as List)) {
        if ((item['id'] as String).startsWith(key)) {
          return item['text'] ?? '';
        }
      }
      return '';
    }

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
          'place'), 
      estado: findInContext('region'),
      pais: findInContext('country'),
    );
  }
}

class LocationServiceException implements Exception {
  final String message;
  LocationServiceException(this.message);
}

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
