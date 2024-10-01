// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, use_build_context_synchronously, unused_local_variable, prefer_const_constructors_in_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:workshop_mobi/api/api_service.dart';
import 'package:workshop_mobi/model/userInforResponse.dart';
import 'package:workshop_mobi/model/workshopResponses.dart';
import 'package:workshop_mobi/screens/teacherLayout/teacher_home.dart';
import 'package:workshop_mobi/screens/userLayout/user_home.dart';
import 'package:workshop_mobi/widgets/component/detailworkshop/about_section.dart';
import 'package:workshop_mobi/widgets/component/detailworkshop/rating_section.dart';
import 'package:workshop_mobi/widgets/component/paypal/paypal_button.dart';

class WorkshopMainContainer extends StatefulWidget {
  final CourseResponses workshopItem;

  WorkshopMainContainer({
    super.key,
    required this.workshopItem,
  });

  static Future<String?> getEmail() async {
    const storage = FlutterSecureStorage();
    String? email = await storage.read(key: "email");
    return email;
  }

  static Future<UserInfoResponse> getStudentInfo() async {
      const FlutterSecureStorage storage = FlutterSecureStorage();
        String? token = await storage.read(key: 'token');
    late ApiService apiService = ApiService();
    late UserInfoResponse infoResponse;
    infoResponse = await apiService.getinforStudent(token!);
    return infoResponse;
  }

  @override
  State<WorkshopMainContainer> createState() => _WorkshopMainContainerState();
}

String selectedTab = 'About';

class _WorkshopMainContainerState extends State<WorkshopMainContainer> {
  bool isAboutSection = true;
  late Future<UserInfoResponse> userInfoFuture;

  @override
  void initState() {
    super.initState();
    userInfoFuture = WorkshopMainContainer.getStudentInfo();
  }
  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 1.05;
    String imageUrl = widget.workshopItem.courseMediaInfos.isNotEmpty
        ? widget.workshopItem.courseMediaInfos[0].urlImage
        : 'https://thietbiquayphim.com/wp-content/uploads/2022/05/meo-chup-anh-cun-cung.png';

    DateTime dateTime = widget.workshopItem.courseLocations[0].schedule_Date;
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return Container(
      padding: EdgeInsets.fromLTRB(0 * fem, 49.21 * fem, 0 * fem, 0 * fem),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x2b407bff)),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(7.6883263588 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color(0x4f3a4cde),
            offset: Offset(49.2052879333 * fem, 15.3766527176 * fem),
            blurRadius: 96.1040802002 * fem,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWorkshopCard(
              fem: fem, imageUrl: imageUrl, ffem: ffem, widget: widget),
          InfomationWorkshopCard(
              fem: fem,
              widget: widget,
              ffem: ffem,
              formattedTime: formattedTime),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.only(left: 43, right: 43),
            decoration: BoxDecoration(
              color: Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: isAboutSection
                      ? const Color.fromARGB(194, 37, 202, 238)
                      : const Color(0xC0C0C0C0),
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isAboutSection = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: const Text(
                        'About',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: isAboutSection
                      ? Color(0xC0C0C0C0)
                      : Color.fromARGB(194, 37, 202, 238),
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isAboutSection = false;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: Text(
                        'Rating & Feedback',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
         const SizedBox(height: 10),
          isAboutSection
              ? AboutSection()
              : RatingSection(
                  teacherId: widget.workshopItem.teacher_id,
                  workshopId: widget.workshopItem.id,
                  isComment: widget.workshopItem.isFree,
                  
                ),
        ],
      ),
    );
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
                      Image.network(
                        imageUrl,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Price: \$$discountedPrice",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        discountMessage,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: value > 0 ? Colors.green : Colors.red,
                        ),
                      ),
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
                          setState(() {
                            isLoading = true;
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
                            // print('Result: $result');
                            if (result == 202) {
                              setState(() {
                                paymentSuccessful = true;
                              });
                            }
                          } catch (error) {
                            // print(error);
                          } finally {
                            setState(() {
                              isLoading = false;
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
                            ? const CircularProgressIndicator() // Show loading indicator
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
                              // print("Payment Success: $message");
                            } else {
                              setState(() {
                                paymentSuccessful = false;
                              });
                              // print("Payment Failed/Error: $message");
                            }
                          } catch (error) {
                            // print(error);
                          } finally {
                            await Future.delayed(const Duration(seconds: 2));
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

class InfomationWorkshopCard extends StatelessWidget {
  const InfomationWorkshopCard({
    super.key,
    required this.fem,
    required this.widget,
    required this.ffem,
    required this.formattedTime,
  });

  final double fem;
  final WorkshopMainContainer widget;
  final double ffem;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(37.22 * fem, 0 * fem, 0 * fem, 17.98 * fem),
      width: 183.67 * fem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8.73 * fem),
            child: Text(
              '${widget.workshopItem.name}',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 17 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 2 * ffem / fem,
                  color: const Color(0xff4f4f4f),
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(1.92 * fem, 0 * fem, 0 * fem, 13.1 * fem),
            width: 177 * fem,
            height: 25 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 14.06 * fem, 0 * fem),
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          // iconlylightstarLZR (688:3033)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0.8 * fem, 16 * fem, 0 * fem),
                          width: 12.53 * fem,
                          height: 17.89 * fem,
                          child: Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                          )),
                      Text(
                        '4.8',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.9 * ffem / fem,
                            color: const Color(0xff4f4f4f),
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                Container(
                  // frame1171275894Zwy (688:3035)
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          // iconlylighttimecircleKRM (688:3036)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0.38 * fem, 15.84 * fem, 0 * fem),
                          width: 11.85 * fem,
                          height: 11.85 * fem,
                          child: Icon(Icons.lock_clock)),
                      Text(
                        // am200pm2qZ (688:3037)
                        "${formattedTime}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 2 * ffem / fem,
                            color: const Color(0xff4f4f4f),
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // studentsavatarsMN3 (688:3038)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 11.55 * fem, 0 * fem),
            width: double.infinity,
            height: 30 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // frame625959ftX (688:3039)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 6.92 * fem, 0 * fem),
                  width: 59.2 * fem,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        // ellipse995nCT (688:3040)
                        left: 0 * fem,
                        top: 0.0001220703 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 25.91 * fem,
                            height: 25.91 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8.4571590424 * fem),
                                border:
                                    Border.all(color: const Color(0xffffffff)),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://thietbiquayphim.com/wp-content/uploads/2022/05/meo-chup-anh-cun-cung.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // ellipse994dym (688:3041)
                        left: 8.4572753906 * fem,
                        top: 0.0001220703 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 25.91 * fem,
                            height: 25.91 * fem,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8.4571590424 * fem),
                                border:
                                    Border.all(color: const Color(0xffffffff)),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://thietbiquayphim.com/wp-content/uploads/2022/05/meo-chup-anh-cun-cung.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // studentsVHD (688:3050)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: Text(
                    '${widget.workshopItem.studentEnrollments.length} students',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.5 * ffem / fem,
                      color: const Color(0xff4f4f4f),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWorkshopCard extends StatelessWidget {
  const HeaderWorkshopCard({
    super.key,
    required this.fem,
    required this.imageUrl,
    required this.ffem,
    required this.widget,
  });

  final double fem;
  final String imageUrl;
  final double ffem;
  final WorkshopMainContainer widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(22.88 * fem, 0 * fem, 13.53 * fem, 18.45 * fem),
      width: double.infinity,
      height: 189.9 * fem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.4519824982 * fem),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14201b39),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 20 * fem,
          ),
        ],
      ),
      child: Stack(
        children: [
          WorkshopImage(fem: fem, imageUrl: imageUrl),
          IconHeader(fem: fem, ffem: ffem, widget: widget),
        ],
      ),
    );
  }
}

class IconHeader extends StatelessWidget {
  const IconHeader({
    super.key,
    required this.fem,
    required this.ffem,
    required this.widget,
  });

  final double fem;
  final double ffem;
  final WorkshopMainContainer widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 23.3012695312 * fem,
      top: 8.763671875 * fem,
      child: SizedBox(
        width: 344.17 * fem,
        height: 179.14 * fem,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // navbarcomponentGaF (I688:3028;769:36906)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 123.78 * fem),
              width: double.infinity,
              height: 24.6 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      const storage = FlutterSecureStorage();
                      String? roles = await storage.read(key: "roles");
                      if (roles == "SELLER") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeacherHomeScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserHomeScreen(),
                          ),
                        );
                      }
                    },
                    child: SizedBox(
                      width: 24.6 * fem,
                      height: 24.6 * fem,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 41, 183, 240),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup9yfvWDh (MRqYCPJHixwSAyb51B9YfV)
                    padding: EdgeInsets.fromLTRB(
                        34.3 * fem, 0 * fem, 0 * fem, 0 * fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // placeholderEfV (I688:3028;769:36909)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 244.66 * fem, 1.07 * fem),
                          child: Text(
                            '',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 2 * ffem / fem,
                              color: const Color(0xff4f4f4f),
                            ),
                          ),
                        ),
                        Container(
                          // group11712747845w1 (I688:3028;769:36961)
                          width: 24.6 * fem,
                          height: 24.6 * fem,

                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // mentornamepricetagCEw (I688:3028;769:36891)
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0.41 * fem, 0 * fem),
              width: double.infinity,
              height: 30.75 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // group47390K4f (I688:3028;769:36892)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 206.67 * fem, 0 * fem),
                    width: 88.65 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19.989648819 * fem),
                    ),
                    child: Container(
                      // frame626087Sf5 (I688:3028;769:36893)
                      padding: EdgeInsets.fromLTRB(
                          3.08 * fem, 3.08 * fem, 3.08 * fem, 3.08 * fem),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff0f172a),
                        borderRadius: BorderRadius.circular(19.989648819 * fem),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x14342969),
                            offset: Offset(0 * fem, 4 * fem),
                            blurRadius: 20 * fem,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 86.91 * fem,
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame626081TaB (I688:3028;769:36895)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 2.31 * fem, 0 * fem),
                              width: 22.6 * fem,
                              height: 24.6 * fem,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(17.6831512451 * fem),
                                child: Image.network(
                                  "${widget.workshopItem.teacher_img}",
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'By ${widget.workshopItem.teacher}',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1 * ffem / fem,
                                    color: Color.fromARGB(255, 247, 245, 245),
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // pricetag3YP (I688:3028;769:36897)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0.38 * fem, 0 * fem, 0.38 * fem),
                    width: 48.44 * fem,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xfff4624d),
                      borderRadius: BorderRadius.circular(19.989648819 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x51dc5a3e),
                          offset: Offset(0 * fem, 3.0753304958 * fem),
                          blurRadius: 15.3766527176 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '\$${widget.workshopItem.price}',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 2 * ffem / fem,
                            color: const Color(0xff4f4f4f),
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkshopImage extends StatelessWidget {
  const WorkshopImage({
    super.key,
    required this.fem,
    required this.imageUrl,
  });

  final double fem;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 14 * fem,
      top: 0 * fem,
      child: Container(
        width: 350.59 * fem,
        height: 174.53 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.9143180847 * fem),
          gradient: const LinearGradient(
            begin: Alignment(-0, -1),
            end: Alignment(-0, -0.207),
            colors: <Color>[Color(0x7f000000), Color(0x7f000000)],
            stops: <double>[0, 1],
          ),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
