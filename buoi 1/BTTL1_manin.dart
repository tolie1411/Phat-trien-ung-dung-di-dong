import 'package:buoi2/BTTL1.dart';
import 'dart:io';

void main() async {
  Future<List<PhongTro>> readFile(String fileName) async {
  List<PhongTro> arrs = [];
  try {
    List<String> lines = await File(fileName).readAsLines();
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      
      // Tách dữ liệu theo dấu #
      List<String> parts = line.split('#'); 
      String maSo = parts[0].trim();
      int soNguoiO = int.parse(parts[1].trim());
      double soDien = double.parse(parts[2].trim());
      double soNuoc = double.parse(parts[3].trim());

      // Phân loại phòng dựa trên ký tự đầu của Mã phòng và số lượng phần tử
      if (maSo.startsWith('A') && parts.length == 5) {
        int soLanNguoiThanTham = int.parse(parts[4].trim());
        arrs.add(PhongLoaiA(maSo, soNguoiO, soDien, soNuoc, soLanNguoiThanTham));
      } else if (maSo.startsWith('B') && parts.length == 6) {
        double giatUi = double.parse(parts[4].trim());
        int soMay = int.parse(parts[5].trim());
        arrs.add(PhongLoaiB(maSo, soNguoiO, soDien, soNuoc, giatUi, soMay));
      }
    }
  } catch (e) {
    print('Lỗi khi đọc file: $e');
  }
  return arrs;
}
  List<PhongTro> ds = await readFile('lib/phongthue.txt');
  print("Đọc dữ liệu từ file: ");
  for (PhongTro p in ds) {
    p.showInfo();
  }
  print("\n");
  //danh sách các phòng có số người thuê lớn hơn 2
  print("Danh sách các phòng có số người thuê lớn hơn 2:");
  for(PhongTro p in ds){
    if(p.soNguoiO>2){
      p.showInfo();
    }
  }
  print("\n");
  //tổng tiền phòng
  double TinhTongTien=ds.fold(0, (sum,p)=>sum+p.TinhTienPhong());
  print("Tổng tiền thu từ các phòng: $TinhTongTien");
  print("\n");
  //sắp xếp số điện giảm dần
  ds.sort((a,b)=>b.soDien.compareTo(a.soDien));
  print("Dánh sách các phòng xếp theo số điện giảm dần:");
  for(PhongTro p in ds){
    p.showInfo();
  }
  print("\n");
  //In dánh sách các phòng loại A
  print("Danh sách các phòng loại A:");
  for(PhongTro p in ds){
    if(p is PhongLoaiA){
      p.showInfo();
    }
  }
}
