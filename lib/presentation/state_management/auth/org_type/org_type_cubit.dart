import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/registration/org_type_entities.dart';
import 'package:rss/domain/usecases/org_types/get_org_types.dart';

part 'org_type_state.dart';

class OrgTypeCubit extends Cubit<OrgTypeState> {
  final GetOrgTypes? getOrgTypes;

  OrgTypeCubit({required this.getOrgTypes}) : super(Initial());

  void fetchOrgTypes() async {
    emit(OrgTypeLoading());
    final orgTypesEither = await getOrgTypes!(NoParams());
    emit(
      orgTypesEither.fold(
        (l) => OrgTypeError(l.appErrorType),
        (r) => OrgTypeLoaded(r),
      ),
    );
  }
}
