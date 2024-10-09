import 'package:budgeting_kuy/src/features/data_entry_screen.dart';

import 'package:flutter/material.dart';
import 'package:budgeting_kuy/src/assets/dummy/daftar_logo.dart';

class DetailScreenWeb extends StatelessWidget {
  final DaftarLogo daftarLogo;
  const DetailScreenWeb({super.key, required this.daftarLogo});

  @override
  Widget build(BuildContext context) {
    final path = daftarLogo.namaLogo;
    Widget content;

    switch (path) {
      case 'Withdrawal':
        content = const EntryDataScreen(
          tipe: "Pengeluaran",
        );
        break;
      case 'Deposit':
        content = const EntryDataScreen(
          tipe: "Pemasukan",
        );
        break;
      default:
        content = const Center(child: Text("Halaman Belum ditemukan."));
    }

    return Scaffold(
      body: content,
    );
  }
}
