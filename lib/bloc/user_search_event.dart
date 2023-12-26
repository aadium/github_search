import 'package:equatable/equatable.dart';

abstract class UserSearchEvent extends Equatable {
  const UserSearchEvent();
}

class SearchUser extends UserSearchEvent {
  final String query;

  SearchUser(this.query);

  @override
  List<Object?> get props => [query];
}
