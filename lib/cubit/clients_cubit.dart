import 'package:hydrated_bloc/hydrated_bloc.dart';

class ClientsCubit extends HydratedCubit<List<int>> {
  ClientsCubit() : super([]);

  @override
  List<int>? fromJson(Map<String, dynamic> json) {
    return json['clients'];
  }

  @override
  Map<String, dynamic>? toJson(List<int> state) {
    return {'clients': state};
  }
}
