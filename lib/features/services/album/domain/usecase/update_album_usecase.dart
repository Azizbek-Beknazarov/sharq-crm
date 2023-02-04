import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';

import '../../../../../core/usecase/usecase.dart';

class UpdateAlbumUseCase extends UseCaseOne<void, AlbumUpdateParams> {
  final AlbumRepo repo;

  UpdateAlbumUseCase({required this.repo});

  @override
  Future<void> call({required AlbumUpdateParams params}) async {
    return await repo.updateAlbum(
      params.albumId, params.customerId,);
  }
}