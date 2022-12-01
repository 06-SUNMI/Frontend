import 'package:get/get.dart';
import 'package:sunmi/data/provider/sns_post_provider.dart';

class SNSPostRepository {
  final SNSPostProvider snsPostProvider;

  SNSPostRepository({
    required this.snsPostProvider
  });

  postNewSNSPost(memberId, fileToPost, fileType, content){
    return snsPostProvider.postNewSNSPost(memberId, fileToPost, fileType, content);
  }
}