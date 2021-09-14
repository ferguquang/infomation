// class CovidResponse {
//   String? tinh;
//   String? tuvong;
//   String? homnay;
//   String? homqua;
//   String? tongnhiem;
//
//   CovidResponse(
//       {this.tinh, this.tuvong, this.homnay, this.homqua, this.tongnhiem});
//
//   CovidResponse.fromJson(Map<String, dynamic> json) {
//     tinh = json['tinh'];
//     tuvong = json['tuvong'];
//     homnay = json['homnay'];
//     homqua = json['homqua'];
//     tongnhiem = json['tongnhiem'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tinh'] = this.tinh;
//     data['tuvong'] = this.tuvong;
//     data['homnay'] = this.homnay;
//     data['homqua'] = this.homqua;
//     data['tongnhiem'] = this.tongnhiem;
//     return data;
//   }
// }

class CovidResponse {
  String? sourceCovid;
  List<Data>? data;

  CovidResponse({this.sourceCovid, this.data});

  CovidResponse.fromJson(Map<String, dynamic> json) {
    sourceCovid = json['source_covid'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_covid'] = this.sourceCovid;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? tinh;
  String? nhiem;
  String? tuvong;
  String? tongNhiem;
  String? tongTuvong;

  Data({this.tinh, this.nhiem, this.tuvong, this.tongNhiem, this.tongTuvong});

  Data.fromJson(Map<String, dynamic> json) {
    tinh = json['tinh'];
    nhiem = json['nhiem'];
    tuvong = json['tuvong'];
    tongNhiem = json['tong_nhiem'];
    tongTuvong = json['tong_tuvong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tinh'] = this.tinh;
    data['nhiem'] = this.nhiem;
    data['tuvong'] = this.tuvong;
    data['tong_nhiem'] = this.tongNhiem;
    data['tong_tuvong'] = this.tongTuvong;
    return data;
  }
}

