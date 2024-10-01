// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:workshop_mobi/controller/teacher/edit_profile_teacher_controller.dart';
import 'package:workshop_mobi/model/workshopUpdateRequest.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/add_workshop.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/discount_workshop.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/location_workshop.dart';
import 'package:workshop_mobi/screens/teacherLayout/widgets/workshop/workshop_page.dart';

class EditWorkshopPage extends StatefulWidget {
  final String token;
  final int workshopId;
  const EditWorkshopPage({
    Key? key,
    required this.token,
    required this.workshopId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditWorkshopPageState();
}

class _EditWorkshopPageState extends State<EditWorkshopPage> {
  late EditWorkshopController _editWorkshopController;

  int _currentStep = 0;
  List<Step> stepsContent = [];

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

  @override
  void initState() {
    super.initState();
    _editWorkshopController = EditWorkshopController(
      token: widget.token,
      workshopId: widget.workshopId,
    );
    stepsContent = [
      Step(
        isActive: _currentStep == 0,
        title: Text('Info'), // Replace with your title widget
        content: DetailsPage(
          controller: _editWorkshopController,
          onInfoChanged: (CourseUpdateRequest workshop) {
            setState(() {
              _editWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
          workshopId: widget.workshopId,
        ),
      ),
      Step(
        isActive: _currentStep == 1,
        title: Text('Location'), // Replace with your title widget
        content: LocationPage(
          controller: _editWorkshopController,
          onLocationChanged: (CourseUpdateRequest workshop) {
            setState(() {
              _editWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
          workshopId: widget.workshopId,
        ),
      ),
      Step(
        isActive: _currentStep == 2,
        title: Text('Discount'), // Replace with your title widget
        content: DiscountPage(
          controller: _editWorkshopController,
          onDiscountChanged: (CourseUpdateRequest workshop) {
            setState(() {
              _editWorkshopController.workshop = workshop;
            });
          },
          token: widget.token,
          workshopId: widget.workshopId,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isLastStep = _currentStep == stepsContent.length - 1;

    return Scaffold(
      body: 
      Container(
        color: Colors.white,
        child: Center(
          child: Stepper(
            steps: stepsContent,
            onStepTapped: (int newIndex) {
              print(
                  "onStepTappedonStepTappedonStepTappedonStepTapped: $newIndex");
              setState(() {
                _currentStep = newIndex;
              });
            },
            currentStep: _currentStep,
            onStepContinue: () {
              print("Current Step: $_currentStep");
              setState(() {
                if (_currentStep < stepsContent.length - 1) {
                  if (_currentStep == 0 &&
                      _editWorkshopController.isStep1Completed()) {
                    print("Calling isStep1Completed()");
                    _currentStep += 1;
                  } else if (_currentStep == 1 &&
                      _editWorkshopController.isStep2Completed()) {
                    print("Calling isStep2Completed()");
                    _currentStep += 1;
                  } else if (_currentStep == 2 &&
                      _editWorkshopController.isStep3Completed()) {
                    print("Calling isStep3Completed()");
                    _currentStep += 1;
                  } else {
                    showIncompleteStepSnackBar(_currentStep+1);
                  }
                }else {
                  // If on the last step, perform the 'Gửi' action
                  if (_editWorkshopController.isAllStepsCompleted()) {
                    print("Calling addNewWorkshop()");
                    _editWorkshopController.editWorkshop();
                    } else {
                   showIncompleteStepSnackBar(3);
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
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
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
                        _editWorkshopController.showAllData();
                        controlsDetails.onStepContinue!();
                      },
                      child: const Text('Tiếp tục'),
                    )
                  else
                    TextButton(
                      onPressed: () {
                        controlsDetails.onStepContinue!();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => WorkshopManager(
                              token: widget.token,
                              workshopList: [],
                            ),
                          ),
                        );
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
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:workshop_mobi/model/workshopResponses.dart';
// import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/add_workshop.dart';
// import 'package:workshop_mobi/screens/teacherLayout/widgets/edit_workshop/discount_workshop.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


// class EditWorkshopPage extends StatefulWidget {
//   const EditWorkshopPage({Key? key}) : super(key: key);

  

//   @override
//   State<EditWorkshopPage> createState() => _EditWorkshopPageState();
// }

// class _EditWorkshopPageState extends State<EditWorkshopPage> {
//   late int currentStep;
//   late PageController _pageController;
//   final controller = Get.put(());

//   @override
//   void initState() {
//     super.initState();
//     currentStep = 0;
//     _pageController = PageController(initialPage: currentStep);

//   }
  
// void onStepContinue() {
//     if (controller.selectedFileCount.value == 0) {
//       showAwesomeSnackBar(
//         context: context,
//         title: 'Error',
//         message: 'Vui lòng chọn ít nhất 1 hình',
//         type: AwesomeSnackBarType.error,
//       );
//     } else if (!controller.isValidInfor && currentStep == 1) {
//       showAwesomeSnackBar(
//         context: context,
//         title: 'Error',
//         message: 'Vui lòng nhập chính xác và đầy đủ thông tin liên quan',
//         type: AwesomeSnackBarType.error,
//       );
//     } else if (controller.district.isEmpty &&
//         controller.ward.isEmpty &&
//         controller.addressController.text.isEmpty &&
//         currentStep == 2) {
//       showAwesomeSnackBar(
//         context: context,
//         title: 'Error',
//         message: 'Vui lòng nhập địa chỉ',
//         type: AwesomeSnackBarType.error,
//       );
//     } else {
//       setState(() {
//         currentStep++;
//         _pageController.animateToPage(
//           currentStep,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       });
//     }
//   }
//   void onStepCancel() {
//     if (currentStep > 0) {
//       setState(() {
//         currentStep--;
//         _pageController.animateToPage(currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//       });
//     }
//   }
// void showAwesomeSnackBar({
//     required BuildContext context,
//     required String title,
//     required String message,
//   }) {
//     final snackBar = SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: title,
//         message: message,
//         contentType: ContentType.failure,

//       ),
//     );

//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }

//   void onStepTapped(int index) {
//     // setState(() {
//     //   currentStep = index;
//     //   _pageController.animateToPage(currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//     // });
//   }

//   List<Step> steps = const [
//     Step(title: Text('Image'), content: AddProductImageScreen() ),
//     Step(title: Text('Infor'), content: AddProductInforScreen() ),
//     Step(title: Text('Address'), content: AddProductAddressScreen()),
//     Step(title: Text('Confirm'), content: AddProductConfirmScreen()),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//             title: const Text("New Parking"),
//             centerTitle: true,
//           ),
//           body: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: steps
//                         .asMap()
//                         .entries
//                         .map(
//                           (entry) => GestureDetector(
//                             onTap: () => onStepTapped(entry.key),
//                             child: Container(
//                               width: 30,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: getBubbleColor(entry.key),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '${entry.key + 1}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),

//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: steps.length,
//                     itemBuilder: (context, index) => steps[index].content,
//                   ),
//                 ),

//                 Container(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       if (currentStep != 0)
//                       SizedBox(
//                           width: 150,
//                           child: ElevatedButton.icon(
//                             onPressed: onStepCancel,
//                             icon: const Icon(Icons.arrow_circle_left_outlined, color: darkColor),
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
//                             label: const Text('Back', style: TextStyle(color: darkColor)),
//                           ),
//                         ),


//                       SizedBox(
//                         width: 150,
//                         child: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: (currentStep != steps.length - 1) ?  ElevatedButton.icon(
//                             onPressed: onStepContinue,
//                             icon: const Icon(Icons.arrow_circle_right_outlined, color: darkColor),
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
//                             label: const Text('Next', 
//                               style: TextStyle(color: darkColor),
//                             ),
                            
//                           ) : ElevatedButton.icon(
//                             onPressed: () {
//                               // upload image and call API
//                               print(123123);
//                             },
//                             icon: const Icon(Icons.arrow_circle_right_outlined, color: darkColor),
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
//                             label: const Text('Confirm', 
//                               style: TextStyle(color: darkColor),
//                             ),
                            
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               ],
//             ),
//         );
//   }

//   Color getBubbleColor(int index) {
//     if (index < currentStep) {
//       StepState.complete;
//       return Colors.green; // Completed
//     } else if (index == currentStep) {
//       return Colors.blue; // Active
//     } else {
//       return Colors.grey; // Inactive
//     }
//   }
// }


