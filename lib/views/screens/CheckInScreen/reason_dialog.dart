import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/check_in_controller.dart';

class ReasonDialog extends StatefulWidget {

  late String id;
  late String category;

  ReasonDialog({super.key,required this.category,required this.id});
  @override
  _ReasonDialogState createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  TextEditingController _controller = TextEditingController();
  CheckInController _checkInController = Get.put(CheckInController());
  final int _maxLength = 120;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Grund angeben'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(8.0),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, color: Colors.white),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Deine Arbeitszeiterfassung entspricht nicht der Schichtplanung. Bitte gib einen Grund für den ausserordentlichen Start deiner Arbeitszeiterfassung an.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _controller,
            maxLength: _maxLength,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Grund angeben',
              counterText: '${_controller.text.length} / $_maxLength',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('ABBRECHEN', style: TextStyle(color: Colors.brown)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('SPEICHERN', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            if(_controller.text.isNotEmpty){
              _checkInController.postReason(widget.id,widget.category);
            }
          },
        ),
      ],
    );
  }
}