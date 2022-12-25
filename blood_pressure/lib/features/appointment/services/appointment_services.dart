import 'dart:convert';

import 'package:blood_pressure/constants/error_handling..dart';
import 'package:blood_pressure/models/booking.dart';
import 'package:blood_pressure/models/doctor.dart';
import 'package:blood_pressure/models/schedule.dart';
import 'package:blood_pressure/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:blood_pressure/constants/global_variables.dart';
import 'package:blood_pressure/constants/util.dart';
import 'package:provider/provider.dart';

class AppointmentServices {
  Future<List<doctor>> Doctor(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/getDoctor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${userProvider.user.token}',
        },
      );
      if (res.statusCode == 200) {
        final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
        return parsed.map<doctor>((json) => doctor.fromJson(json)).toList();
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Exception(e);
    }
  }

  Future<List<Schedule>> Schedules(
    context,
    doctorId,
    date,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/schedule/getSchedule/$doctorId'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'bearer ${userProvider.user.token}',
              },
              body: json.encode({
                'date': date,
              }));

      if (res.statusCode == 200) {
        final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
        return parsed.map<Schedule>((json) => Schedule.fromJson(json)).toList();
      } else {
        throw Exception(res.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Exception(e);
    }
  }

  Future updateSchedule(context, doctorId, timeType, date, isAvailable) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Schedule indexBooking = Schedule(
        doctorId: doctorId,
        timeType: timeType,
        date: date,
        isAvailable: isAvailable,
      );
      http.Response res = await http.patch(
        Uri.parse('$uri/api/schedule/updateSchedule'),
        body: indexBooking.toJson(),
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

  Future booking(context, doctorId, timeType, date, isAvailable) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Booking indexBooking = Booking(
        doctorId: doctorId,
        timeType: timeType,
        date: date,
        isAvailable: isAvailable,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api/booking/enterBooking'),
        body: indexBooking.toJson(),
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
}
