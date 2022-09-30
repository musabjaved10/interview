import 'package:question_one/service/local_storage_service.dart';
import 'package:question_one/service/network_service.dart';
import 'package:question_one/view/app.locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final NetworkService networkService = locator<NetworkService>();
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();

  @override
  Future<List> getPhotosFromView() async {
    notifyListeners();
  }
}
