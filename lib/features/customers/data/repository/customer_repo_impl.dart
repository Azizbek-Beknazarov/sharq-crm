import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/customer_repo.dart';
import '../datasourse/add_customer_r_ds.dart';

class CustomerRepositoryImpl implements CustomerRepository{
 final AddCustomerRDS remodeDS;
   NetworkInfo info;
  CustomerRepositoryImpl({required this.remodeDS,required this.info});
  @override
  Future<void> addNewCustomer(CustomerModel customerModel) async {
if(await info.isConnected){
  try {

    await remodeDS.createCustomer(customerModel);




  } catch (e) {
    return Future.error(e.toString());
  }
}

  }
}