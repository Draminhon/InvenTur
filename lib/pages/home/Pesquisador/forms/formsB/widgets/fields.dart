import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';

class ConditionalFieldsGroup extends StatefulWidget {
  final String title;
  final String jsonKey;
  final List<Widget> children;
  final String? optionModelValue;
  final Map<String, dynamic> valoresJson;
  final bool isUpdate;
  const ConditionalFieldsGroup(
      {super.key,
      required this.title,
      required this.jsonKey,
      required this.valoresJson,
      required this.isUpdate,
      required this.children, this.optionModelValue});

  @override
  State<ConditionalFieldsGroup> createState() => _ConditionalFieldsGroupState();
}

class _ConditionalFieldsGroupState extends State<ConditionalFieldsGroup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isUpdate && widget.optionModelValue != null){
      widget.valoresJson[widget.jsonKey] = widget.optionModelValue;
    }else{
      widget.valoresJson.putIfAbsent(widget.jsonKey, () => 'não');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = widget.valoresJson[widget.jsonKey] == 'sim';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55.h,
        ), 
        Row(
          children: [
            Expanded(
              flex: 2,
              child: textLabel(name: widget.title)),
              SizedBox(width: 10), 
            Expanded(
              flex: 3,
                child: ExpansionTileYoN(
                  optionModel: widget.valoresJson[widget.jsonKey] ?? 'não',
                  getValue: (p0) {
                    if (widget.valoresJson[widget.jsonKey] == p0) return;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      setState(() {
                        widget.valoresJson[widget.jsonKey] = p0;
                      });
                    });
                  },
                ))
          ],
        ),
        if (isExpanded || widget.optionModelValue =='sim')  ...widget.children
      ],
    );
  }
}
