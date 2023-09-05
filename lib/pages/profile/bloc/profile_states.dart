class ProfileStates{
  final String imageUrl;

  const ProfileStates({
    this.imageUrl = ""
  }) ;

  ProfileStates copyWith({
    String? imageUrl
  }){
    return ProfileStates(
        imageUrl:imageUrl??this.imageUrl
    );
  }
}