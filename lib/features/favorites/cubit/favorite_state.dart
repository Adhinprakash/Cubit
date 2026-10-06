// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum Favstatus { inital, loading, loaded, error }

class FavoriteState extends Equatable {
  final Favstatus status;

  final Set<String> favList;
  final String errormessage;

  FavoriteState({
    this.status = Favstatus.inital,
    this.favList = const {},
    this.errormessage = '',
  });

  FavoriteState copyWith({
    Favstatus? status,

    Set<String>? favList,
    String? errormessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      favList: favList ?? this.favList,
      errormessage: errormessage ?? this.errormessage,
    );
  }

  Set<String> get favIdsList => favList;

  @override
  // TODO: implement props
  List<Object?> get props => [status, favList, errormessage];
}
