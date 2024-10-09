import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:budgeting_kuy/src/assets/dummy/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the app starts
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

  @override
  Widget build(BuildContext context) {
    double fullSizeWidth = MediaQuery.of(context).size.width;
    double fullSizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 238, 248, 201),
          width: fullSizeWidth,
          height: fullSizeHeight,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "K\nE\nL\nU\nA\nR",
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 221, 222, 163),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: ListView.builder(
                          itemCount: dataDummy.uangKeluar.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 25, left: 25),
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 208, 108, 108),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Rp${dataDummy.uangKeluar[index]}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "M\nA\nS\nU\nK",
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 211, 212, 163),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: ListView.builder(
                          itemCount: dataDummy.uangMasuk.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 25, left: 25),
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 166, 243, 166),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Rp${dataDummy.uangMasuk[index]}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 34, 34, 34),
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
