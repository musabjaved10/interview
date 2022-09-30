import 'package:question_one/api/api.dart';
import 'package:question_one/model/photo.dart';
import 'package:question_one/service/local_storage_service.dart';
import 'package:question_one/service/network_service.dart';
import 'package:question_one/view/app.locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  final NetworkService networkService = locator<NetworkService>();
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();
  bool isLoading = true;
  List<Photo> listOfPhotos = [];
  late SharedPreferences prefs;

  @override
  void initialise() {
    getPhotosForView();
  }

  Future getPhotosForView() async {
    isLoading = true;
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
    listOfPhotos = await LocalStorageService.db.getAllPhotos();
    if (listOfPhotos.isEmpty) {
      final res = await networkService.getRequest(Api.url);
      (res['data'] as List).map((p) {
        LocalStorageService.db.createPhoto(Photo.fromJson(p));
      }).toList();
    }
    bool isExpired = await isOneDayPassed();
    if (isExpired) {
      final res = await networkService.getRequest(Api.url);
      (res['data'] as List).map((p) {
        LocalStorageService.db.createPhoto(Photo.fromJson(p));
      }).toList();
    }
    listOfPhotos = await LocalStorageService.db.getAllPhotos();
    isLoading = false;
    notifyListeners();
  }

  Future<bool> isOneDayPassed() async {
    prefs = await SharedPreferences.getInstance();
    final String? dateString = prefs.getString('date');
    if (dateString == null) {
      await prefs.setString('date', DateTime.now().toString());
      return true;
    }
    final DateTime previousDate = DateTime.parse(dateString);
    final DateTime currentDate = DateTime.now();
    return currentDate.difference(previousDate).inDays >= 1;
  }
}
