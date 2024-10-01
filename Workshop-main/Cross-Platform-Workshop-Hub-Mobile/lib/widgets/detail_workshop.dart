// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, unnecessary_string_interpolations, annotate_overrides, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/controller/ratingController.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/screens/course_screen.dart';
import 'package:workshop_mobi/widgets/component/detailworkshop/main.dart';
import 'package:workshop_mobi/widgets/component/paypal/paypal_button.dart';

class WorkshopWithFullDetailAbout extends StatefulWidget {
  final CourseResponses workshopList;

  WorkshopWithFullDetailAbout(this.workshopList);
  static Future<UserInfoResponse> getStudentInfo() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    String? roles = await storage.read(key: 'roles');
    ApiService apiService = ApiService();
    UserInfoResponse infoResponse = await apiService.getinforStudent(token!);
    return infoResponse;
  }

  static Future<String?> getRole() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();

    String? roles = await storage.read(key: 'roles');

    return roles;
  }

  @override
  State<WorkshopWithFullDetailAbout> createState() =>
      _WorkshopWithFullDetailAboutState();
}

class _WorkshopWithFullDetailAboutState
    extends State<WorkshopWithFullDetailAbout> {
  late Future<UserInfoResponse> userInfoFuture;
  late Future<String?> roleExit;
  void initState() {
    super.initState();
    userInfoFuture = WorkshopWithFullDetailAbout.getStudentInfo();
    roleExit = WorkshopWithFullDetailAbout.getRole();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return FutureBuilder<UserInfoResponse>(
        future: userInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            UserInfoResponse userInfo = snapshot.data!;
            return Scaffold(
              body: SingleChildScrollView(
                child: WorkshopMainContainer(
                  workshopItem: widget.workshopList,
                ),
              ),
              floatingActionButton: Stack(
                alignment: Alignment.bottomCenter, // Căn giữa phía dưới
                children: [
                  // Nút Comment
                  Positioned(
                    right: 10.0,
                    bottom: 80.0, // Khoảng cách từ dưới lên một chút
                    child: FloatingActionButton(
                      heroTag: "uniqueTag1",
                      onPressed: () {
                        _showAddCommentDialog(
                            context,
                            widget.workshopList.teacher_id,
                            widget.workshopList.id,
                            userInfo);
                      },
                      child: Icon(Icons.comment),
                      backgroundColor: Color.fromARGB(255, 28, 228, 175),
                    ),
                  ),
                  // Nút Buy
                  Positioned(
                    right: 100,
                    bottom: 10.0,
                    height: 40,
                    width: 120, // Khoảng cách từ dưới cùng
                    child: FutureBuilder<String?>(
                      future: WorkshopMainContainer.getEmail(),
                      builder: (context, emailSnapshot) {
                        if (emailSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (emailSnapshot.hasError) {
                          return Text('Error: ${emailSnapshot.error}');
                        } else {
                          String? email = emailSnapshot.data;
                          return FutureBuilder<bool>(
                            future: apiService.checkWorkshopIsFree(
                              email.toString(),
                              widget.workshopList.id,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                bool isFree = snapshot.data ?? false;
                                return SizedBox(
                                  width: 300.0,
                                  height: 100.0,
                                  child: FloatingActionButton(
                                    heroTag: "uniqueTag2",
                                    onPressed: () async {
                                      if (isFree) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CourseScreen(
                                              widget.workshopList,
                                            ),
                                          ),
                                        );
                                      } else {
                                        if (await roleExit == "USER") {
                                          showPaymentDialog(
                                            context,
                                            widget.workshopList.id,
                                            widget.workshopList.name,
                                            widget.workshopList.price
                                                .toInt()
                                                .toString(),
                                            widget.workshopList
                                                .courseMediaInfos[0].urlImage,
                                          );
                                        } else {
                                          showAlertDialog(context);
                                        }
                                      }
                                    },
                                    backgroundColor: isFree
                                        ? Colors.green
                                        : Color.fromARGB(255, 11, 200, 217),
                                    child: Icon(
                                      isFree
                                          ? Icons.visibility
                                          : Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }

  void showPaymentDialog(BuildContext context, int id, String name,
      String price, String imageUrl) {
    TextEditingController discountController = TextEditingController();
    bool isDiscountApplied = false;
    double discountedPrice = double.parse(price);
    String discountMessage = '';
    int value = 0;
    String discountCode = '';
    bool isLoading = false;
    bool paymentSuccessful = false;
    int result = 0;
    bool isButtonLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: AlertDialog(
                title: const Text("Payment Information"),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WorkshopImageDisplay(
                        imageUrl: imageUrl,
                      ),
                      const SizedBox(height: 10),
                      WorkshopNameDisplay(
                        name: name,
                      ),
                      const SizedBox(height: 5),
                      DiscountPriceDisplay(discountedPrice: discountedPrice),
                      DiscountMessageDisplay(
                          discountMessage: discountMessage, value: value),
                      const SizedBox(height: 20),
                      if (!isDiscountApplied)
                        Column(
                          children: [
                            TextField(
                              controller: discountController,
                              decoration: const InputDecoration(
                                labelText: 'Enter Discount Code',
                              ),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () async {
                                discountCode = discountController.text;
                                final apiService = ApiService();
                                const storage = FlutterSecureStorage();
                                String? token =
                                    await storage.read(key: "token");
                                value = await apiService.checkDiscountWorkshop(
                                    token, id, discountCode);
                                setState(() {
                                  if (value > 0) {
                                    discountedPrice =
                                        double.parse(price) - value;
                                    discountMessage =
                                        'Discount Applied: \$${value.toString()}';
                                  } else {
                                    discountMessage = 'Invalid or Expired Code';
                                  }
                                });
                              },
                              child: const Text('Apply Discount'),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (isButtonLoading) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Processing'),
                                  content: Text(
                                      'Please wait, your request is being processed.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          }
                          setState(() {
                            isLoading = true;
                            isButtonLoading = true;
                          });
                          final apiService = ApiService();
                          const storage = FlutterSecureStorage();
                          String? token = await storage.read(key: "token");
                          try {
                            if (value > 0) {
                              result = await apiService.buyWorkshop(
                                token,
                                "Wallet",
                                id,
                                value + discountedPrice,
                                value.toDouble(),
                                discountCode,
                              );
                            } else {
                              result = await apiService.buyWorkshop(
                                token,
                                "Wallet",
                                id,
                                value + discountedPrice,
                                0,
                                discountCode,
                              );
                            }
                            if (result == 202) {
                              setState(() {
                                paymentSuccessful = true;
                              });
                            }
                          } catch (error) {
                            paymentSuccessful = false;
                          } finally {
                            setState(() {
                              isLoading = false;
                              isButtonLoading = false;
                            });
                            await Future.delayed(const Duration(seconds: 2));
                            Navigator.of(context).pop(paymentSuccessful);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Pay with Wallet",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const SizedBox(height: 5),
                      PayPalPaymentButton(
                        value: discountedPrice,
                        onResult: (success, message) async {
                          showDialog(
                            context: context,
                            barrierDismissible:
                                false, // Ngăn chặn việc đóng dialog bằng cách nhấn bên ngoài
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Đang Xử Lý'),
                                content: CircularProgressIndicator(),
                              );
                            },
                          );

                          setState(() {
                            isButtonLoading = true;
                          });

                          try {
                            if (success) {
                              final apiService = ApiService();
                              const storage = FlutterSecureStorage();
                              String? token = await storage.read(key: "token");

                              if (value > 0) {
                                result = await apiService.buyWorkshop(
                                  token,
                                  "payment_gateway",
                                  id,
                                  value + discountedPrice,
                                  value.toDouble(),
                                  discountCode,
                                );
                              } else {
                                result = await apiService.buyWorkshop(
                                  token,
                                  "payment_gateway",
                                  id,
                                  value + discountedPrice,
                                  0,
                                  discountCode,
                                );
                              }

                              setState(() {
                                paymentSuccessful = true;
                              });
                            } else {
                              setState(() {
                                paymentSuccessful = false;
                              });
                            }
                          } catch (error) {
                            // Xử lý lỗi ở đây
                          } finally {
                            setState(() {
                              isButtonLoading = false;
                            });
                            // await Future.delayed(const Duration(seconds: 2));
                            Navigator.of(context).pop();
                            Navigator.of(context).pop(paymentSuccessful);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((paymentSuccessful) {
      if (paymentSuccessful == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful!'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment Fail!'),
            backgroundColor: Color.fromARGB(255, 175, 76, 76),
          ),
        );
      }
    });
  }
}

class WorkshopNameDisplay extends StatelessWidget {
  final String name;
  const WorkshopNameDisplay({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class WorkshopImageDisplay extends StatelessWidget {
  final String imageUrl;
  const WorkshopImageDisplay({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
    );
  }
}

class DiscountMessageDisplay extends StatelessWidget {
  const DiscountMessageDisplay({
    super.key,
    required this.discountMessage,
    required this.value,
  });

  final String discountMessage;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      discountMessage,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: value > 0 ? Colors.green : Colors.red,
      ),
    );
  }
}

class DiscountPriceDisplay extends StatelessWidget {
  const DiscountPriceDisplay({
    super.key,
    required this.discountedPrice,
  });

  final double discountedPrice;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Price: \$$discountedPrice",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Warning"),
        content: const Text("Mentor Cant Not Buy, please user Student Account"),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại
            },
          ),
        ],
      );
    },
  );
}

int selectedRating = 1;
String selectedOption = 'MENTOR'; // Default option
void _showAddCommentDialog(BuildContext context, int teacherId, int workshopId,
    UserInfoResponse userInfo) {
  RatingController ratingController = Get.put(RatingController());

  ImageProvider imageProvider;
  if (userInfo.image_url != null && userInfo.image_url!.isNotEmpty) {
    imageProvider = NetworkImage(userInfo.image_url!);
  } else {
    imageProvider = AssetImage('lib/assets/avatar.jpg');
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Obx(() {
            return AlertDialog(
              title: Text('Add Comment'),
              content: SingleChildScrollView(
                // Cho phép cuộn nếu cần
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: imageProvider,
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          '${userInfo.full_name}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Rating: '),
                        RatingBar.builder(
                          initialRating:
                              ratingController.ratingController.text.isEmpty
                                  ? 0.0
                                  : double.parse(
                                      ratingController.ratingController.text),
                          minRating: 0.5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratingController.ratingController.text =
                                  rating.toString();
                            });
                          },
                        ),
                        SizedBox(width: 8.0),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text('Rating For: '),
                        DropdownButton<String>(
                          value: ratingController.typerController.text.isEmpty
                              ? 'MENTOR'
                              : ratingController.typerController.text,
                          items: ['MENTOR', 'WORKSHOP']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                ratingController.typerController.text = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('Comment:'),
                    TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: ratingController.commentController,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: ratingController.isLoading.isTrue
                      ? null
                      : () async {
                          await ratingController.commentAndRating(
                              teacherId, workshopId);
                          if (!ratingController.isLoading.isTrue) {
                            _showSuccessDialog(context);
                          } else {
                            _showFalieDialog(context);
                          }
                        },
                  child: ratingController.isLoading.isTrue
                      ? CircularProgressIndicator()
                      : Text('Submit'),
                ),
              ],
            );
          });
        },
      );
    },
  );
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Your comment has been successfully submitted.'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
          ),
        ],
      );
    },
  );
}

void _showFalieDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Fail'),
        content: Text('Your comment has been Fail .'),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
          ),
        ],
      );
    },
  );
}
