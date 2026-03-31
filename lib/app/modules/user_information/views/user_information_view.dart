import 'dart:typed_data';
import 'package:codedevweb/app/common/widgets/comui/custom_text_form.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_information_controller.dart';
import '../views/components/user_information_constant.dart';

class UserInformationView extends GetView<UserInformationController> {
  const UserInformationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(UserInformationController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserInformationView'),
          centerTitle: true,
        ),
        body: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Form(
                    key: _formKey,
                    child: Obx(
                      () => controller.isLoading
                          ? Text("Loading")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    child: GestureDetector(
                                        onTap: controller.onTapPickImage,
                                        child: Obx(() => getUserAvatar(
                                            controller,
                                            controller.isChooseImage)))),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                                CustomTextForm(
                                  label: "name",
                                  initialValue: controller.userInfor.name ?? "",
                                  onSaved: (val) =>
                                      controller.onFormChange("name", val),
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    border:
                                        UserInformationConstant.ProfileBoder,
                                  ),
                                ),
                                CustomTextForm(
                                  label: "Date of birth",
                                  onSaved: (val) => controller.onFormChange(
                                      "dateOfBirth", val),
                                  decoration: InputDecoration(
                                    hintText: 'DD/MM/YYYY',
                                    border:
                                        UserInformationConstant.ProfileBoder,
                                  ),
                                ),
                                CustomTextForm(
                                  label: "Phone number",
                                  initialValue:
                                      controller.userInfor.phone ?? "",
                                  onSaved: (val) =>
                                      controller.onFormChange("phone", val),
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    border:
                                        UserInformationConstant.ProfileBoder,
                                  ),
                                ),
                                CustomTextForm(
                                  label: "Email",
                                  onSaved: (val) =>
                                      controller.onFormChange("email", val),
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    border:
                                        UserInformationConstant.ProfileBoder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 1900,
                                  height: 50,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      // ignore: deprecated_member_use
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                        // ignore: deprecated_member_use
                                        (Set<MaterialState> states) {
                                          // ignore: deprecated_member_use
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return UserInformationConstant
                                                .Profilebtselection;
                                          }
                                          return UserInformationConstant
                                              .Profilebtunselection;
                                        },
                                      ),
                                    ),
                                    child: Text("Save"),
                                    onPressed: () =>
                                        controller.onSaveInfor(_formKey),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text("Chua lam xong"),
                )
              ],
            )));
  }

  Widget getUserAvatar(
      UserInformationController controller, bool isChooseImage) {
    var imageUrl = controller.userInfor.avatarUrl;
    var imageMemo = controller.userAvatar;
    ImageProvider currentImage =
        isChooseImage ? MemoryImage(imageMemo) : NetworkImage(imageUrl ?? "");

    return Container(
        margin: EdgeInsets.only(right: 20),
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: currentImage,
          ),
        ));
  }
}
