import 'package:flutter/material.dart';
import 'package:recipe_application_main/features/search_results/view/searchresult_screen.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';


class ColumnCatgContainer extends StatefulWidget {
  final String? imagePath;
  final String catgName;
   const ColumnCatgContainer({super.key, this.imagePath, required this.catgName});

  @override
  State<ColumnCatgContainer> createState() => _ColumnCatgContainerState();
}

class _ColumnCatgContainerState extends State<ColumnCatgContainer> {
  bool isSelected = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          isSelected = !isSelected;
       setState(() {});
       Navigator.push(
       context,
       MaterialPageRoute(
       builder: (context) => SearchResults(),
    ),
        );
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSelected ? ColorConstants.red : null,
            border: Border.all(color: ColorConstants.lightred),
            borderRadius: BorderRadius.circular(30)
          ),
          child: InkWell(
            onTap: () {
              isSelected = !isSelected;
              setState(() {});
              Navigator.push(
             context,
             MaterialPageRoute(
           builder: (context) => SearchResults(),
    ),
        );
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: ColorConstants.white),
                    ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(widget.imagePath!= null)
                      Image.asset(widget.imagePath!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,),
                      SizedBox(width: 10),
                      
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                   widget.catgName,
                   style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w500,
                   color:isSelected? ColorConstants.white:ColorConstants.black)
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
