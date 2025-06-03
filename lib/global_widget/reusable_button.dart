
import 'package:flutter/material.dart';


class ReusableButton extends StatelessWidget {
   final String textname;
   final Color backgroundColor;
   final Color textColor;
   final void Function() buttonPressed;
  const ReusableButton({
    super.key, 
    required this.buttonPressed, 
    required this.textname, 
     this.backgroundColor=Colors.white, 
     this.textColor=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: buttonPressed,
        child: Container(
              height: 56,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
              
              ),
              child: Center(
                child: Text(textname,
                style: TextStyle(color: textColor,
                fontSize: 20 ,
                fontWeight: FontWeight.bold),),
              ),
            ),
      );
  }
}