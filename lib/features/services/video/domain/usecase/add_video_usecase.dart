
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';

import '../repository/video_repo.dart';

class AddVideoUseCase extends UseCaseOne<void, VideoParams> {
  final VideoRepo repo;

  AddVideoUseCase({required this.repo});

  @override
  Future<void> call({required VideoParams params}) async{
   return await repo.addVideo(params.newVideo,params.customerId);
  }




}
