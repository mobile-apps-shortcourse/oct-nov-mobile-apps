import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reach/repository/user.repository.dart';
import 'package:reach/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final BaseUserRepository repository;

  UserCubit({required this.repository}) : super(UserInitial());

  Future<void> currentUser() async {
    emit(UserLoading());
    var state = repository.currentUser().map((user) => user == null
        ? UserError(reason: 'User not found')
        : UserSuccess<UserAccount>(data: user));
    state.listen((event) => emit(event));
  }

  Future<void> updateUser({
    String? avatar,
    int? createdOn,
    String? email,
    String? id,
    int? lastLoginDate,
    UserType? userType,
    String? username,
  }) async {
    emit(UserLoading());

    // get the first result from the stream
    var account = await repository.currentUser().first;
    if (account != null) {
      print(account);
      account = account.copyWith(
        avatar: avatar,
        createdOn: createdOn,
        email: email,
        id: id,
        lastLoginDate: lastLoginDate,
        userType: userType,
        username: username,
      );
      await repository.updateUser(account: account);
      emit(UserSuccess(data: null));
    } else {
      emit(UserError(reason: 'User not found'));
    }
  }
}
