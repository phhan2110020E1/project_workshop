// ignore_for_file: file_names

class WorkshopRatingDTO {
  final int id;
  final String workshopName;
  final String workshopImageUrl;
  final int teacherId;
  final String teacherName;
  final String teacherImage;
  final double rating;
  final double price;

  WorkshopRatingDTO({
    required this.id,
    required this.workshopName,
    required this.workshopImageUrl,
    required this.teacherName,
    required this.teacherId,
    required this.teacherImage,
    required this.rating,
    required this.price,
  });

  factory WorkshopRatingDTO.fromJson(Map<String, dynamic> json) {
    return WorkshopRatingDTO(
      id: json['id'] as int,
      workshopName: json['workshop_name'] as String,
      workshopImageUrl: json['workshop_ImageUrl'] as String,
      teacherId: json['teacher_id'] as int,
      teacherName: json['teacher_name'] as String,
      teacherImage:
          json['teacher_image'] as String? ?? '', // Fallback to a default image
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workshop_name': workshopName,
      'workshop_ImageUrl': workshopImageUrl,
      'teacher_name': teacherName,
      'teacher_image': teacherImage,
      'rating': rating,
      'price': price,
    };
  }
}
