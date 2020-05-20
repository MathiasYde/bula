//Class that handles sign in authentication and all that platform spefific stuff
import 'dart:async';

class Authentication {
  Future<bool> authenticate() async {
    await Future.delayed(Duration(seconds: 1));
    return true;
  }
}
