import 'package:get/get.dart';

import '../modules/admin_login/bindings/admin_login_binding.dart';
import '../modules/admin_login/views/admin_login_view.dart';
import '../modules/chat_room/bindings/chat_room_binding.dart';
import '../modules/chat_room/views/chat_room_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/user_information/bindings/user_information_binding.dart';
import '../modules/user_information/views/user_information_view.dart';
import '../modules/weddingimage/bindings/weddingimage_binding.dart';
import '../modules/weddingimage/views/weddingimage_view.dart';
import '../modules/weddinginfor/bindings/weddinginfor_binding.dart';
import '../modules/weddinginfor/views/weddinginfor_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WEDDINGINFOR;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LOGIN,
      page: () => const AdminLoginView(),
      binding: AdminLoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ROOM,
      page: () => const ChatRoomView(),
      binding: ChatRoomBinding(),
    ),
    GetPage(
      name: _Paths.USER_INFORMATION,
      page: () => const UserInformationView(),
      binding: UserInformationBinding(),
    ),
    GetPage(
      name: _Paths.WEDDINGINFOR,
      page: () => const WeddinginforView(),
      binding: WeddinginforBinding(),
    ),
    GetPage(
      name: _Paths.WEDDINGIMAGE,
      page: () => const WeddingimageView(),
      binding: WeddingimageBinding(),
    ),
  ];
}
