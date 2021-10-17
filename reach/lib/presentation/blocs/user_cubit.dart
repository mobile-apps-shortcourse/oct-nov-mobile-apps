import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reach/data/repositories/auth.dart';

part 'user_state.dart';

/// todo -> build user cubit on user repository
class UserCubit extends Cubit<UserState> {
  final BaseAuthRepository repository;

  UserCubit({required this.repository}) : super(UserInitial());
}
