import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nftmarketplace/base/custom_loader.dart';
import 'package:nftmarketplace/base/show_custom_message.dart';
import 'package:nftmarketplace/controllers/auth_controller.dart';
import 'package:nftmarketplace/models/signup_body_model.dart';
import 'package:nftmarketplace/routes/route_helper.dart';
import 'package:nftmarketplace/utils/colors.dart';
import 'package:nftmarketplace/utils/dimensions.dart';
import 'package:nftmarketplace/widgets/app_text_field.dart';
import 'package:nftmarketplace/widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
    
      if(username.isEmpty){
        showCustomSnackBar("The email cannot be empty", title: "Email");
      } else if (!GetUtils.isEmail(username)) {
        showCustomSnackBar("This value is not a valid email", title: "Email");
      } else if (password.isEmpty){
        showCustomSnackBar("The password cannot be empty", title: "Password");
      } else if (password.length < 6){
        showCustomSnackBar("The password must be more than 6 digits", title: "Password");
      } else if (name.isEmpty){
        showCustomSnackBar("The name cannot be empty", title: "Name");
      } else if (phone.isEmpty){
        showCustomSnackBar("The phone cannot be empty", title: "Phone number");
      } else {
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          username: username,
          password: password
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
      
      nameController.clear();
      usernameController.clear();
      passwordController.clear();
      phoneController.clear();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:(_authController){
        return !_authController.isLoading?SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.screenHeight*0.05),
                    SizedBox(
                      height: Dimensions.screenHeight*0.25,
                      child: const Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                          backgroundImage: AssetImage(
                            "assets/image/NFTLogo1.png"
                          ),
                        ),
                      ),
                    ),
                    AppTextField(
                      textController: usernameController,
                      hintText: "Email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textController: passwordController,
                      hintText: "Password",
                      isObscure: true,
                      icon: Icons.password_sharp
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textController: nameController,
                      hintText: "Name",
                      icon: Icons.person
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textController: phoneController,
                      hintText: "Phone",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      formatter: [
                        MaskTextInputFormatter(
                          mask: '+## (##) #####-####', 
                          filter: { "#": RegExp(r'[0-9]') },
                          type: MaskAutoCompletionType.lazy
                        )
                      ],
                    ),
                    SizedBox(height: Dimensions.height20+Dimensions.height20),
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
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
                            text: "Sign Up",
                            size: Dimensions.font20+Dimensions.font20/2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height30),
                  ],
                ),
              ):
              const CustomLoader();
      }),
    );
  }
}