import 'package:f_test/model/stat_model.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({required ItemCode itemCode}) async {
    final response = {
      ItemCode.PM10: [
        {
          'daegu': "16",
          'chungnam': "10",
          'incheon': "9",
          'daejeon': "13",
          'gyeongbuk': "20",
          'sejong': "13",
          'gwangju': "9",
          'jeonbuk': "11",
          'gangwon': "18",
          'ulsan': "28",
          'jeonnam': "9",
          'seoul': "18",
          'busan': "12",
          'jeju': "9",
          'chungbuk': null,
          'gyeongnam': "12",
          'dataTime': "2023-02-12 08:00",
          'itemCode': "PM10",
          'gyeonggi': "12"
        },
        {
          'daegu': "0.002",
          'chungnam': "0.002",
          'incheon': "0.002",
          'daejeon': "0.002",
          'gyeongbuk': "0.002",
          'sejong': "0.002",
          'gwangju': "0.002",
          'jeonbuk': "0.002",
          'gangwon': "0.002",
          'ulsan': "0.002",
          'jeonnam': "0.002",
          'seoul': "0.002",
          'busan': "0.002",
          'jeju': "0.002",
          'chungbuk': "0.002",
          'gyeongnam': "0.002",
          'dataTime': "2023-02-12 07:00",
          'itemCode': "PM2.5",
          'gyeonggi': "0.002"
        },
      ],
      ItemCode.PM25: [
        {
          'daegu': "16",
          'chungnam': "10",
          'incheon': "9",
          'daejeon': "13",
          'gyeongbuk': "20",
          'sejong': "13",
          'gwangju': "9",
          'jeonbuk': "11",
          'gangwon': "18",
          'ulsan': "28",
          'jeonnam': "9",
          'seoul': "18",
          'busan': "12",
          'jeju': "9",
          'chungbuk': null,
          'gyeongnam': "12",
          'dataTime': "2023-02-12 08:00",
          'itemCode': "PM10",
          'gyeonggi': "12"
        },
        {
          'daegu': "0.002",
          'chungnam': "0.002",
          'incheon': "0.002",
          'daejeon': "0.002",
          'gyeongbuk': "0.002",
          'sejong': "0.002",
          'gwangju': "0.002",
          'jeonbuk': "0.002",
          'gangwon': "0.002",
          'ulsan': "0.002",
          'jeonnam': "0.002",
          'seoul': "0.002",
          'busan': "0.002",
          'jeju': "0.002",
          'chungbuk': "0.002",
          'gyeongnam': "0.002",
          'dataTime': "2023-02-12 07:00",
          'itemCode': "PM2.5",
          'gyeonggi': "0.002"
        },
      ]
    };
    Future.delayed(
      const Duration(milliseconds: 500),
    );
    return response[itemCode]!
        .map((item) => StatModel.fromJson(json: item))
        .toList();

    // final response = await Dio().get(
    //     "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty",
    //     queryParameters: {
    //       "serviceKey": serviceKey,
    //       "returnType": "json",
    //       "numOfRows": 40,
    //       "pageNo": 1,
    //       "sidoName": "전국",
    //       "ver": "1.0"
    //     });
    // return response.data["response"]["body"]["items"]
    //     .map(
    //       (item) => StatModel.fromJson(json: item),
    //     )
    //     .toList();
  }
}