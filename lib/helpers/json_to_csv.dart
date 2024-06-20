import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';


String jsonToCsv(List<Map<String, dynamic>> jsonData) {
  if (jsonData.isEmpty) {
    return '';
  }

  List<List<dynamic>> csvData = [];

  // Get the headers from the keys of the first element
  List<String> headers = jsonData[0].keys.toList();
  csvData.add(headers);

  // Add the data rows
  for (var item in jsonData) {
    List<dynamic> row = [];
    for (var header in headers) {
      row.add(item[header]);
    }
    csvData.add(row);
  }

  // Convert the list to CSV format
  String csv = const ListToCsvConverter().convert(csvData);
  return csv;
}


Future<void> _saveAndShareCsv(String csvData) async {
  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/data.csv';
  final file = File(path);

  // Write the CSV data to the file
  await file.writeAsString(csvData);

  // Share the file
  //await Share.shareFiles([path], text: 'CSV Data');
}