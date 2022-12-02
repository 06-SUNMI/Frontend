import 'dart:io';
import 'package:get/get.dart';
import 'package:sunmi/data/model/sns_post.dart';
import 'url.dart';

class SNSPostProvider extends GetConnect {
  Future<Response> postSNSPost(int memberId, FormData data) =>
      // post('$baseURL/sns/posts/members/$memberId',data, headers: {'Content-Type': 'multipart/form-data'});
      post('$baseURL/sns/posts/members/$memberId',data, contentType: 'multipart/form-data');


  postNewSNSPost(int memberId, File fileToPost, String fileType, String content) async {
    final List<MultipartFile> snsPostFiles = [];
    snsPostFiles.add(MultipartFile(fileToPost.path, filename: 'content.$fileType'));
    print(snsPostFiles);
    print(content);
    final formData = FormData({
      'snsPostContent': content,
      'snsPostsImageOrVideoFileList': snsPostFiles,
    });

    var snsResponse = await postSNSPost(memberId, formData );
    print('head: '+ snsResponse.headers.toString());
    print('body: '+ snsResponse.body.toString());
    return snsResponse.body;
  }
}