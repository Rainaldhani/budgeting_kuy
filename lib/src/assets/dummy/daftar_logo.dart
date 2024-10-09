class DaftarLogo {
  String namaLogo;
  String imgAsset;
  String path;

  DaftarLogo({
    required this.namaLogo,
    required this.imgAsset,
    required this.path,
  });
}

var daftarLogoList = [
  DaftarLogo(
    namaLogo: "Withdrawal",
    imgAsset: "lib/src/assets/images/withdrawal.png", // Path logo 1
    path: 'package:budgeting_kuy/src/features/pengeluaran_screen.dart',
  ),
  DaftarLogo(
    namaLogo: "Deposit",
    imgAsset: "lib/src/assets/images/deposit.png", // Path logo 2
    path: "lib/src/features/detail_screen.dart",
  ),
  DaftarLogo(
    namaLogo: "History",
    imgAsset: "lib/src/assets/images/file.png", // Path logo 3
    path: "lib/src/features/detail_screen.dart",
  ),
];
