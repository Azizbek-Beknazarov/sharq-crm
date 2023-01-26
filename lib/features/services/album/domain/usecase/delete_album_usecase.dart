import 'package:sharq_crm/core/usecase/usecase.dart';

import '../repository/album_repo.dart';


class DeleteAlbumClubUsecase
    extends UseCaseOne<void, AlbumDeleteParams> {
  final AlbumRepo repo;

  DeleteAlbumClubUsecase({required this.repo});

  @override
  Future<void> call({required AlbumDeleteParams params}) async {
    return await repo.deleteAlbum(
        params.customerId, params.albumID);
  }
}
