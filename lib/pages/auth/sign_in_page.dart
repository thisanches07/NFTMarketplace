import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nftmarketplace/base/custom_loader.dart';
import 'package:nftmarketplace/base/show_custom_message.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/pages/auth/sign_up_page.dart';
import 'package:nftmarketplace/routes/route_helper.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/utils/dimensions.dart';
import 'package:nftmarketplace/widgets/app_text_field.dart';
import 'package:nftmarketplace/widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context){
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();

    void _signIn(AuthController authController){
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
    
      if(username.isEmpty){
        showCustomSnackBar("The email cannot be empty", title: "Email");
      } else if (!GetUtils.isEmail(username)) {
        showCustomSnackBar("This value is not a valid email", title: "Email");
      } else if (password.isEmpty){
        showCustomSnackBar("The password cannot be empty", title: "Password");
      } else if (password.length < 6){
        showCustomSnackBar("The password must be more than 6 digits", title: "Password");
      } else {
        authController.signIn(username, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
      
      usernameController.clear();
      passwordController.clear();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05),
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                      "assets/image/NFTLogo1.png"
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                textController: usernameController,
                hintText: "Email",
                icon: Icons.email
              ),
              SizedBox(height: Dimensions.height20),
              AppTextField(
                textController: passwordController,
                hintText: "Password",
                isObscure: true,
                icon: Icons.password_sharp
              ),
              SizedBox(height: Dimensions.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.screenWidth*0.05)
                ],
              ),
              SizedBox(height: Dimensions.height20+Dimensions.height20),
              GestureDetector(
                onTap: (){
                  _signIn(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor
                  ),
                  child: Center (
                    child: BigText(
                      text: "Sign In",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              RichText(
                text: TextSpan(
                  text: "Don\'t have am account? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.w500
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(() => SignUpPage(), transition: Transition.fade),
                      text: "Create",
                      style: TextStyle(
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ]
                ),
              ),
              SizedBox(height: Dimensions.height30),
            ],
          ),
        ):CustomLoader();
      })
    );
  }
}