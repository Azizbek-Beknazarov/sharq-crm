

import 'package:flutter/material.dart';

const CACHED_MANAGER = 'CACHED_MANAGER';
const CACHED_CUSTOMER = 'CACHED_CUSTOMER';
//
const ADD_SUSCESS_MESSAGE = "Muvafaqqiyatli qo\'shildi";
const DELETE_SUSCESS_MESSAGE = "Muvafaqqiyatli o\'chirildi";
const UPDATE_SUSCESS_MESSAGE = "Muvafaqqiyatli yangilandi";
const DONE_SUSCESS_MESSAGE = "Muvafaqqiyatli";
const LOGOUT_MESSAGE = "Muvafaqqiyatli chiqildi";
//
const String SERVER_FAILURE_MESSAGE = 'Server Xatosi';
const String CACHE_FAILURE_MESSAGE = 'Cache Xatosi';
const String OFFLINE_FAILURE_MESSAGE = 'Iltimos, internetni tekshiring!';
const String INVALID_DATA_FAILURE_MESSAGE = 'Ism yoki parol xato!';
const String CANCELED_BY_USER_FAILURE_MESSAGE = 'Bekor qilindi';
const String NOT_FOUND_FAILURE_MESSAGE = 'Topilmadi';
const String INVALID_DATE_FAILURE_MESSAGE =
    'Vaqt va sana noto\'g\'ri!';
//
final primaryColor = Color(0xff082659);
final secondaryColor = Color(0xff51eec2);


// int ts = widget.customer.dateOfSignUp;
// DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
// String datetime = tsdate.year.toString() +
//     "/" +
//     tsdate.month.toString() +
//     "/" +
//     tsdate.day.toString() +
//     " | " +
//     tsdate.hour.toString() +
//     ":" +
//     tsdate.minute.toString();
//
//
// class UserDTO {
//   UserDTO({
//     this.id
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.occupation,
//   });
//
//   int id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? occupation;
//
//   factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
//     id: json["id"],
//     email: json["email"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     occupation: json["occupation"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "email": email,
//     "first_name": firstName,
//     "last_name": lastName,
//     "occupation": occupation,
//   };
// }
//
//
//
// class UserRemoteDataSource {
//   final HttpHandler httpHandler;
//
//   const UserRemoteDataSource({required this.httpHandler});
//
//   Future<UserDTO> getUserDetails(String userId) async {
//     final String url =
//         HttpRequestUrl.create(Constants.endpoint.userDetails);
//
//     final Map<String, dynamic> params = {
//       "user_id": userId,
//     };
//
//     try {
//       final response = await httpHandler.get(
//         url: url,
//         queryParameters: params,
//       );
//       return UserDto.fromJson(response);
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<List<UserDTO>> getUserList({required String companyId}) {
//     // TODO: implement getUserList
//     throw UnimplementedError();
//   }
// }
//
// class UserRepositoryImpl extends UserRepository {
//   late UserRemoteDataSource _remoteDataSource;
//
//   UserRepositoryImpl({
//     required UserRemoteDataSource userRemoteDataSource,
//   }) {
//     _remoteDataSource = userRemoteDataSource;
//   }
//
//   @override
//   Future<Either<Failure, UserEntity>> getUserDetails({
//     required String userId,
//   }) async {
//     try {
//       UserDTO userDto =
//           await _remoteDataSource.getUserDetails(
//         userId,
//       );
//
//       UserEntity result =
//           mapper.mapDTOtoEntity(userDto);
//
//       return Right(result);
//     } on Exception catch (e) {
//       rethrow;
//     }
//   }
// }
//
//
// class UserEntity extends Equatable {
//   const UserEntity({
//     required this.id,
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.occupation,
//   });
//
//   final int id;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String occupation;
//
//   String fullName() => firstName + " $lastName";
//
//   @override
//   List<Object?> get props => [
//         id,
//         email,
//         firstName,
//         lastName,
//         occupation,
//       ];
// }
//
// class GetUserDetailsUseCase extends UseCase<UserEntity, UserDetailParams> {
//   final UserRepository repository;
//
//   const GetUserDetailsUseCase({required this.repository});
//
//   @override
//   Future<Either<Failure, UserEntity>> call(UserDetailParams params) {
//     return repository.getUserDetails(userId: params.userId);
//   }
// }
//
//
// class UserDetailsController extends GetxController {
//   late GetUserDetailsUsecase _useCase;
//
//   Rx<String> fullName = "".obs;
//   Rx<String> occupation = "".obs;
//   int userId = 1;
//
//   UserDetailsController({
//     required GetUserDetailsUsecase useCase,
//   }) {
//     _useCase = useCase;
//   }
//
//   @override
//   void onInit() {
//     getUserDetails(userId);
//
//     super.onInit();
//   }
//
//   Future<void> getUserDetails(String userId) async {
//     final result = await _useCase.call(params);
//
//     result.fold((Failure failure) {
//       debugPrint(“Failed to fetch the data“);
//     }, (data) {
//       fullName.value = data.fullName();
//       occupation.value = data.occupation;
//     });
//   }
// }
//
//
// class UserDetailsPage extends StatelessWidget {
//   final UserDetailsController _controller = Get.find<UserDetailsController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Details"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Text("Hello world!"),
//                 _buildUserInformationWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildUserInformationWidget() {
//     return Container(
//       child: Obx(
//         () => Column(
//           children: <Widget>[
//             Text("My name is: ${_controller.fullName.value}"),
//             Text("My occupation is: ${_controller.occupation.value}"),
//           ],
//         ),
//       ),
//     );
//   }
// }


//   @override
//   Future<List<CustomerModel>> searchCustomer(String query) {
//
//     // StreamBuilder(
//     //     stream: ( searchtxt!= "" && searchtxt!= null)?FirebaseFirestore
//     //         .instance.collection("addjop")
//     //         .where("specilization",isNotEqualTo:searchtxt)
//     //         .orderBy("specilization")
//     //         .startAt([searchtxt,])
//     //         .endAt([searchtxt+'\uf8ff',])
//     //         .snapshots()
//     //         :FirebaseFirestore.instance.collection("addjop").snapshots(),
//     //
//     //
//     //     builder:(BuildContext context,snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.waiting &&
//     //           snapshot.hasData != true) {
//     //         return Center(
//     //           child:CircularProgressIndicator(),
//     //         );
//     //       }
//     //       else
//     //       {retun widget();
//     //       }
//     //     })
//
//
//     // return Future.value(cu)
//   }
// }

