
abstract class PhongTro{
  String maSo;
  int soNguoiO;
  double soDien;
  double soNuoc;
  PhongTro(this.maSo,this.soNguoiO,this.soDien,this.soNuoc);
  double TinhTienPhong();
  void showInfo(){
    print ("Mã số phòng: $maSo|Số người ở:$soNguoiO|Số điện sử dụng:$soDien|Số nước sử dụng:$soNuoc|Tiền phòng:${TinhTienPhong()}");
  }
}
class PhongLoaiA extends PhongTro{
  int soLanNguoiThanTham;
  PhongLoaiA(String maSo,int soNguoiO,double soDien,double soNuoc,this.soLanNguoiThanTham):super(maSo,soNguoiO,soDien,soNuoc);
  @override
  double TinhTienPhong(){
    return 1400+2*soDien+8*soNuoc+50*soLanNguoiThanTham;
  }
  @override
  void showInfo(){
    print("[Loại A] Mã số phòng: $maSo|Số người ở:$soNguoiO|Số điện sử dụng:$soDien|Số nước sử dụng:$soNuoc|Số lần người thân thăm:$soLanNguoiThanTham|Tiền phòng:${TinhTienPhong()}");
  }
}
class PhongLoaiB extends PhongTro{
  double giatui;
  int somay;
  PhongLoaiB(String maSo,int soNguoiO,double soDien,double soNuoc,this.giatui,this.somay): super(maSo,soNguoiO,soDien,soNuoc);
  @override
  double TinhTienPhong(){
    return 2000+2*soDien+8*soNuoc+5*giatui+100*somay;
  }
  @override
  void showInfo(){
    print("[Loại B]Mã số phòng: $maSo|Số người ở:$soNguoiO|Số điện sử dụng:$soDien|Số nước sử dụng:$soNuoc|Giặt ủi:$giatui|Số máy:$somay|Tiền phòng:${TinhTienPhong()}");
  }
}
