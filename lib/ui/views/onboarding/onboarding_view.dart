import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/auth_repository.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/data/storage_repository.dart';
import 'package:intheloopapp/domains/authentication_bloc/authentication_bloc.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/views/common/loading/loading_view.dart';
import 'package:intheloopapp/ui/views/onboarding/onboarding_cubit.dart';
import 'package:intheloopapp/ui/widgets/onboarding/control_buttons.dart';
import 'package:intheloopapp/ui/widgets/onboarding/onboarding_form.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthenticationBloc, AuthenticationState, Authenticated>(
      selector: (state) => state as Authenticated,
      builder: (context, state) {
        UserModel user = state.currentUser;

        return BlocProvider(
          create: (context) => OnboardingCubit(
            currentUser: user,
            onboardingBloc: context.read<OnboardingBloc>(),
            navigationBloc: context.read<NavigationBloc>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
            storageRepository: context.read<StorageRepository>(),
            databaseRepository: context.read<DatabaseRepository>(),
          )
            ..initUserData()
            ..initFollowRecommendations(),
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Center(child: Text('Onboarding')),
            ),
            floatingActionButton: ControlButtons(),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: OnboardingForm(),
              ),
            ),
          ),
        );
      },
    );
  }
}
