
// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:workshop_mobi/controller/teacher/add_workshop_controller.dart';
import 'package:workshop_mobi/model/workshopResquest.dart';
import 'package:workshop_mobi/screens/teacherLayout/teacher_home.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/add_workshop.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/discount_workshop.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/location_workshop.dart';

class CustomStepContainer extends StatelessWidget {
  final String title;
  final bool isActive;

  CustomStepContainer({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Color(0xff11b8f0) : Colors.grey,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class StepperWidget extends StatefulWidget {
  final String token;

  const StepperWidget({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  
  late AddWorkshopController _addWorkshopController;
  void showIncompleteStepSnackBar(int step) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Incomplete Step',
          message: 'Please fill in all required information for Step $step.',
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
    );
  }

 int _currentStep = 0;

 @override
  void initState() {
    super.initState();
    _addWorkshopController = AddWorkshopController(token: widget.token);
  }
  // Validate the completion of each step
  bool _validateStep(int step) {
    switch (step) {
      case 1:
        return _addWorkshopController.isStep1Completed();
      case 2:
        return _addWorkshopController.isStep2Completed();
      case 3:
        return _addWorkshopController.isStep3Completed();
      default:
        return true; // Default to true for other steps
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Step> stepsContent = [
      Step(
        title: CustomStepContainer(
          title: 'Info',
          isActive: _currentStep == 0,
        ),
        content: DetailsPage(
          controller: _addWorkshopController,
          onInfoChanged: (CourseRequest workshop) {
            setState(() {
              _addWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
        ),
      ),
      Step(
        title: CustomStepContainer(
          title: 'Location',
          isActive: _currentStep == 1,
        ),
        content: LocationPage(
          controller: _addWorkshopController,
          onLocationChanged: (CourseRequest workshop) {
            setState(() {
              _addWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
        ),
      ),
      Step(
        title: CustomStepContainer(
          title: 'Discount',
          isActive: _currentStep == 2,
        ),
        content: DiscountPage(
          controller: _addWorkshopController,
          onDiscountChanged: (CourseRequest workshop) {
            setState(() {
              _addWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
        ),
      ),
    ];

    bool isLastStep = _currentStep == stepsContent.length - 1;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
           child: Stepper(
            currentStep: _currentStep,
            onStepTapped: (int newIndex) {
              print("onStepTapped: $newIndex");
              // Validate steps before allowing navigation
              if (newIndex > _currentStep) {
                for (int i = _currentStep + 1; i <= newIndex; i++) {
                  if (!_validateStep(i)) {
                    // Display a message or handle incomplete step accordingly
                    showIncompleteStepSnackBar(i);
                    return;
                  }
                }
              }
              setState(() {
                _currentStep = newIndex;
              });
            },
            onStepContinue: () {
              print("Current Step: $_currentStep");
              setState(() {
                if (_currentStep <= stepsContent.length - 1) {
                  // Check completion of each step before proceeding to the next one
                  if (_currentStep == 0 &&
                      _addWorkshopController.isStep1Completed()) {
                    _currentStep += 1;
                  } else if (_currentStep == 1 &&
                      _addWorkshopController.isStep2Completed()) {
                    _currentStep += 1;
                  } else if (_currentStep == 2 &&
                      _addWorkshopController.isStep3Completed()) {
                    _currentStep += 1;
                  } else {
                    // Display a message or handle incomplete step accordingly
                    showIncompleteStepSnackBar(_currentStep + 1);
                  }
                } else if(_currentStep == stepsContent.length - 1) {
                  // If on the last step, perform the 'Gửi' action
                  if (_addWorkshopController.isAllStepsCompleted()) {
                    _addWorkshopController.addNewWorkshop();
                  } else {
                    // Display a message or handle incomplete step accordingly
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Vui lòng nhập đầy đủ thông tin'),
                      ),
                    );
                  }
                }
              });
            },
            onStepCancel: () {
              if (_currentStep != 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            type: StepperType.horizontal,
            controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
              return Row(
                children: <Widget>[
                  if (_currentStep >= 0)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Quay lại'),
                    ),
                  SizedBox(width: 16.0),
                  if (_currentStep < stepsContent.length - 1)
                    TextButton(
                      onPressed: () {
                        _addWorkshopController.showAllData();
                        controlsDetails.onStepContinue!();
                      },
                      child: const Text('Tiếp tục'),
                    )
                  else
                    TextButton(
                      onPressed: () {
                        controlsDetails.onStepContinue!();
                        // if(){
                           Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TeacherHomeScreen(initialPage: 'workshop'),
                          ),
                        );
                        // }
                       
                      },
                      child: const Text('Gửi'),
                    ),
                  SizedBox(width: 16.0),
                  TextButton(
                    onPressed: controlsDetails.onStepCancel,
                    child: const Text('Hủy'),
                  ),
                ],
              );
            },
            steps: stepsContent,
          ),
        ),
      ),
    );
  }
}
