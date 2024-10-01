
// ignore_for_file: file_names

class GithubSignInResponseV2 {
  /// the [SignInStatusV2] [status]
  SignInStatusV2 status;

  /// the [accessToken] from Github
  String? accessToken;

  /// the [error] message when call the github API
  String? error;
  String? email;
  String? name;
  String? picture;

  GithubSignInResponseV2({
    required this.status,
    this.accessToken,
    this.error,
    this.email,
    this.name,
    this.picture,
  });

  @override
  String toString() {
    return 'GithubSignInResponse{status: $status, accessToken: $accessToken, error: $error, email: $email, name: $name, picture: $picture}';
  }
}

enum SignInStatusV2 { success, failed, canceled }
