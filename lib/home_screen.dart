import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as chart;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infomation/palete.dart';
import 'package:infomation/string.dart';
import 'covide_response.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<chart.Series<Data, String>> seriesList = [];
  CovidResponse? response;

  @override
  void initState() {
    super.initState();
    getDataCovid();
  }

  Future<void> getDataCovid() async {
    var json = await Dio().get('https://owsnews.herokuapp.com/covid');
    response = CovidResponse.fromJson(json.data);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dịch bệnh viêm đường hô hấp")),
      ),
      body: response == null ?
        Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ) :
        Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                "${response?.sourceCovid}",
                style: TextStyle(
                    color: Colors.blue
                ),
              ),
            ),
            SizedBox(height: 8,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.fiber_manual_record_rounded, color: Palette.tuvong.toColor(),),
                    Text("Số ca tử vong")
                  ],
                ),
                SizedBox(width: 16,),
                Row(
                  children: [
                    Icon(Icons.fiber_manual_record_rounded, color: Palette.nhiem.toColor(),),
                    Text("Số ca nhiễm")
                  ],
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: getWidth(),
                    child: chart.BarChart(
                        getData(),
                        animate: true,
                        vertical: true,
                        barGroupingType: chart.BarGroupingType.grouped,
                        behaviors: [
                          chart.SlidingViewport(),
                        ],
                        selectionModels: [
                          chart.SelectionModelConfig(
                            type: chart.SelectionModelType.info,
                            changedListener: _onSelectionChanged,
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  List<chart.Series<Data, String>> getData() {
    seriesList = [
      chart.Series<Data, String>(
        id: 'Statistics',
        colorFn: (Data dataType, __) => chart.Color.fromHex(code: Palette.tuvong),
        domainFn: (Data sales, _) => sales.tinh!,
        measureFn: (Data sales, _) => getInt(sales.tuvong!),
        data: response!.data!,
      ),
      chart.Series<Data, String>(
        id: 'Los Angeles Revenue',
        colorFn: (Data dataType, __) => chart.Color.fromHex(code: Palette.nhiem),
        domainFn: (Data sales, _) => sales.tinh!,
        measureFn: (Data sales, _) => getInt(sales.nhiem!),
        data: response!.data!,
      )
    ];
    return seriesList;
  }

  getWidth() {
    if (response != null) {
      return (75 * (response!.data!.length)).toDouble();
    } else {
      return 1000;
    }
  }

  int getInt(String tongnhiem) {
    if(tongnhiem.contains("\.")) {
      tongnhiem = tongnhiem.replaceAll("\.", "");
    }
    return int.parse(tongnhiem);
  }

  _onSelectionChanged(chart.SelectionModel model) {
    Data current = model.selectedDatum.first.datum;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Thông tin chi tiết",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "${current.tinh}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                  ),
                ),
                Text(
                  "Nhiễm:  ${current.nhiem}",
                ),
                Text(
                  "Số ca tử vong:  ${current.tuvong}",
                ),
                Text(
                    "Tổng nhiễm:  ${current.tongNhiem}"
                ),
                Text(
                    "Tổng tử vong:  ${current.tongTuvong}"
                ),
              ],
            ),
          );
        }
    );
  }
}
