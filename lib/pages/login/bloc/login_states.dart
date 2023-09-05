class LoginStates {
  final String email;
  final String password;

  const LoginStates({this.email = "", this.password = ""});

  /// for copy last object not all properties
  LoginStates copyWith({String? email,String? password}){// optional named parameters
    return LoginStates(
        email: email ?? this.email,
        password: password ?? this.password
    );
  }
}