import 'package:kiranaapp/ui/shared/ui_helpers.dart';
import 'package:kiranaapp/ui/widgets/busy_button.dart';
import 'package:kiranaapp/ui/widgets/input_field.dart';
import 'package:kiranaapp/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:kiranaapp/viewmodels/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: ListView(
           // mainAxisSize: MainAxisSize.max,
                       // mainAxisAlignment: MainAxisAlignment.center,
                       // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              verticalSpaceLarge,
              InputField(
                placeholder: 'Full Name',
                controller: fullNameController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Email',
                controller: emailController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Phone No:',
                controller: phoneNumberController,
                additionalNote:
                    'Phone number has to be 10 digits with country code. Eg:+91-1234567890',
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Your Location',
                controller: locationController,
                additionalNote:
                    'Please specify your location so it will be easy to deliever your order. Eg:Naga Rd, beside Net8way solution, Raxaul',
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Password',
                password: true,
                controller: passwordController,
                additionalNote: 'Password has to be a minimum of 6 characters.',
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        fullName: fullNameController.text,
                        phoneNumber: phoneNumberController.text,
                        location: locationController.text,
                      );
                    },
                  )
                ],
              ),
              verticalSpaceMedium,

              TextLink(
                'Already a user ? Click here',
                onPressed: () {
                  model.navigateToLogin();
                },
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}
