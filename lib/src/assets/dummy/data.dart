class DataDummy {
  String nama;
  double jumlahUang;
  List<double> uangMasuk;
  List<double> uangKeluar;

  DataDummy({
    required this.nama,
    this.jumlahUang = 0,
    required this.uangMasuk,
    required this.uangKeluar,
  });
  // Convert DataDummy to JSON
  Map<String, dynamic> toJson() => {
        'nama': nama,
        'jumlahUang': jumlahUang,
        'uangMasuk': uangMasuk,
        'uangKeluar': uangKeluar,
      };

  // Create DataDummy from JSON
  factory DataDummy.fromJson(Map<String, dynamic> json) {
    return DataDummy(
      nama: json['nama'],
      jumlahUang: json['jumlahUang'].toDouble(),
      uangMasuk: List<double>.from(json['uangMasuk']),
      uangKeluar: List<double>.from(json['uangKeluar']),
    );
  }
}

DataDummy dataDummy = DataDummy(
  nama: "Rei",
  jumlahUang: 0,
  uangMasuk: [1, 2, 3],
  uangKeluar: [1, 2, 3],
);  // Initial value
