// ignore_for_file: file_names

class HomePageListRatingDTO {
  String? targetType;
  int? ratingId;
  int? workshopId;
  int? mentorId;
  String? workshopName;
  String? mentorName;
  String? workshopImg;
  String? mentorImg;
  String? userCommentName;
  int? userCommentId;
  String? userCommentImg;
  double? rating;
  String? comment;
  bool? status;

  HomePageListRatingDTO({
    this.targetType,
    this.ratingId,
    this.workshopId,
    this.mentorId,
    this.workshopName,
    this.mentorName,
    this.workshopImg,
    this.mentorImg,
    this.userCommentName,
    this.userCommentId,
    this.userCommentImg,
    this.rating,
    this.comment,
    this.status,
  });

  factory HomePageListRatingDTO.fromJson(Map<String, dynamic> json) {
    return HomePageListRatingDTO(
      targetType: json['targetType'],
      ratingId: json['rating_id'],
      workshopId: json['workshop_id'],
      mentorId: json['mentor_id'],
      workshopName: json['workshop_name'],
      mentorName: json['mentor_name'],
      workshopImg: json['workshop_img'],
      mentorImg: json['mentor_img'],
      userCommentName: json['user_comment_name'],
      userCommentId: json['user_comment_id'],
      userCommentImg: json['user_comment_img'],
      rating: json['rating'],
      comment: json['comment'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetType': targetType,
      'rating_id': ratingId,
      'workshop_id': workshopId,
      'mentor_id': mentorId,
      'workshop_name': workshopName,
      'mentor_name': mentorName,
      'workshop_img': workshopImg,
      'mentor_img': mentorImg,
      'user_comment_name': userCommentName,
      'user_comment_id': userCommentId,
      'user_comment_img': userCommentImg,
      'rating': rating,
      'comment': comment,
      'status': status,
    };
  }
}
