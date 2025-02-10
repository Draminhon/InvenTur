import 'package:flutter/material.dart';

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
            width: sizeScreen.width * 0.29,
            child: ExpansionTile(
              
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
                  color: const Color.fromARGB(255, 55, 111, 60),
                  fontWeight: FontWeight.w800,
                  fontSize: sizeScreen.width * 0.03,
                ),
              ),
              collapsedBackgroundColor: Colors.white,
              backgroundColor: Colors.white,
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.0),
              dense: true,
              children: [
                Container(
                    decoration: const BoxDecoration(
                      //border: Border.all(width: 0.4),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),),
                      title: (const Text(
                        'sim',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 55, 111, 69),
                            fontWeight: FontWeight.bold),
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
                      color:Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: ListTile(
                      dense: true,
                    
                      title: (Text(
                        'não',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 55, 111, 69),
                            fontWeight: FontWeight.bold,
                            fontSize: sizeScreen.width * 0.033),
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
