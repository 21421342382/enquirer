class AssetHelper {
  AssetHelper._internal();

  factory AssetHelper() => _instance;
  static final AssetHelper _instance = AssetHelper._internal();

  static final String fontAssetsPath = "assets/fonts";
  static final String imageAssetsPath = "assets/images";
  static final String jsonAssetsPath = "assets/animations";
  static final String baseEmployerProfilePicPath = "https://arcopen.space/files/uploads/employer";
  static final String baseMemberProfilePicPath = "https://arcopen.space/files/uploads/member";

  static String getAsset({required String name, AssetType assetType = AssetType.image}) {
    switch (assetType) {
      case AssetType.image:
        return "$imageAssetsPath/$name";
      case AssetType.font:
        return "$fontAssetsPath/$name";
      case AssetType.json:
        return "$jsonAssetsPath/$name";
    }
  }

  static String getEnquirerProfilePic({required String name}) {
    return "$baseEmployerProfilePicPath/$name";
  }

  static String getMemberProfilePic({required String name}) {
    return "$baseMemberProfilePicPath/$name";
  }
}

enum AssetType { image, font, json }
