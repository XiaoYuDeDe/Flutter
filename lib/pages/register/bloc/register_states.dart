class RegisterStates{
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  //If don't assign it value, when call it the default value is ""
  //{} is optional named parameter
  const RegisterStates({
      this.userName="",
      this.email="",
      this.password="",
      this.confirmPassword=""
  });

  /**
   * //uses the earlier elements and then create a new one based on the old and new data provided
   * takes the older object first if it exists, it takes that one and copy the properties from this
   */
  RegisterStates copyWith({
      String? userName,
      String? email,
      String? password,
      String? confirmPassword}) {
    return RegisterStates(
        userName:userName ?? this.userName, //check is this username exist then use it, if it doesn't exist use the earlier one.
        email:email ?? this.email,
        password:password ?? this.password,
        confirmPassword:confirmPassword ?? this.confirmPassword
    );
  }
}