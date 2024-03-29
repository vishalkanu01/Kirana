import 'package:kiranaapp/constants/route_names.dart';
import 'package:kiranaapp/locator.dart';
import 'package:kiranaapp/services/authentication_service.dart';
import 'package:kiranaapp/services/navigation_service.dart';
import 'package:kiranaapp/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
