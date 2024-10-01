// ignore_for_file: file_names

class ListTeacherSortRating {
  final int id;
  final String fullName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String? imageUrl;
  final String gender;
  final double rating;
  final int likeCount;

  ListTeacherSortRating({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
    required this.gender,
    required this.rating,
    required this.likeCount,
  });

  // Tạo một instance từ một map (JSON)
  factory ListTeacherSortRating.fromJson(Map<String, dynamic> json) {
    return ListTeacherSortRating(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      userName: json['user_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['image_url'] as String?,
      gender: json['gender'] as String,
      rating: json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'] as double,
      likeCount: json['like'] as int,
    );
  }

  // Chuyển đổi đối tượng sang map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'user_name': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'image_url': imageUrl,
      'gender': gender,
      'rating': rating,
      'like': likeCount,
    };
  }
}
