import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/widgets/maps/map.dart';

class MapaWidget extends StatefulWidget {
  const MapaWidget(
      {super.key,
      required this.valoresJson,
      required this.isUpdate,
      required this.latitude,
      required this.longitude});
  final Map valoresJson;
  final bool isUpdate;
  final String latitude;
  final String longitude;
  @override
  State<MapaWidget> createState() => _MapaWidgetState();
}

class _MapaWidgetState extends State<MapaWidget> {
      bool _isFullScreen = false;
    final double _initialMapHeight = 300.0;

    void _toggleFullScreen() {
      setState(() {
        _isFullScreen = !_isFullScreen;
      });
    }
  @override
  Widget build(BuildContext context) {


    final sizeScreen = MediaQuery.sizeOf(context);
    final double currentMapHeight =
        _isFullScreen ? sizeScreen.height * 0.8 : _initialMapHeight;
    return SizedBox(
        height: _isFullScreen ? currentMapHeight : currentMapHeight,
        width: 1300.h,
        child: GestureDetector(
            onDoubleTap: () => _toggleFullScreen(),
            child: MeuMapa(
              onPlaceSelected: (value) {
                setState(() {
                  value.forEach(
                    (key, value) {
                      widget.valoresJson[key] = value;
                    },
                  );
                });
              },
              initialLatitude:
                  widget.isUpdate ? double.tryParse(widget.latitude) : null,
              initialLongitute:
                  widget.isUpdate ? double.tryParse(widget.longitude) : null,
            )));
  }
}
