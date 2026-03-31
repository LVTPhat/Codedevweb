import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_login_controller.dart';

class AdminLoginView extends GetView<AdminLoginController> {
  const AdminLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(AdminLoginController());
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Login View'),
          centerTitle: true,
        ),
        body: Center(
            child: Form(
                key: _formKey,
                child: SizedBox(
                  width: 300,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                          validator: controller.validateEmail,
                          onSaved: controller.onSaveEmail,
                          initialValue: "NhuY@Admin.com",
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          )),
                      Obx(() => TextFormField(
                          onSaved: controller.onSavePassWord,
                          obscureText: !controller.showPass,
                          initialValue: "",
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: controller.onTapShowPass,
                                child: !controller.showPass
                                    ? Icon(Icons.remove_red_eye_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                              )))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: controller.moveToForgorPass,
                            child: Text(
                              "Forgot password",
                              style: TextStyle(
                                color: Colors.blue[400],
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue[400],
                              ),
                            ),
                          ),
                          OutlinedButton(
                            child: Text("Login"),
                            onPressed: () => controller.adminLogin(_formKey),
                          )
                        ],
                      ),
                    ],
                  ),
                ))),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: controller.moveToChatRoom, // イベント処理
        //   child: Icon(Icons.chat),
        // )
        floatingActionButton: buildMessView());
  }

  Widget buildMessView() {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return SizedBox(
      width: 500,
      height: 100,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawerScrimColor: Colors.transparent,
        key: _scaffoldKey,
        endDrawer: buildMessIconViewList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scaffoldKey.currentState!.openEndDrawer();
            //controller.moveToChatRoom();
          }, // イベント処理
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildMessIconViewList() {
    var testData = ["test1", "test2", "test3", "test4", "test5"];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 80),
      child: Drawer(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: testData.map<Widget>((e) => ChatShotcutIcon()).toList(),
        ),
      ),
    );
  }
}

class ChatShotcutIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 20),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          // image: DecorationImage(
          //   fit: BoxFit.fill,
          //   image: NetworkImage(controller.avartar),
          // ),
        ));
  }
}
