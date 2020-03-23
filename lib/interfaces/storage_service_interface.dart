import 'package:dart_cricket/interfaces/db/model_interface.dart';
import 'package:dart_cricket/interfaces/db/repository_interface.dart';
import 'package:dart_cricket/interfaces/service_interface.dart';

abstract class IStorageService extends IService {
  IRepository<T> getRepository<T extends IDbModel>();
}