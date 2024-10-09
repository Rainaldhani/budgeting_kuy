import 'dart:convert';
import 'dart:io';
import 'package:budgeting_kuy/src/assets/dummy/data.dart';
import 'package:budgeting_kuy/src/features/detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budgeting_kuy/src/assets/dummy/daftar_logo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'; // Import path package

class GridMainScreen extends StatefulWidget {
  final List<DaftarLogo> daftarLogo;

  const GridMainScreen({super.key, required this.daftarLogo});

  @override
  State<GridMainScreen> createState() => _GridMainScreenState();
}

class _GridMainScreenState extends State<GridMainScreen> {
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
      body: Container(
        width: fullSizeWidth,
        height: fullSizeHeight,
        color: Colors.black38,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Colors.amber,
                child: Text(
                  'Rp${dataDummy.jumlahUang.toString()}',
                  style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 48,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                childAspectRatio: (1 / 0.3785),
                // Agar GridView menyesuaikan dengan tinggi
                shrinkWrap: true,
                // Matikan scroll di GridView
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(widget.daftarLogo.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DetailScreenWeb(
                              daftarLogo: widget.daftarLogo[index]);
                        }),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: fullSizeWidth,
                          height: fullSizeHeight,
                          color: Colors.amber,
                          child: Image.asset(
                            widget.daftarLogo[index].imgAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.center,
                              color: const Color.fromARGB(163, 255, 236, 179),
                              child: Text(
                                widget.daftarLogo[index].namaLogo,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 48,
                                ),
                              ),
                            )),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
