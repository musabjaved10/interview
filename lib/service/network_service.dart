import 'package:dio/dio.dart';
import 'package:question_one/model/photo.dart';

class NetworkService {
  final Dio _dio = Dio();

  Future<List> fetchPhotos(String url) async {
    Response response = await _dio.get(url);
    List<Photo> photos = [];
    if (response.statusCode != 200) {
      return [];
    }
    for (int i = 0; i < response.data.length; i++) {
      photos.add(Photo.fromJson(response.data[i]));
    }
    print('printing photos $photos');
    return photos;
  }
}
