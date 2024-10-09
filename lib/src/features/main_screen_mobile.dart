import 'dart:convert';
import 'dart:io';
import 'package:budgeting_kuy/src/assets/dummy/data.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart'; // Import path package

class ListMainScreen extends StatefulWidget {
  const ListMainScreen({
    super.key,
  });

  @override
  State<ListMainScreen> createState() => _ListMainScreenState();
}

class _ListMainScreenState extends State<ListMainScreen> {
  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the app starts
  }

  Future<void> requestStoragePermissions(BuildContext context) async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if (!await Permission.storage.isGranted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Permission Denied"),
            content: const Text(
                "Storage permission is required to use this app. The app will close."),
            actions: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<String> _getFilePath() async {
    if (kIsWeb) {
      throw UnsupportedError("File handling not supported on web.");
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return join(directory.path,
          'data.dart'); // Use path.join for better compatibility
    }
  }

  Future<void> _saveData() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    // Serialize dataDummy to JSON and write it to the file
    final dataJson = jsonEncode(dataDummy.toJson());
    await file.writeAsString(dataJson);
  }

  Future<void> _loadData() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);

      // If the file exists, read from it and deserialize the data
      if (await file.exists()) {
        final fileContent = await file.readAsString();
        final jsonData = jsonDecode(fileContent);

        setState(() {
          dataDummy = DataDummy.fromJson(jsonData);
        });
      }
    } catch (e) {
      // Handle error (e.g., file not found or JSON decoding error)
      print('Error loading data: $e');
    }
  }

  Future<void> _reset() async {
    setState(() {
      dataDummy.jumlahUang = 0;
      dataDummy.uangKeluar = [];
      dataDummy.uangMasuk = []; // Update jumlahUang
    });

    // Save the updated data
    await _saveData(); // Make sure this is awaited
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 205, 222, 152),
              alignment: Alignment.bottomCenter,
              child: const Text(
                "Uang Kamu Sekarang: ",
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 205, 222, 152),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 223, 231, 103),
                ),
                child: Text(
                  'Rp${dataDummy.jumlahUang.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Lexend', fontSize: 32),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 205, 222, 152),
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: _reset,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 231, 63, 63)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  elevation: WidgetStatePropertyAll(0),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
