import 'package:kiranaapp/constants/route_names.dart';
import 'package:kiranaapp/locator.dart';
import 'package:kiranaapp/services/authentication_service.dart';
import 'package:kiranaapp/services/dialog_service.dart';
import 'package:kiranaapp/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
    @required String phoneNumber,
    @required String location,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
      location: location,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
  void navigateToLogin() {
    _navigationService.navigateTo(LoginViewRoute);
  }
}
