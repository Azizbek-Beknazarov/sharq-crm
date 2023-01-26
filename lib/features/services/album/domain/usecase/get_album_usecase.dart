import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';


class GetAlbumUseCase extends UseCase<List<AlbumEntity>, NoParams> {
  final AlbumRepo repo;

  GetAlbumUseCase({required this.repo});

  @override
  Future<Either<Failure, List<AlbumEntity>>> call(NoParams params) async {
    return await repo.getAlbum();
  }
}
