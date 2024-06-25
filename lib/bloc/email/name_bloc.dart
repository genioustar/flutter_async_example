import 'package:flutter_bloc/flutter_bloc.dart';

part 'name_event.dart';
part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc() : super(NameState(name: '', isNameValid: false)) {
    on<NameChanged>(_onNameChanged);
    on<NameSubmitted>(_onNameSubmitted);
  }

  void _onNameChanged(NameChanged event, Emitter<NameState> emit) {
    final name = event.name;
    final isNameValid = name.length > 2 ? true : false;
    emit(NameState(name: name, isNameValid: isNameValid));
  }

  void _onNameSubmitted(NameSubmitted event, Emitter<NameState> emit) {
    emit(NameState(name: '', isNameValid: false));
  }
}
