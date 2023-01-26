
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';

class AddAlbumUseCase extends UseCaseOne<void, AlbumParams> {
  final AlbumRepo repo;

  AddAlbumUseCase({required this.repo});

  @override
  Future<void> call({required AlbumParams params}) async{
   return await repo.addAlbum(params.newAlbum,params.customerId);
  }




}
