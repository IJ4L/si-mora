part of 'mahasiswa_cubit.dart';

abstract class MahasiswaState extends Equatable {
  const MahasiswaState();

  @override
  List<Object> get props => [];
}

class MahasiswaInitial extends MahasiswaState {}

class MahasiswaLoading extends MahasiswaState {}

class MahasiswaFailure extends MahasiswaState {
  final String message;
  const MahasiswaFailure(this.message);
}