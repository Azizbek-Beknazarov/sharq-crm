import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';


import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/album_entity.dart';


class GetAlbumForCustomerUseCase extends UseCase<List<AlbumEntity>, AlbumGetParams> {
  final AlbumRepo repo;

  GetAlbumForCustomerUseCase({required this.repo});

  @override
  Future<Either<Failure, List<AlbumEntity>>> call(AlbumGetParams params) async {
    return await repo.getAlbumForCustomer(params.customerId);
  }
}