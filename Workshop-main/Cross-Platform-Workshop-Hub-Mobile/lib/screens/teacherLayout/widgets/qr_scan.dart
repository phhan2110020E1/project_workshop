// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'package:workshop_mobi/api/api_service.dart';

class QrScan extends StatefulWidget {
  final String? token;
  final int? workshopId;

  const QrScan({Key? key, required this.token, required this.workshopId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isLoading = false;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void showSuccessDialog(String userName) {
    controller?.pauseCamera();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check-in Thành Công'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Icon(Icons.check_circle, color: Colors.green, size: 60),
                Text('$userName has Checked'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
                controller?.resumeCamera();
              },
            ),
          ],
        );
      },
    );
  }

  void showFailureDialog(String userName) {
    controller?.pauseCamera();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Check-in Không Thành Công'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Icon(Icons.error, color: Colors.red, size: 60),
                Text('$userName không thể check-in'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
                controller?.resumeCamera();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      handleScanResult(scanData);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void handleScanResult(Barcode? result) async {
    if (result != null) {
      setState(() {
        isLoading = true;
      });
      try {
        Map<String, dynamic> jsonData = jsonDecode(result.code!);
        int userId = jsonData['user_id'];
        int worskshopIdQr = jsonData['workshop_id'];
        String userName = jsonData['user_name'];
        if(widget.workshopId! == worskshopIdQr){
          final apiService = ApiService();
        print('User ID ${userId}');
        print('WorkShop ID ${widget.workshopId}');
        bool finalResult = await apiService.checkQrCode(
            widget.token, userId, widget.workshopId!);
        setState(() {
          isLoading = false;
          if (finalResult) {
            showSuccessDialog(userName);
          } else {
            showFailureDialog(userName);
          }
        });
        }else{
           setState(() {
            showFailureDialog(userName);
           });
        }

        // final apiService = ApiService();
        // print('User ID ${userId}');
        // print('WorkShop ID ${widget.workshopId}');

        // bool finalResult = await apiService.checkQrCode(
        //     widget.token, userId, widget.workshopId!);

        // setState(() {
        //   isLoading = false;
        //   if (finalResult) {
        //     showSuccessDialog(userName);
        //   } else {
        //     showFailureDialog(userName);
        //   }
        // });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Lỗi khi phân tích JSON: $e');
      }
    }
  }
}


