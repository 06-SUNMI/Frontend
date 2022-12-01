class SNSPost {
  int memberId;
  String Content;
  String? imageLink;
  String? videoLink;

  SNSPost({
    required this.memberId,
    required this.Content,
    this.imageLink,
    this.videoLink
  });

  factory SNSPost.fromJson(Map<String, dynamic> json){
    return SNSPost(
        memberId: json['memberId'],
        Content: json['snsContent'],
        videoLink: json['snsVideoLink'],
        imageLink: json['snsImageLink'],
    );
  }
}