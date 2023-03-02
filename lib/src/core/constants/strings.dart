import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppStrings {
  static final AppStrings _appStrings = AppStrings._();

  factory AppStrings() {
    return _appStrings;
  }

  AppStrings._();

  late BuildContext _context;

  setContext(BuildContext context) => _context = context;

  String get emailHint => AppLocalizations.of(_context)!.emailHint;

  String get passwordHint => AppLocalizations.of(_context)!.passwordHint;

  String get nameHint => AppLocalizations.of(_context)!.nameHint;

  String get loginButtonLabel =>
      AppLocalizations.of(_context)!.loginButtonLabel;

  String get registerButtonLabel =>
      AppLocalizations.of(_context)!.registerButtonLabel;

  String get loginTabLabel => AppLocalizations.of(_context)!.loginTabLabel;

  String get registerTabLabel =>
      AppLocalizations.of(_context)!.registerTabLabel;

  String get welcomeLabel => AppLocalizations.of(_context)!.welcomeLabel;

  String get registerInvitationLabel =>
      AppLocalizations.of(_context)!.registerInvitationLabel;

  String get noInternetMessage =>
      AppLocalizations.of(_context)!.noInternetMessage;

  String get acceptLabel => AppLocalizations.of(_context)!.acceptLabel;

  String get cancelLabel => AppLocalizations.of(_context)!.cancelLabel;

  String get searchNotesLabel =>
      AppLocalizations.of(_context)!.searchNotesLabel;

  String get noNotesLabel => AppLocalizations.of(_context)!.noNotesLabel;

  String get noteTitleLabel => AppLocalizations.of(_context)!.noteTitleLabel;

  String get noteLabel => AppLocalizations.of(_context)!.noteLabel;

  String get saveLabel => AppLocalizations.of(_context)!.saveLabel;

  String get editLabel => AppLocalizations.of(_context)!.editLabel;

  String get selectImagesTitle =>
      AppLocalizations.of(_context)!.selectImagesTitle;

  String get selectImagesMessages =>
      AppLocalizations.of(_context)!.selectImagesMessages;

  String get galleryLabel => AppLocalizations.of(_context)!.galleryLabel;

  String get cameraLabel => AppLocalizations.of(_context)!.cameraLabel;

  String get informationLabel =>
      AppLocalizations.of(_context)!.informationLabel;

  String get providePermissionMessage =>
      AppLocalizations.of(_context)!.providePermissionMessage;

  String get deleteNoteMessage =>
      AppLocalizations.of(_context)!.deleteNoteMessage;

  String get enterAllInformationMessage =>
      AppLocalizations.of(_context)!.enterAllInformationMessage;

  String get authenticateSuccessfullyMessage =>
      AppLocalizations.of(_context)!.authenticateSuccessfullyMessage;

  String get singOutConfirmationMessage =>
      AppLocalizations.of(_context)!.singOutConfirmationMessage;

  String get downloadImagesOptionMessages =>
      AppLocalizations.of(_context)!.downloadImagesOptionMessages;

  String get downloadImageConfirmation =>
      AppLocalizations.of(_context)!.downloadImageConfirmation;

  String get downloadThisImage =>
      AppLocalizations.of(_context)!.downloadThisImage;

  String get downloadAllImages =>
      AppLocalizations.of(_context)!.downloadAllImages;

  String get noteDetailImageTitle =>
      AppLocalizations.of(_context)!.noteDetailImageTitle;
}
