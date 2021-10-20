import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_kiosk/core/datasource/http_get.dart';
import 'package:ticket_kiosk/core/datasource/http_post.dart';
import 'package:ticket_kiosk/core/datasource/http_post_file.dart';
import 'package:ticket_kiosk/core/datasource/local_source.dart';
import 'package:ticket_kiosk/core/services/file_upload_service.dart';
import 'package:ticket_kiosk/core/services/place_service.dart';
import 'package:ticket_kiosk/features/create_account/domain/register_repository.dart';
import 'package:ticket_kiosk/features/create_account/domain/register_service.dart';
import 'package:ticket_kiosk/features/create_event/domain/create_event_repository.dart';
import 'package:ticket_kiosk/features/create_event/domain/create_event_service.dart';
import 'package:ticket_kiosk/features/home/domain/repositories/category_repository.dart';
import 'package:ticket_kiosk/features/home/domain/repositories/event_repository.dart';
import 'package:ticket_kiosk/features/home/domain/services/category_service.dart';
import 'package:ticket_kiosk/features/home/domain/services/event_service.dart';
import 'package:ticket_kiosk/features/login/domain/login_repository.dart';
import 'package:ticket_kiosk/features/login/domain/login_service.dart';

final serviceLocator=GetIt.instance;

Future<void> initServiceLocator() async {
  //! Features
  serviceLocator.registerFactory(() => EventService(serviceLocator()));
  serviceLocator.registerFactory(() => RegisterService(serviceLocator()));
  serviceLocator.registerFactory(() => CategoryService(serviceLocator()));
  serviceLocator.registerFactory(() => FileUploadService(serviceLocator()));
  serviceLocator.registerFactory(() => CreateEventService(serviceLocator()));
  serviceLocator.registerFactory(() => LoginService(serviceLocator(), serviceLocator()));
  // serviceLocator.registerFactory(() => PlaceService(serviceLocator()));

  // //////////////////////////////////////////////////////////////////////////////////////////////////
  //! Core
  serviceLocator.registerFactory(() => HttpGet(serviceLocator()));
  serviceLocator.registerFactory(() => HttpPost(serviceLocator()));
  serviceLocator.registerFactory(() => HttpPostFile(serviceLocator()));
  serviceLocator.registerLazySingleton(() => LocalSource(serviceLocator()));
  serviceLocator.registerLazySingleton<ILoginRepository>(() => LoginRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<IRegisterRepository>(() => RegisterRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<ICategoryRepository>(() => CategoryRepository(serviceLocator()));
  serviceLocator.registerLazySingleton<ICreateEventRepository>(() => CreateEventRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<IEventRepository>(() => EventRepositoryImpl(serviceLocator()));
  // //////////////////////////////////////////////////////////////////////////////////////////////////
  //! External
  final sharedPreferences=await SharedPreferences.getInstance();

  // serviceLocator.registerLazySingleton(() => Client());
  serviceLocator.registerLazySingleton(() => sharedPreferences);
}