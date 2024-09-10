import 'package:alert_brains/Constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global_presentation/basic_text_form.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController emailController = TextEditingController();
  


    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.whiteGreen),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 30.sp,
                  color: AppColors.green,
                )),
          ),
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteGrey),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: "currentUserPhoto.toString()",
                        width: 130.w,
                        height: 110.h,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/prof.jpg"),
                        fit: BoxFit.fill),
                  ),
                  Positioned(
                    bottom: -3,
                    right: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5.w)),
                      child: CircleAvatar(
                        backgroundColor: AppColors.green,
                        radius: 15.w,
                        child: Icon(
                          Icons.edit,
                          size: 20.sp,
                          color: AppColors.whiteGreen,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableTextField(
                    width: 300.w,
                    hintText: 'name',
                    controller: nameController,
                    borderRadius: BorderRadius.circular(15), labelText: 'Name',
                  ),
                ],
              ),
              ReusableTextField(
                width: 300.w,
                hintText: 'Gmail',
                controller: emailController,
                borderRadius: BorderRadius.circular(15), labelText: 'Email',
              ),
              ReusableTextField(
                width: 300.w,
                hintText: 'Age',
                borderColor: Colors.black,
                controller: ageController,
                borderRadius: BorderRadius.circular(15), labelText: 'Age',
              ),
              ReusableTextField(
                width: 300.w,
                hintText: 'Country',
                controller: countryController,
                borderRadius: BorderRadius.circular(15), labelText: 'Country',
              ),
            ],
          ),
        ));
  }
}
