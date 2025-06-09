import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionTileYoN extends StatefulWidget {
  const ExpansionTileYoN({super.key, required this.getValue, this.optionModel});
  final Function(String) getValue;
  final String? optionModel;
  @override
  State<ExpansionTileYoN> createState() => _ExpansionTileYoNState();
}

class _ExpansionTileYoNState extends State<ExpansionTileYoN> {
  String _option = 'não';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.getValue(_option);
    if(widget.optionModel!=null)
    _option = widget.optionModel!;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
         //   margin: EdgeInsets.only(bottom: sizeScreen.height * 0.01),
            width: 410.w,
            child: ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              collapsedShape: ContinuousRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(25), 
                  
                  side: const BorderSide(color: Color.fromARGB(255, 55, 111, 69),width: 1.5)),

               shape: ContinuousRectangleBorder(
                     borderRadius: BorderRadius.circular(25), 
                  side: const BorderSide(color: Color.fromARGB(255, 55, 111, 69),width: 1.5)),
              title: Text(
                _option,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 50.w,
                ),
              ),
              collapsedBackgroundColor: Color.fromARGB(255, 55, 111, 69),
              backgroundColor: Color.fromARGB(255, 55, 111, 69),
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.0),
              dense: true,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      //border: Border.all(width: 0.4),
                      color: Color.fromARGB(255, 55, 111, 69),
                    ),
                    child: ListTile(
                      
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),),
                      title: ( Text(
                        'sim',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50.w),
                      )),
                      onTap: () => setState(() {
                        _option = 'sim';
                        widget.getValue(_option);
                      }),
                      dense: true,
                    )),
                Container(
                    decoration: BoxDecoration(
                      // border: Border.all(width: 0.4),
                      color:Color.fromARGB(255, 55, 111, 69),
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: ListTile(
                      dense: true,
                    
                      title: (Text(
                        'não',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:50.w),
                      )),
                      onTap: () {
                        setState(() {
                          _option = 'não';
                          widget.getValue(_option);
                        });
                      },
                      // onTap: () => Navigator.pushNamed(context, routeName),
                    )),
              ],
            ))
      ],
    );
  }
}
