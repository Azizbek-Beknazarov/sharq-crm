class FirebaseDataException implements Exception {
  final String message;

  FirebaseDataException(this.message);
}

class OfflineException implements Exception {}
class ServerException implements Exception {}

class CacheException implements Exception {}
class CanceledByUserException implements Exception {}