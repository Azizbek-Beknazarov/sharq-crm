import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entity/album_entity.dart';

abstract class AlbumRepo {
  Future<Either<Failure, List<AlbumEntity>>> getAlbum();
  Future<Either<Failure, List<AlbumEntity>>> getAlbumForCustomer(String customerId);

  Future<void> addAlbum(AlbumEntity newAlbum, String customerId);
  Future<void> deleteAlbum( String customerId,String albumID);

}
