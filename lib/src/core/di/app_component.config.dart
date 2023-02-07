// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:simple_notes_application/src/core/di/helper_module.dart'
    as _i14;
import 'package:simple_notes_application/src/core/utils/app_navigator.dart'
    as _i3;
import 'package:simple_notes_application/src/home/api/datasource/home_firestore_source.dart'
    as _i5;
import 'package:simple_notes_application/src/home/api/datasource/home_local_source.dart'
    as _i6;
import 'package:simple_notes_application/src/home/api/repository/home_repository.dart'
    as _i7;
import 'package:simple_notes_application/src/home/services/home_service.dart'
    as _i8;
import 'package:simple_notes_application/src/login/services/login_service.dart'
    as _i9;
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_firestore_source.dart'
    as _i10;
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_local_source.dart'
    as _i11;
import 'package:simple_notes_application/src/note_detail/api/respository/note_detail_repository.dart'
    as _i12;
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart'
    as _i13;
import 'package:stacked_services/stacked_services.dart' as _i4;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt $appInitGetIt({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final helperModule = _$HelperModule();
    gh.lazySingleton<_i3.AppNavigator>(() => helperModule.appNavigator);
    gh.lazySingleton<_i4.BottomSheetService>(
        () => helperModule.bottomSheetService);
    gh.lazySingleton<_i5.HomeFirestoreSource>(
        () => _i5.HomeFirestoreSource.from());
    gh.lazySingleton<_i6.HomeLocalSource>(() => _i6.HomeLocalSource.from());
    gh.factory<_i7.HomeRepository>(() => _i7.HomeRepository.from(
          gh<_i5.HomeFirestoreSource>(),
          gh<_i6.HomeLocalSource>(),
        ));
    gh.lazySingleton<_i8.HomeService>(
        () => _i8.HomeService.from(gh<_i7.HomeRepository>()));
    gh.lazySingleton<_i9.LoginService>(() => _i9.LoginService.from());
    gh.lazySingleton<_i10.NoteDetailFirestoreSource>(
        () => _i10.NoteDetailFirestoreSource.from());
    gh.lazySingleton<_i11.NoteDetailLocalSource>(
        () => _i11.NoteDetailLocalSource.from());
    gh.factory<_i12.NoteDetailRepository>(() => _i12.NoteDetailRepository.from(
          gh<_i10.NoteDetailFirestoreSource>(),
          gh<_i11.NoteDetailLocalSource>(),
        ));
    gh.lazySingleton<_i13.NoteDetailService>(
        () => _i13.NoteDetailService.from(gh<_i12.NoteDetailRepository>()));
    return this;
  }
}

class _$HelperModule extends _i14.HelperModule {
  @override
  _i4.BottomSheetService get bottomSheetService => _i4.BottomSheetService();
  @override
  _i3.AppNavigator get appNavigator => _i3.AppNavigator();
}
