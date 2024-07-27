

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../CheckInScreen/check_in_screen.dart';

class QRViewScreen extends StatefulWidget {
   String workType;

  QRViewScreen({super.key,required this.workType});

  @override
  State<StatefulWidget> createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),

      body:  QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),

      // body: QRView(
      //   key: qrKey,
      //   onQRViewCreated: _onQRViewCreated,
      //   overlay: QrScannerOverlayShape(
      //     borderColor: Colors.black54,
      //     borderRadius: 10.r,
      //     borderLength: 30,
      //     borderWidth: 10,
      //     cutOutSize: 300.h,
      //   ),
      // ),

      // body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       flex: 5,
      //       child: QRView(
      //         key: qrKey,
      //         onQRViewCreated: _onQRViewCreated,
      //         overlay: QrScannerOverlayShape(
      //           borderColor: AppColors.pointBoxColor,
      //           borderRadius: 10.r,
      //           borderLength: 30,
      //           borderWidth: 10,
      //           cutOutSize: 300.h,
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       flex: 1,
      //       child: Center(
      //         child: (result != null)
      //             ? Text('Barcode Type: ${result!.format}   Data: ${result!.code}')
      //             : Text('Scan a code'),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if(result !=null){
        debugPrint("=========> result : ${result!.code}");
        Get.to(CheckInScreen(workType: widget.workType, id:"${result!.code}",));
        }else{
          print('Errore Scan');
        }

      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}