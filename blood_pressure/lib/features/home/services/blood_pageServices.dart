import 'dart:convert';
import 'package:blood_pressure/models/chartData.dart';
import 'package:blood_pressure/models/indexBlood.dart';
import 'package:http/http.dart' as http;
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/constants/util.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handling..dart';
import 'package:blood_pressure/provider/user_provider.dart';

class BloodPageService {
  Future bloodData(context, sys, dia, pulse) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      IndexBlood indexBlood = IndexBlood(
        sys: sys,
        dia: dia,
        pulse: pulse,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/bloodPressure/enterBloodPressure'),
        body: indexBlood.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}'
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<ChartData>> chartBloodPressure(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/bloodPressure/getBloodPressure/${userProvider.user.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}'
        },
      );

      final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
      return parsed.map<ChartData>((json) => ChartData.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
