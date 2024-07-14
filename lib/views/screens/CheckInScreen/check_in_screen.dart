import 'package:flutter/material.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String _selectedWorkArea = 'Küche';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'milad saber samandari',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Arbeitsbereich',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Text('Service'),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[200],
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    ),
                    onPressed: () {
                      // Add your button press logic here
                    },
                    child: Text(
                      'ZEITERFASSUNG STARTEN',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
