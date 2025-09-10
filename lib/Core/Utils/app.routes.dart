import 'package:flutter/material.dart';
import '../../feature/Auth/view/auth_welcome_view.dart';
import '../../feature/splash/views/splash_view.dart';



Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashView.id:(context)=>SplashView(),
  AuthLoginView.id:(context)=>AuthLoginView(),
};
