
import 'package:flutter/material.dart';
import 'package:recipe_application_main/features/search_results/view/searchresult_screen.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class RowIngredContainer extends StatefulWidget {
  final String? imagePath1;
  final String ingName;

  const RowIngredContainer({
  super.key, 
  this.imagePath1, 
  required this.ingName});

  @override
  State<RowIngredContainer> createState() => _RowIngredContainerState();
}

class _RowIngredContainerState extends State<RowIngredContainer> {
   bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
         color: isSelected ? ColorConstants.red : ColorConstants.white,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.imagePath1!= null)
            CircleAvatar(
              radius:15,
              backgroundImage:AssetImage(widget.imagePath1!),
            ),
            SizedBox(width: 10),
            Text(
              widget.ingName,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorConstants.black )
            ),
          ],
        ),
      ),
    );
  }
}

   