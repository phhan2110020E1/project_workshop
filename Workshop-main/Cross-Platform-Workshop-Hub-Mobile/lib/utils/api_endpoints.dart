// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

class ApiEndPoints {
  static const String baseUrl = 'http://192.168.1.28:8089/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
  static _TeacherEndPoints teacherEndPoints = _TeacherEndPoints();
  static _HomePageEndPoints homePageEndPoints = _HomePageEndPoints();
  static _StudentEndPoints studentEndPoints = _StudentEndPoints();
}

class _AuthEndPoints {
  final String register = 'auth/user/register';
  final String loginWebAccount = 'auth/loginWeb';
  final String loginOAuthen = 'auth/loginOAuthentication';
  final String resetPassword = 'auth/user/forgetPassword';
  final String editProfile = 'auth/user/edit';

}

class _HomePageEndPoints {
  final String listWorkshop = 'web/course/list';
  final String listRating = 'web/rating/list';
  final String workShopById = 'web/course/detail';
  final String checkUserInCourse = 'web/course/checkedUser';
  final String ListTeacherSortByRating = 'web/rating/top-teachers';
  final String ListWorkShopSortByRating = 'web/rating/workshop';
}

class _StudentEndPoints {
  
  final String like = 'user/like';
  final String checklike = 'user/like/checkedUser';
  final String checklikementor = 'user/like/check-like-mentor';
  final String listFavorite = 'user/list-favorite';
  final String studentInfo = 'user/detail';
  final String studentBuyWorkshop = 'user/byCourse';
  final String workshopEndroll = 'user/course/list';
  final String workshopDetailList = 'user/course/detail';
  final String wallet = 'user/wallet';
  final String deposit = 'user/deposit';
  final String ratings = 'user/ratings';
  final String buyWorkshop = 'user/byCourse';
  final String checkDiscount = 'user/checkDiscount';
  // String getcheckDiscount(int courseId, String code) {
  //   return '$checkDiscount?courseId=$courseId&code=$code';
  // }
}

class _TeacherEndPoints {
  final String listWorkshop = 'seller/course/list';
  final String addWorshop = 'seller/course/add';
  final String editWorshop = 'seller/course/update';
  final String deleteWorshop = 'seller/course/delete';
  final String sendDiscountToListStudent = 'seller/course/addListStudent';
  final String teacherDetail = 'seller/detail';
  final String teacherDetailEdit = 'seller/edit';
  final String deleteAddressAccount = 'seller/deleteAddress';
  final String listStudentInWorkshop = 'seller/course/listStudent';
  final String withdraw = 'seller/deposit';
  final String checkTicket = 'seller/checkTicket';
  final String listWorshopId = 'seller/course/list';
}
