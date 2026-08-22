import 'package:buoi2/BTTL2.dart';
import 'dart:io';
void main() async{

Future<List<MonHoc>> readFile(String fileName) async {
  List<MonHoc> ds = [];
  try {
    List<String> lines = await File(fileName).readAsLines();
    
    for (String line in lines) {
      if (line.trim().isEmpty) continue; 
      
      List<String> parts = line.split('#');
      
      
      if (parts.length < 5) {
        print("Dòng dữ liệu không hợp lệ (thiếu thông tin): $line");
        continue; 
      }
      String maMon = parts[0].trim();
      String tenMon = parts[1].trim();
      int soTC = int.tryParse(parts[2].trim()) ?? 0;

    
      if (maMon.startsWith('LT')) {
        double diemTL = double.tryParse(parts[3].trim()) ?? 0.0;
        double diemCK = double.tryParse(parts[4].trim()) ?? 0.0;
        ds.add(LyThuyet(maMon, tenMon, soTC, diemTL, diemCK));
        
      } else if (maMon.startsWith('TH')) {
        double kt1 = double.tryParse(parts[3].trim()) ?? 0.0;
        double kt2 = double.tryParse(parts[4].trim()) ?? 0.0;
        double kt3 = parts.length > 5 ? (double.tryParse(parts[5].trim()) ?? 0.0) : 0.0;
        ds.add(ThucHanh(maMon, tenMon, soTC, kt1, kt2, kt3));
        
      } else if (maMon.startsWith('DA')) {
       
        double gvhd = double.tryParse(parts[3].trim()) ?? 0.0;
        double gvpb = double.tryParse(parts[4].trim()) ?? 0.0;
        ds.add(DoAn(maMon, tenMon, soTC, gvhd, gvpb));
      }
    }
  } catch (e) {
    print('Lỗi hệ thống khi đọc file: $e');
  }
  
  return ds;
}
List<MonHoc>ds=await readFile("lib/monhoc.txt");
while (true) {
    print('\n===== QUẢN LÝ MÔN HỌC =====');
    print('1. Nhập thêm môn học từ bàn phím');
    print('2. Xuất danh sách môn học');
    print('3. Kiểm tra danh sách có tăng dần theo tên không');
    print('4. Sắp xếp tăng dần theo số tín chỉ');
    print('5. Cho biết các môn học có số tín chỉ cao nhất');
    print('6. Tìm kiếm môn học theo tên');
    print('7. Tính số tín chỉ trung bình của danh sách');
    print('0. Thoát');
    stdout.write('Chọn chức năng (0-7): ');
    
    String? choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        ds.add(nhapMotMonHoc());
        print("-> Đã thêm thành công!");
        break;
      case '2': // Xuất danh sách các môn học vừa nhập[cite: 1]
        print("\n--- DANH SÁCH MÔN HỌC ---");
        for (var mh in ds) {
          mh.showInfo();
        }
        break;
      case '3':
        bool isSorted = kiemTraSapXepTheoTen(ds);
        print(isSorted ? "-> Danh sách ĐÃ được sắp xếp tăng dần theo tên." : "-> Danh sách CHƯA được sắp xếp tăng dần theo tên.");
        break;
      case '4': // Sắp xếp danh sách môn học tăng dần theo số tín chỉ[cite: 1]
        ds.sort((a, b) => a.soTC.compareTo(b.soTC));
        print("-> Đã sắp xếp tăng dần theo số tín chỉ! Nhấn 2 để xem lại.");
        break;
      case '5': // Cho biết các môn học có số tín chỉ cao nhất[cite: 1]
        if (ds.isNotEmpty) {
          int maxTC = ds.map((m) => m.soTC).reduce((a, b) => a > b ? a : b);
          print("\n--- CÁC MÔN CÓ TÍN CHỈ CAO NHẤT ($maxTC TC) ---");
          ds.where((m) => m.soTC == maxTC).forEach((m) => m.showInfo());
        }
        break;
      case '6': // Tìm kiếm[cite: 1]
        stdout.write("Nhập tên môn học cần tìm: ");
        String tenTimKiem = stdin.readLineSync() ?? "";
        
        var ketQua = ds.where((m) => m.tenMon.toLowerCase().contains(tenTimKiem.toLowerCase())).toList();
        
        if (ketQua.isNotEmpty) {
          print("-> Thông tin môn học tìm thấy:");
          for (var mh in ketQua) {
            mh.showInfo();
          }
        } else {
          print("-> Không tìm thấy '$tenTimKiem'. Hãy nhập thông tin để thêm môn này vào cuối danh sách!");
          ds.add(nhapMotMonHoc(tenTimKiem));
          print("-> Đã thêm '$tenTimKiem' vào danh sách.");
        }
        break;
      case '7': // Tính số tín chỉ trung bình[cite: 1]
        if (ds.isEmpty) {
          print("Danh sách trống!");
        } else {
          double tbTC = ds.fold(0.0, (sum, mh) => sum + mh.soTC) / ds.length;
          print("-> Số tín chỉ trung bình của các môn: ${tbTC.toStringAsFixed(2)}");
        }
        break;
      case '0':
        print("Chương trình kết thúc.");
        return;
      default:
        print("Lựa chọn không hợp lệ!");
    }
  }
}