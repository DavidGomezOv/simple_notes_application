// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:simple_notes_application/src/auth/api/datasource/auth_firestore_source.dart'
    as _i4;
import 'package:simple_notes_application/src/auth/api/repository/auth_repository.dart'
    as _i5;
import 'package:simple_notes_application/src/auth/services/auth_service.dart'
    as _i6;
import 'package:simple_notes_application/src/core/di/helper_module.dart'
    as _i19;
import 'package:simple_notes_application/src/core/utils/app_navigator.dart'
    as _i3;
import 'package:simple_notes_application/src/home/api/datasource/home_firestore_source.dart'
    as _i8;
import 'package:simple_notes_application/src/home/api/datasource/home_local_source.dart'
    as _i9;
import 'package:simple_notes_application/src/home/api/repository/home_repository.dart'
    as _i10;
import 'package:simple_notes_application/src/home/services/home_service.dart'
    as _i11;
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_firestore_source.dart'
    as _i12;
import 'package:simple_notes_application/src/note_detail/api/datasource/note_detail_local_source.dart'
    as _i13;
import 'package:simple_notes_application/src/note_detail/api/respository/note_detail_repository.dart'
    as _i14;
import 'package:simple_notes_application/src/note_detail/services/note_detail_service.dart'
    as _i15;
import 'package:simple_notes_application/src/note_images_detail/api/datasource/note_images_detail_firestore_source.dart'
    as _i16;
import 'package:simple_notes_application/src/note_images_detail/api/repository/note_images_detail_repository.dart'
    as _i17;
import 'package:simple_notes_application/src/note_images_detail/services/note_images_detail_service.dart'
    as _i18;
import 'package:stacked_services/stacked_services.dart' as _i7;

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
    gh.lazySingleton<_i4.AuthFirestoreSource>(
        () => _i4.AuthFirestoreSource.from());
    gh.factory<_i5.AuthRepository>(
        () => _i5.AuthRepository.from(gh<_i4.AuthFirestoreSource>()));
    gh.lazySingleton<_i6.AuthService>(
        () => _i6.AuthService.from(gh<_i5.AuthRepository>()));
    gh.lazySingleton<_i7.BottomSheetService>(
        () => helperModule.bottomSheetService);
    gh.lazySingleton<_i8.HomeFirestoreSource>(
        () => _i8.HomeFirestoreSource.from());
    gh.lazySingleton<_i9.HomeLocalSource>(() => _i9.HomeLocalSource.from());
    gh.factory<_i10.HomeRepository>(() => _i10.HomeRepository.from(
          gh<_i8.HomeFirestoreSource>(),
          gh<_i9.HomeLocalSource>(),
        ));
    gh.lazySingleton<_i11.HomeService>(
        () => _i11.HomeService.from(gh<_i10.HomeRepository>()));
    gh.lazySingleton<_i12.NoteDetailFirestoreSource>(
        () => _i12.NoteDetailFirestoreSource.from());
    gh.lazySingleton<_i13.NoteDetailLocalSource>(
        () => _i13.NoteDetailLocalSource.from());
    gh.factory<_i14.NoteDetailRepository>(() => _i14.NoteDetailRepository.from(
          gh<_i12.NoteDetailFirestoreSource>(),
          gh<_i13.NoteDetailLocalSource>(),
        ));
    gh.lazySingleton<_i15.NoteDetailService>(
        () => _i15.NoteDetailService.from(gh<_i14.NoteDetailRepository>()));
    gh.lazySingleton<_i16.NoteImagesDetailFirestoreSource>(
        () => _i16.NoteImagesDetailFirestoreSource.from());
    gh.factory<_i17.NoteImagesDetailRepository>(() =>
        _i17.NoteImagesDetailRepository.from(
            gh<_i16.NoteImagesDetailFirestoreSource>()));
    gh.lazySingleton<_i18.NoteImagesDetailService>(() =>
        _i18.NoteImagesDetailService.from(
            gh<_i17.NoteImagesDetailRepository>()));
    return this;
  }
}

class _$HelperModule extends _i19.HelperModule {
  @override
  _i7.BottomSheetService get bottomSheetService => _i7.BottomSheetService();
  @override
  _i3.AppNavigator get appNavigator => _i3.AppNavigator();
}
