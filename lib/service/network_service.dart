import 'package:dio/dio.dart';
import 'package:question_one/model/photo.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getRequest(String url) async {
    Response response = await _dio.get(url);
    if (response.statusCode != 200) {
      return {"status": response.statusCode, "data": []};
    }
    return {"status": response.statusCode, "data": response.data};
  }
}
