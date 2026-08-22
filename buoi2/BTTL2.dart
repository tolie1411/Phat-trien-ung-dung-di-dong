import 'dart:io';
abstract class MonHoc{
  String maMon;
  String tenMon;
  int soTC;
  MonHoc(this.maMon,this.tenMon,this.soTC);
  double TinhDTB();
  void showInfo(){
    print("Mã môn học:$maMon|Tên môn học:$tenMon|Số tín chỉ:$soTC|Điểm trung bình:${TinhDTB()}");
  }
  String quyDoiDiemChu() {
    double dtb = TinhDTB();
    if (dtb >= 8.5) return 'A';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }
}
class LyThuyet extends MonHoc{
  double diemTL;
  double diemCK;
  LyThuyet(String maMon,String tenMon,int soTC,this.diemTL,this.diemCK):super(maMon,tenMon,soTC);
  @override
  double TinhDTB(){
    return diemTL*0.3+diemCK*0.7;
  }
  @override
  void showInfo(){
    print("[Lý thuyết] Mã môn học:$maMon|Tên môn học:$tenMon|Số tín chỉ:$soTC|Điểm tiểu luận:$diemTL|Điểm cuối kỳ:$diemCK|Điểm trung bình:${TinhDTB()}");
  }  
}
class ThucHanh extends MonHoc{
  double kt1;
  double kt2;
  double kt3;
  ThucHanh(String maMon,String tenMon,int soTC,this.kt1,this.kt2,this.kt3):super(maMon,tenMon,soTC);
  @override
  double TinhDTB(){
    return (kt1+kt2+kt3)/3;
  }
  @override
  void showInfo(){
     print("[Thực hành] Mã môn học:$maMon|Tên môn học:$tenMon|Số tín chỉ:$soTC|Điểm kiểm tra 1:$kt1|Điểm kiểm tra 2:$kt2|Điểm kiểm tra 3:$kt3|Điểm trung bình:${TinhDTB()}");
  }
}
class DoAn extends MonHoc{
  double gvhd;
  double gvpb;
  DoAn(String maMon,String tenMon,int soTC,this.gvhd,this.gvpb):super(maMon,tenMon,soTC);
  @override
  double TinhDTB(){
    return (gvhd+gvpb)/2;
  }
  @override
  void showInfo(){
     print("[Đồ án] Mã môn học:$maMon|Tên môn học:$tenMon|Số tín chỉ:$soTC|Điểm GVHD:$gvhd|Điểm GVPB:$gvpb|Điểm trung bình:${TinhDTB()}");
  }
}
MonHoc nhapMotMonHoc([String tenMacDinh = ""]) {
  print("\n--- NHẬP THÔNG TIN MÔN HỌC MỚI ---");
  stdout.write("Mã môn học: ");
  String ma = stdin.readLineSync() ?? "Unknown";
  
  String ten = tenMacDinh;
  if (ten.isEmpty) {
    stdout.write("Tên môn học: ");
    ten = stdin.readLineSync() ?? "Unknown";
  } else {
    print("Tên môn học: $ten");
  }

  stdout.write("Số tín chỉ: ");
  int tc = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  print("Chọn loại môn học (1: Lý thuyết, 2: Thực hành, 3: Đồ án): ");
  String loai = stdin.readLineSync() ?? "1";

  if (loai == '2') {
    stdout.write("Điểm KT 1: "); double k1 = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    stdout.write("Điểm KT 2: "); double k2 = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    stdout.write("Điểm KT 3: "); double k3 = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    return ThucHanh(ma, ten, tc, k1, k2, k3);
  } else if (loai == '3') {
    stdout.write("Điểm GVHD: "); double hd = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    stdout.write("Điểm GVPB: "); double pb = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    return DoAn(ma, ten, tc, hd, pb);
  } else {
    stdout.write("Điểm tiểu luận: "); double dtl = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    stdout.write("Điểm cuối kỳ: "); double dck = double.tryParse(stdin.readLineSync() ?? "0") ?? 0;
    return LyThuyet(ma, ten, tc, dtl, dck);
  }
}
bool kiemTraSapXepTheoTen(List<MonHoc> ds) {
  if (ds.isEmpty || ds.length == 1) return true;
  for (int i = 0; i < ds.length - 1; i++) {
    if (ds[i].tenMon.compareTo(ds[i + 1].tenMon) > 0) {
      return false;
    }
  }
  return true;
}