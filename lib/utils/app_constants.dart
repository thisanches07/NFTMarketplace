class AppConstants{
  static const String APP_NAME = "NFTMarketplace";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://api-nft-marketplace.herokuapp.com";
  // static const String BASE_URL = "http://10.0.2.2:8080";

  // NFTs
  static const String POPULAR_NFT_URI = "/nfts/popular";
  static const String RECOMMENDED_NFT_URI = "/nfts/recommended";
  
  // User
  static const String USERS_URI = "/users";
  static const String USER_INFO_URI = "/users/info";
  
  // Auth
  static const String SIGN_URI = "/auth/sign";
  static const String REGISTER_URI = "/auth/register";

  // Order
  static const String ORDER_URI = "/orders";

  // Items
  static const String ITEM_URI = "/items";

  static const String TOKEN = '';
  static const String USERNAME = '';
  static const String PHONE = '';
  static const String PASSWORD = '';
  static const String CART_LIST="cart-list";
  static const String CART_HISTORY_LIST="cart-history-list";
}