class FavoriteDTO {
  final int ratingId;
  final String targetType;
  final int teacherId;
  final String teacherName;
  final String teacherImage;
  final double totalRating;
  final int totalLike;
  final int workId;
  final String workName;
  final String workImage;
  final double totalWorkshopRating;
  final int totalWorkshopLike;

  FavoriteDTO( {
    required this.ratingId,
    required this.targetType,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImage,
    required this.totalRating,
    required this.totalLike,
    required this.workId, 
    required this.workName,
    required this.workImage,
    required this.totalWorkshopRating,
    required this.totalWorkshopLike,
  });

  factory FavoriteDTO.fromJson(Map<String, dynamic> json) {
    return FavoriteDTO(
      ratingId: json['ratingId'] as int,
      targetType: json['targetType'] as String,
      teacherId: json['teacher_id'] as int,
      teacherName: json['teacher_name'] as String,
      teacherImage: json['teacher_image'] as String ?? '',
      totalRating: (json['total_rating'] as num).toDouble(),
      totalLike: json['total_like'] as int,
      workId: json['work_id'] as int,
      workName: json['work_name'] as String,
      workImage: json['work_image'] as String,
      totalWorkshopRating: (json['totalWorkshop_rating'] as num).toDouble(),
      totalWorkshopLike: json['totalWorkshop_like'] as int,
    );
  }
}
