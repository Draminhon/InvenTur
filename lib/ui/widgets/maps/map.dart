import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sistur/services/map_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class MeuMapa extends StatefulWidget {
  final VoidCallback? onDoubleClick;
  final ValueChanged<Map<String, dynamic>>? onPlaceSelected;
  final double? initialLatitude;
  final double? initialLongitute;

  const MeuMapa({super.key, this.onPlaceSelected, this.onDoubleClick,
   this.initialLatitude,
   this.initialLongitute
   });

  @override
  State<MeuMapa> createState() => _MeuMapaState();
}

class _MeuMapaState extends State<MeuMapa> {
  final MapController _mapController = MapController();
  final MapService _mapService = MapService(mapboxAccessToken: 'pk.eyJ1IjoibXVyaWxvcm9kIiwiYSI6ImNtZjFhajJmdzBpOTMya3BweDR0bTE0Y3IifQ.bNCRgdKwVbeeY1pHeFUAaQ');

  LugarInfo? _tappedPlaceInfo;
  LatLng? _currentLocationMarker; 
  LatLng? _tappedMarker; 
  bool _isLoading = false;

  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _startLocationStream();


    if(widget.initialLatitude != null && widget.initialLongitute != null){
      WidgetsBinding.instance.addPostFrameCallback((_){
        centerOnCoordinates(widget.initialLatitude!, widget.initialLongitute!);
      });
    }
  }


  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }


  Future<void> centerOnCoordinates(double lat, double lon, {double zoom = 15.0}) async{
    final point = LatLng(lat, lon);

    _mapController.move(point, zoom);

    setState(() {
      _isLoading = true;
      _tappedMarker = point;
    });

    try{
      final info = await _mapService.getInfoFromCoordinates(point);

      widget.onPlaceSelected?.call(info.toMap());

      if(mounted){
        setState(() => _tappedPlaceInfo,);
      }
    }catch(e){
      if(mounted){
        setState(() {
          _tappedPlaceInfo = LugarInfo(coordenadas: point,
          displayName: 'Erro ao buscar informações: ${e.toString()}');
        });
      }
    }finally{
      if(mounted){
        setState(() => _isLoading = false,);
      }
    }
  }

  void _startLocationStream() {
    _positionStreamSubscription = _mapService.getPositionStream().listen((Position position) {
      if (mounted) {
        setState(() {
          _currentLocationMarker = LatLng(position.latitude, position.longitude);
        });
      }
    }, onError: (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível obter a localização em tempo real.')),
        );
      }
    });
  }

  Future<void> _centerMapOnUserLocation() async {
    try {
      final position = await _mapService.getCurrentPosition();
      final userLocation = LatLng(position.latitude, position.longitude);
      
      setState(() {
        _tappedMarker = userLocation;
        _tappedPlaceInfo = null; 
      });

      _mapController.move(userLocation, 15.0);
    } on LocationServiceException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ocorreu um erro inesperado.')));
    }
  }

  Future<void> _handleMapTap(LatLng point) async {
    setState(() {
      _isLoading = true;
      _tappedMarker = point; 
    });

    try {
      final info = await _mapService.getInfoFromCoordinates(point);

      if(widget.onPlaceSelected != null){
        widget.onPlaceSelected!(info.toMap());
      }
      if(mounted){
      setState(() {
        _tappedPlaceInfo = info;
      });
      }

    } catch (e) {
      if(mounted){
      setState(() {
        _tappedPlaceInfo = LugarInfo(
          coordenadas: point, 
          displayName: 'Erro ao buscar informações: ${e.toString()}'
        );
      });
      }

    } finally {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(-15.7942, -47.8825), // Brasília
              initialZoom: 4.0,
              onTap: (tapPosition, latLng) => _handleMapTap(latLng),
              onSecondaryTap: (tapPosition, point) {
                widget.onDoubleClick?.call();
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoibXVyaWxvcm9kIiwiYSI6ImNtZjFhajJmdzBpOTMya3BweDR0bTE0Y3IifQ.bNCRgdKwVbeeY1pHeFUAaQ',
                  'id': 'mapbox/streets-v11'
                },
                userAgentPackageName: 'br.com.murilo.gps',
              ),
              MarkerLayer(
                markers: _buildMarkers(),
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launcher.launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildInfoPanel(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _centerMapOnUserLocation,
        tooltip: 'Centralizar na sua Localização',
        child: const Icon(Icons.my_location),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];

    if (_currentLocationMarker != null) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: _currentLocationMarker!,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.2),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Icon(Icons.circle, color: Colors.blue, size: 15),
            ),
          ),
        ),
      );
    }
    
    if (_tappedMarker != null) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: _tappedMarker!,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    }
    
    return markers;
  }

  Widget _buildInfoPanel() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(maxHeight: 170), // Altura máxima
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _tappedPlaceInfo == null
                ? const Center(
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Clique em um lugar no mapa para ver detalhes.'),
                    Text('Pressione DUAS VEZES para expandir o mapa.', style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ))
                : ListView(
                    shrinkWrap: true,
                    children: [
                      
                      RichText(
                        text: TextSpan(children: [
                        TextSpan(text: 'Rua: ',
                        style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: _tappedPlaceInfo!.rua
                        )
                      ],
                      style: DefaultTextStyle.of(context).style,
                      )),
                      RichText(text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(text: 'Cidade: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: _tappedPlaceInfo!.cidade
                          )
                        ]
                      )),
                      const Divider(height: 16),
                      RichText(
                        
                        text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                          
                          children: [
                          TextSpan(text: 'Lat: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: _tappedPlaceInfo!.coordenadas.latitude.toStringAsFixed(6))
                      ]),),
                       RichText(
                        
                        text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                          
                          children: [
                          TextSpan(text: 'Lon: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: _tappedPlaceInfo!.coordenadas.longitude.toStringAsFixed(6))
                      ]),),
                    ],
                  ),
      ),
    );
  }
}
