import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recipe_application_main/features/bottom_nav_bar/view/bottom_navbar.dart';
import 'package:recipe_application_main/global_widget/reusable_button.dart';
import 'package:recipe_application_main/utils/constants/color_constants.dart';

class CookingStepScreen extends StatefulWidget {
  final List<Map<String, dynamic>> steps;

  const CookingStepScreen({super.key, required this.steps});

  @override
  State<CookingStepScreen> createState() => _CookingStepScreenState();
}

class _CookingStepScreenState extends State<CookingStepScreen> {
  int currentStep = 0;
  late Timer timer;
  int secondsRemaining = 0;
  bool isPaused = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    startStep();
  }

  void startStep() {
    secondsRemaining = widget.steps[currentStep]['duration'];
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic( Duration(seconds: 1), (t) {
      if (!isPaused) {
        if (secondsRemaining > 0) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          t.cancel();
          if (currentStep == widget.steps.length - 1) {
            setState(() {
              isCompleted = true;
            });
          }
        }
      }
    });
  }

  void pauseOrResumeTimer() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void resetStep() {
    timer.cancel();
    setState(() {
      secondsRemaining = widget.steps[currentStep]['duration'];
      isPaused = false;
    });
    startTimer();
  }

  void nextStep() {
    timer.cancel();
    if (currentStep < widget.steps.length - 1) {
      setState(() {
        currentStep++;
        isPaused = false;
        isCompleted = false;
      });
      startStep();
    }
  }

  void previousStep() {
    timer.cancel();
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        isPaused = false;
        isCompleted = false;
      });
      startStep();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    double progress = widget.steps[currentStep]['duration'] > 0
        ? (widget.steps[currentStep]['duration'] - secondsRemaining) /
            widget.steps[currentStep]['duration']
        : 0;

    return Scaffold(
      backgroundColor: ColorConstants.lightred,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
             Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         IconButton(
                          icon: Icon(
                            isPaused ? Icons.play_circle_outlined: Icons.pause_circle_outlined,
                            color: ColorConstants.yellow,
                          ),
                          onPressed: pauseOrResumeTimer,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              height: 90,
                              width: 100,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 8,
                                backgroundColor: ColorConstants.lightred,
                                valueColor: AlwaysStoppedAnimation(ColorConstants.red),
                              ),
                            ),
                            Text(      
                              "${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                         IconButton(
                          icon: Icon(Icons.refresh, color: ColorConstants.yellow),
                          onPressed: resetStep,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.steps.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor:
                          index == currentStep ? ColorConstants.red : ColorConstants.lightGrey1,
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 20),
              Text(
                "Step ${currentStep + 1}",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.red),
              ),
              SizedBox(height: 10),
        
              // Step instruction
              Text(
                widget.steps[currentStep]['instruction'],
                textAlign: TextAlign.justify,
                style:  TextStyle(fontSize: 16),
              ),
        
              Spacer(),
        
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: previousStep,
                    icon: Icon(Icons.arrow_back_ios),
                    label: Text("Previous Step",style: TextStyle(
                      color: Colors.black87),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.white,
                      foregroundColor: ColorConstants.red,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed:
                        currentStep < widget.steps.length - 1 ? nextStep : null,
                   
                    label:  Row(
                      children: [
                        Text("Next Step",style: TextStyle(
                      color: Colors.black87)),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ), 
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.white,
                      foregroundColor: ColorConstants.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
        
             ReusableButton(
               buttonPressed: () {
                if (isCompleted) {
                  Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => BottomNavbar()),
                  );
                }
               }, 
              textColor: ColorConstants.white,
              backgroundColor:isCompleted ? ColorConstants.red : ColorConstants.lightGrey1,              
              textname: "Done"
            ),
           ],
          ),
        ),
      ),
    );
  }
}
