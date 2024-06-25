import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/utils.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(const EmailState(email: '', isEmailValid: false)) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailSubmitted>(_onEmailSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<EmailState> emit) {
    final email = event.email;
    final isEmailValid = emailRegExp.hasMatch(email);
    emit(EmailState(email: email, isEmailValid: isEmailValid));
  }

  void _onEmailSubmitted(EmailSubmitted event, Emitter<EmailState> emit) {
    emit(const EmailState(email: '', isEmailValid: false));
  }
}
