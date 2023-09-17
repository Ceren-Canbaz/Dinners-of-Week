import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/repository/user_repositroy.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepositroy userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      //shared preference ile girisini saglaman gerek tatlim.
    });
    on<SignInEvent>(
      (event, emit) async {
        emit(AuthInitial());
      },
    );
    on<SignUpEvent>((event, emit) {
      try {
        print("sign up bloc");
        userRepository.signUp(event.auth);
      } catch (e) {
        print("errorrr signup");
      }
    });
    on<SignUpInitialEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}
