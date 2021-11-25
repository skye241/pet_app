part of 'welcome_cubit.dart';

@immutable
abstract class WelcomeState {}

class WelcomeInitial extends WelcomeState {}
class WelcomeSuccess extends WelcomeState {
  WelcomeSuccess(this.routeName);

  final String routeName;
}
