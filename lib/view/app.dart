import 'package:question_one/service/local_storage_service.dart';
import 'package:question_one/service/network_service.dart';
import 'package:question_one/view/home/home.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      initial: true,
      page: Home,
    )
  ],
  dependencies: [
    LazySingleton(classType: NetworkService),
    LazySingleton(classType: LocalStorageService),
  ],
)
class AppSetup {}
