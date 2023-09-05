abstract class ProfileEvents{
  const ProfileEvents();
}

class ImageUrlEvent extends ProfileEvents{
  final String imageUrl;
  const ImageUrlEvent(this.imageUrl);
}
