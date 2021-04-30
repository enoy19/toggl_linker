import 'package:hydrated_bloc/hydrated_bloc.dart';

class CurrentWorkspaceCubit extends HydratedCubit<int?> {
  CurrentWorkspaceCubit() : super(null);

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['currentWorkspace'];
  }

  @override
  Map<String, dynamic>? toJson(int? state) {
    return {'currentWorkspace': state};
  }
}
