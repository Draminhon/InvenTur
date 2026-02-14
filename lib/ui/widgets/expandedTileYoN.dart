import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionTileYoN extends StatefulWidget {
  const ExpansionTileYoN({super.key, required this.getValue, this.optionModel, this.options, this.isUpdate});
  final Function(String) getValue;
  final String? optionModel;
  final bool? isUpdate;
  final List<String>? options;
  @override
  State<ExpansionTileYoN> createState() => _ExpansionTileYoNState();
}

class _ExpansionTileYoNState extends State<ExpansionTileYoN> {
  String _option = 'não' ;
    late final ExpansibleController _tileController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tileController = ExpansibleController();
    if(widget.optionModel!=null && widget.isUpdate == true){
    _option = widget.optionModel!;

    }else if(widget.optionModel!=null && widget.isUpdate == false){
      _option = widget.options != null ? widget.options![0] : 'não';
    }


  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
         //   margin: EdgeInsets.only(bottom: sizeScreen.height * 0.01),
            width: widget.options != null ? 520.w : 410.w,
            child: ExpansionTile(
              controller: _tileController,
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
                        widget.options != null ? widget.options![0] : 'sim',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50.w),
                      )),
                      onTap: () {
                        setState(() {
                        _option = widget.options != null ? widget.options![0] : 'sim';
                        
                        widget.getValue(_option);
                      });
                        _tileController.collapse();
                        
                      },
                      
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
                       widget.options != null ? widget.options![1] : 'não',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:50.w),
                      )),
                      onTap: () {

                        setState(() {
                          _option =widget.options != null ? widget.options![1] : 'não';
                          widget.getValue(_option);
                          
                        });
                        _tileController.collapse();

                      },
                      // onTap: () => Navigator.pushNamed(context, routeName),
                    )),
              ],
            ))
      ],
    );
  }
}
