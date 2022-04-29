import 'package:flutter/material.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/widgets/big_text.dart';
import 'package:nftmarketplace/widgets/small_text.dart';

import '../../utils/dimensions.dart';
import 'nft_page_body.dart';





class MainNFTPage extends StatefulWidget {
  const MainNFTPage({Key? key}) : super(key: key);

  @override
  _MainNFTPageState createState() => _MainNFTPageState();
}

class _MainNFTPageState extends State<MainNFTPage> {
  @override
  Widget build(BuildContext context) {
    print("this current height is " + MediaQuery.of(context).size.height.toString());
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          //showing the header
          Container(
            margin: EdgeInsets.only(top:Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Column(
                      children: [
                        BigText(text: "Marketplace", color: AppColors.mainColor),
                        Row(
                          children: [
                            SmallText(text: "Brazil", color: Colors.black54,),
                            Icon(Icons.arrow_drop_down_rounded)

                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search, color: Colors.white, size:Dimensions.iconSize24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ]
              )
          ),
          //showing the body
          Expanded(child: SingleChildScrollView(
            child: NftPageBody(),
          )),
        ],
      ),
    );
  }
}
