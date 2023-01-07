import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharq_crm/core/error/exception.dart';
import 'package:sharq_crm/core/util/constants.dart';
import 'package:sharq_crm/features/auth/data/model/manager_model.dart';

abstract class ManagerAuthLocalDataSource {
  Future<ManagerModel> getCurrentManager();

  Future<bool> logOutManager();

  Future<void> saveManager(ManagerModel managerToCache);
}

class ManagerAuthLocalDataSourceImpl implements ManagerAuthLocalDataSource {
  final SharedPreferences preferences;

  ManagerAuthLocalDataSourceImpl({required this.preferences});

  @override
  Future<ManagerModel> getCurrentManager() {
    final jsonString = preferences.getString(CACHED_MANAGER);
    if (jsonString != null) {
      return Future.value(ManagerModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> logOutManager() {
    final isDone=preferences.remove(CACHED_MANAGER);
    return isDone;
  }

  @override
  Future<void> saveManager(ManagerModel managerToCache) {
    return preferences.setString(CACHED_MANAGER, json.encode(managerToCache.toJson()));
  }
}
