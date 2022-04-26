import 'package:get/get.dart';
import 'package:nftmarketplace/data/repository/popular_nft_repo.dart';

import '../../models/nfts_model.dart';
import '../data/repository/recommended_product_repo.dart';


class RecommendedNftController extends GetxController{
  final RecommendedNftRepo recommendedNftRepo;
  RecommendedNftController({required this.recommendedNftRepo});
  List<dynamic> _recommendedNftList=[];
  List<dynamic> get recommendedNftList => _recommendedNftList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedNftList() async{
    Response response = await recommendedNftRepo.getRecommendedNftList();
    if(response.statusCode == 200){
      _recommendedNftList=[];
      _recommendedNftList.addAll(Nft.fromJson(response.body).nfts);
      _isLoaded=true;
      update();
    }else{
    }
  }
}