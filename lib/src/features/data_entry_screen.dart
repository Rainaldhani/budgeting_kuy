import 'dart:convert'; // For JSON encoding/decoding
import 'dart:io'; // For file I/O

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'; // Import path package
import 'package:budgeting_kuy/src/assets/dummy/data.dart';

class EntryDataScreen extends StatefulWidget {
  final String tipe;
  const EntryDataScreen({super.key, required this.tipe});

  @override
  State<EntryDataScreen> createState() => _EntryDataScreenState();
}

class _EntryDataScreenState extends State<EntryDataScreen> {
  final TextEditingController _controller = TextEditingController();
  String _resultError = '';

  get tipe => widget.tipe;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the app starts
  }

  // Get file path to save/load data
  Future<String> _getFilePath() async {
    if (kIsWeb) {
      throw UnsupportedError("File handling not supported on web.");
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return join(directory.path,
          'data.dart'); // Use path.join for better compatibility
    }
  }

  // Write dataDummy to local storage or a file
  Future<void> _saveData() async {
    final filePath = await _getFilePath();
    final file = File(filePath);

    // Serialize dataDummy to JSON and write it to the file
    final dataJson = jsonEncode(dataDummy.toJson());
    await file.writeAsString(dataJson);
  }

  // Read dataDummy from local storage or a file
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

  Future<void> _evaluate() async {
    try {
      final expression = Expression.parse(_controller.text);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(expression, {});

      // Ensure the result is a number
      if (result is! num) {
        setState(() {
          _resultError = 'Invalid expression result.';
        });
        return;
      } else {
        _resultError = '';
      }

      // Calculate the new amount
      double resultAfterCalculation = dataDummy.jumlahUang;

      if (tipe == "Pengeluaran") {
        resultAfterCalculation = dataDummy.jumlahUang - result.toDouble();
        dataDummy.uangKeluar.add(result.toDouble());
        print("Adding to uangMasuk: ${result.toDouble()}"); // Debugging
      } else if (tipe == "Pemasukan") {
        resultAfterCalculation = dataDummy.jumlahUang + result.toDouble();
        dataDummy.uangMasuk.add(result.toDouble());
        print("Adding to uangMasuk: ${result.toDouble()}"); // Debugging
      }

      setState(() {
        dataDummy.jumlahUang = resultAfterCalculation; // Update jumlahUang
        _controller.text = '';
      });

      // Save the updated data
      await _saveData(); // Make sure this is awaited
    } catch (e) {
      setState(() {
        _resultError = 'Error $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Rp${dataDummy.jumlahUang.toString()}",
                  style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 24,
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: tipe,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _evaluate,
                child: const Text(
                  'Hitung',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _resultError,
                style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
