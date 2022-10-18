import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/auth_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/splash_screen.dart';

class AuthChecker extends StatelessWidget {
  final Widget screen;

  AuthChecker(this.screen);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) {
        return auth.isAuth
            ? screen
            : FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (ctx, authResultSnapshot) => (auth.isAuth &&
                        authResultSnapshot.connectionState ==
                            ConnectionState.waiting)
                    ? SplashScreen()
                    : AuthScreen(),
              );
      },
    );
  }
}
