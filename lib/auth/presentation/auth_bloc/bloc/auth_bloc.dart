import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/auth/data/models/team_user.dart';
import 'package:dinners_of_week/auth/domain/user_repositroy.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepositroy userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {});
    on<SignInEvent>(
      (event, emit) async {
        try {
          final status = await userRepository.signIn(event.user);
          if (status) {
            emit(
              SignInState(user: event.user),
            );
          }
        } on AuthStateException catch (e) {
          emit(
            AuthErrorState(
              error: e.message,
            ),
          );
        } on Exception catch (e) {
          emit(const AuthErrorState(error: "e"));
        }
      },
    );
    on<SignUpEvent>((event, emit) async {
      try {
        final user = await userRepository.signUp(event.user);
        emit(SignInState(user: user));
      } on PostgrestException catch (e) {
        emit(AuthErrorState(error: e.message));
      } on Exception catch (e) {
        emit(const AuthErrorState(error: "Something went wrong"));
      }
    });
    on<SignUpInitialEvent>((event, emit) {
      emit(AuthInitial());
    });
  }
}
