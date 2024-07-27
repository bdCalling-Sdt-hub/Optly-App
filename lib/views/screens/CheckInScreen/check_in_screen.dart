import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optly/controller/check_in_controller.dart';
import 'package:optly/utils/app_colors.dart';
import 'package:optly/views/screens/CheckInScreen/reason_dialog.dart';
import 'package:optly/views/widgets/custom_page_loading.dart';

class CheckInScreen extends StatefulWidget {
   CheckInScreen({super.key,required this.workType,required this.id});

  String workType;
  String id;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String _selectedWorkArea = 'Küche';

  CheckInController _checkInController = Get.put(CheckInController());
  @override
  void initState() {
    _checkInController.getCheckInData(widget.workType, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios)),
      ),
      body: Obx(()=>_checkInController.loading.value?const CustomPageLoading():
         Card(
           margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
           elevation: 5,
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(
             _checkInController.checkInData.value.data!.info!.name.toString(),
                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                 ),
                 const SizedBox(height: 20),
                 const Text(
                   'Arbeitsbereich',
                   style: TextStyle(fontSize: 18),
                 ),
                 const SizedBox(height: 10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Radio<String>(
                       value: 'Küche',
                       groupValue: _selectedWorkArea,
                       onChanged: (String? value) {
                         setState(() {
                           _selectedWorkArea = value!;
                         });
                       },
                     ),
                     Text('Küche'),
                     SizedBox(width: 20),
                     Radio<String>(
                       value: 'Service',
                       groupValue: _selectedWorkArea,
                       onChanged: (String? value) {
                         setState(() {
                           _selectedWorkArea = value!;
                         });
                       },
                     ),
                     const Text('Service'),
                   ],
                 ),
                 const SizedBox(height: 20),
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.primaryColor,
                     padding:
                         const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                   ),
                   onPressed: () {
                     showDialog(
                       context: context,
                       builder: (BuildContext context) => ReasonDialog(category:_selectedWorkArea, id:widget.id,),
                     );
                   },
                   child: const Text(
                     'ZEITERFASSUNG STARTEN',
                     style: TextStyle(fontSize: 16,color: Colors.white),
                   ),
                 ),
               ],
             ),
           ),
         ),
      ),
    );
  }
}
