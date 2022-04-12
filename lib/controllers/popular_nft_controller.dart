import 'package:get/get.dart';
import 'package:nftmarketplace/data/repository/popular_nft_repo.dart';

import '../models/nfts_model.dart';

class PopularNftController extends GetxController{
  final PopularNftRepo popularNftRepo;
  PopularNftController({required this.popularNftRepo});
  List<dynamic> _popularNftList=[];
  List<dynamic> get popularNftList => _popularNftList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularNftList() async{
    Response response = await popularNftRepo.getPopularNftList();
    if(response.statusCode == 200){
      print("got nfts");
      _popularNftList=[];
      _popularNftList.addAll(Nft.fromJson(response.body).nfts);
      _isLoaded=true;
      update();
    }else{
      print("nothing");
    }
  }
}