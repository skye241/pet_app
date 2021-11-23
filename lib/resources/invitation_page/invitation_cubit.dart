import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationCubit() : super(InvitationInitial());

  Future<void> initEvent () async {

  }
}
