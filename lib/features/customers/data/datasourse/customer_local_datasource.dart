import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/util/constants.dart';

abstract class CustomerLocalDataSource {
  Future<CustomerModel> getCurrentCustomer();

  Future<void> saveCustomer(CustomerModel customerToCache);

  Future<bool> logOutCustomer();
}

class CustomerLocalDataSourceImpl implements CustomerLocalDataSource {
  final SharedPreferences preferences;

  CustomerLocalDataSourceImpl({required this.preferences});

  @override
  Future<CustomerModel> getCurrentCustomer() async {
    final jsonString = await preferences.getString(CACHED_CUSTOMER);
    if (jsonString != null) {
      return Future.value(CustomerModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveCustomer(CustomerModel customerToCache) {
    return preferences.setString(
        CACHED_CUSTOMER, json.encode(customerToCache.toJson()));
  }

  @override
  Future<bool> logOutCustomer() async {
    final isDone = await preferences.remove(CACHED_CUSTOMER);
    return isDone;
  }
}
