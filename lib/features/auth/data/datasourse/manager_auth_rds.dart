import 'package:sharq_crm/core/error/exception.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

abstract class ManagerAuthRemoteDataSource {
  Future<ManagerEntity> loginManager({required Map authData});

  Future<ManagerEntity> registerManager({required Map authData});

  Future<bool> logOutManager();
}

class ManagerAuthRemoteDataSourceImpl implements ManagerAuthRemoteDataSource {
  final firebaseAuth.FirebaseAuth auth;

  ManagerAuthRemoteDataSourceImpl({required this.auth});

  firebaseAuth.User? get currentManager => auth.currentUser;

  @override
  Future<ManagerEntity> registerManager({required Map authData}) async {
    try {
      final firebaseManager = await auth.createUserWithEmailAndPassword(
        email: authData['email'],
        password: authData['password'],
      );

      final ManagerEntity manager = ManagerEntity(
        id: firebaseManager.user!.uid,
        name: firebaseManager.user!.displayName ?? "",
        email: firebaseManager.user!.email ?? "",
      );

      return Future.value(manager);
    } on firebaseAuth.FirebaseAuthException catch (e) {
      throw FirebaseDataException(e.message!);
    }
  }

  @override
  Future<ManagerEntity> loginManager({required Map authData}) async {
    try {
      final firebaseManager = await auth.signInWithEmailAndPassword(
        email: authData['email'],
        password: authData['password'],
      );

      final ManagerEntity manager = ManagerEntity(
        id: firebaseManager.user!.uid,
        name: firebaseManager.user!.displayName ?? "",
        email: firebaseManager.user!.email ?? "",
      );
      return Future.value(manager);
    } on firebaseAuth.FirebaseAuthException catch (e) {
      throw FirebaseDataException(e.message!);
    }
  }

  @override
  Future<bool> logOutManager() async {
    try {
      await auth.signOut();

      return true;
    } catch (e) {
      throw (OfflineException);
    }
  }
}
