import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    required this.email,
    this.name,
    this.photo,
    this.provider,
  });

  final String uid;
  final String? email;
  final String? name;
  final String? photo;
  final String? provider;

  static const empty = User(uid: '', email: '');
  bool get isEmpty => this == User.empty;
  @override
  List<Object?> get props => [uid, email, name, photo, provider];
}
