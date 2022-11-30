part of 'socialapp_cubit.dart';

abstract class SocialappState {}

class SocialappInitial extends SocialappState {}

class ShowUser extends SocialappState {}

class Socialapplikedbutton extends SocialappState {}

class SocialappGetUserLoading extends SocialappState {}

class SocialappGetUserScsues extends SocialappState {}

class SocialappGetLikesLoading extends SocialappState {}

class SocialTest extends SocialappState {}

class SocialappGetLikesScsues extends SocialappState {}

class HideCommentLoading extends SocialappState {}

class HideCommentDone extends SocialappState {}

class HideCommentError extends SocialappState {}

class SocialappGetUserError extends SocialappState {
  final String error;

  SocialappGetUserError(this.error);
}

class EditCommentLoading extends SocialappState {}

class EditCommentDone extends SocialappState {}

class EditCommentError extends SocialappState {}

class SocialappGetPostsLoading extends SocialappState {}

class SocialappGetPostsScsues extends SocialappState {}

class SocialappGetcomment extends SocialappState {}

class SocialappGetPostsError extends SocialappState {
  final String error;

  SocialappGetPostsError(this.error);
}

class SocialappSendEmailLoading extends SocialappState {}

class SocialappSendEmailscsufly extends SocialappState {}

class SocialappSendEmailerror extends SocialappState {}

class SocialChangeBootmSheet extends SocialappState {}

class Socialappimageprofilepickerdone extends SocialappState {}

class Socialappimageprofilepickererror extends SocialappState {}

class PickPostImageDone extends SocialappState {}

class PickPostImageError extends SocialappState {}

class Socialappimagecoverepickerdone extends SocialappState {}

class Socialappimagecoverepickererror extends SocialappState {}

class Socialappimagepostepickerdone extends SocialappState {}

class Socialappimagepostepickererror extends SocialappState {}

class Socialcameraimagepostepickerdone extends SocialappState {}

class Socialcameraimagepostepickererror extends SocialappState {}

class Socialcameraimagecommentepickerdone extends SocialappState {}

class Socialcameraimagecommentepickererror extends SocialappState {}

class StoryPickImageDone extends SocialappState {}

class StoryPickImageError extends SocialappState {}

class SocialCubitUploadUserLoading extends SocialappState {}

class SocialCubitUploadUserError extends SocialappState {}

class SocialCubitUploadUserScuflly extends SocialappState {}

class SocialCubitUploadProfileimageScsufly extends SocialappState {}

class SocialCubitUploadProfileimageError extends SocialappState {}

class SocialCubitUploadCoverimageScsufly extends SocialappState {}

class SocialCubitUploadCoverimageError extends SocialappState {}

class SocialCeratPostLoding extends SocialappState {}

class SocialCeratPostScsfully extends SocialappState {}

class SocialCeratPostError extends SocialappState {}

class SocialClearpostimage extends SocialappState {}

class ClearPostUpdatePhoto extends SocialappState {}

class SocialClearcommentimage extends SocialappState {}

class SocialPostLikesScsuflly extends SocialappState {}

class SocialPostLikesError extends SocialappState {}

class Socialsendcommentliksload extends SocialappState {}

class Socialsendcommentliksdone extends SocialappState {}

class Socialsendcommentlikserror extends SocialappState {}

class Socialsendcommentliksdone1 extends SocialappState {}

class SocialappGetComentScsues extends SocialappState {}

class SocialappGetComentLoading extends SocialappState {}

class SocialappGetComentDeletScsues extends SocialappState {}

class SocialappGetComentEeletLoading extends SocialappState {}

class SocialappGetComentError extends SocialappState {}

class SocialCeratCommentLoding extends SocialappState {}

class SocialCeratCommentScsfully extends SocialappState {}

class SocialCeratCommentError extends SocialappState {}

class Socialappcommentloading extends SocialappState {}

class Socialappcommentdone extends SocialappState {}

class Socialappcommenterror extends SocialappState {}

class DeletPostLoading extends SocialappState {}

class DeletPostDone extends SocialappState {}

class DeletPostError extends SocialappState {}
class SaveImageToGallerySuccessfully extends SocialappState {}

class SaveImageToGalleryError extends SocialappState {}

class HidePostLoadnig extends SocialappState {}

class HidePostDone extends SocialappState {}

class HidePostError extends SocialappState {}

class DeletCommentDone extends SocialappState {}

class DeletCommentError extends SocialappState {}

class SearchLoading extends SocialappState {}

class SearchDone extends SocialappState {}

class Searcherror extends SocialappState {}

class ChangeUser extends SocialappState {}

class Cearcherror extends SocialappState {}

class AddFriendCompelet extends SocialappState {}

class AddFriendLoading extends SocialappState {}

class AddFriendError extends SocialappState {}

class AddFriendCompelet2 extends SocialappState {}

class SocialappGetNotiLoading extends SocialappState {}

class SocialappGetNotiScsues extends SocialappState {}

class SocialappGetNotiError extends SocialappState {}

class DeletFristNotificationsLoading extends SocialappState {}

class DeletFristNotificationsError extends SocialappState {}

class DeletFristNotificationsDone extends SocialappState {}

class AcceptFriendLoading extends SocialappState {}

class AcceptFriendDone extends SocialappState {}

class AcceptFriendError extends SocialappState {}

class DeletFriendLoading extends SocialappState {}

class DeletFriendDone extends SocialappState {}

class DeletFriendError extends SocialappState {}

class DeletFristNotifications2Loading extends SocialappState {}

class DeletFristNotifications2Error extends SocialappState {}

class DeletFristNotifications2Done extends SocialappState {}

class AcceptFriendLoading2 extends SocialappState {}

class AcceptFriendDone2 extends SocialappState {}

class AcceptFriendError2 extends SocialappState {}

class DeletFriendLoading2 extends SocialappState {}

class DeletFriendDone2 extends SocialappState {}

class DeletFriendError2 extends SocialappState {}

class GetUserTokenLoading extends SocialappState {}

class UpdateTokenDone extends SocialappState {}

class UpdateTokenError extends SocialappState {}

class GetUserTokenDone extends SocialappState {}

class GetUserTokenError extends SocialappState {}

class CncelFriendDone extends SocialappState {}

class CncelFriendError extends SocialappState {}

class SendFcmError extends SocialappState {}

class UploadStoryImageLoading extends SocialappState {}

class UploadStoryImageDone extends SocialappState {}

class DeletStoryImage extends SocialappState {}

class UploadStoryImageError extends SocialappState {}

class UploadStoryLoading extends SocialappState {}

class UploadStoryDone extends SocialappState {}

class UploadStoryError extends SocialappState {}

class GetStoryLoading extends SocialappState {}

class GetStoryDone extends SocialappState {}

class GetStoryError extends SocialappState {}

class IsTextShow extends SocialappState {}

class UpDateAppbar extends SocialappState {}

class UpdateUserImageAllDone extends SocialappState {}

class UpdateUserImageAllError extends SocialappState {}

class UpdateUserNameAllDone extends SocialappState {}

class UpdateUserNameAllError extends SocialappState {}

class UpdateUserStoryImageAllDone extends SocialappState {}

class UpdateUserStoryImageAllError extends SocialappState {}

class EditPostLoading extends SocialappState {}

class EditPostDone extends SocialappState {}

class EditPostError extends SocialappState {}

class OnChangeState extends SocialappState {}

class EditPostImageError extends SocialappState {}

class ChangeDarkmood extends SocialappState {}

class DeletAccountLoading extends SocialappState {}

class DeletAccountDone extends SocialappState {}

class DeletAccountError extends SocialappState {}

class EditPubilcRulesLoading extends SocialappState {}

class EditPubilcRulesDone extends SocialappState {}

class EditPubilcRulesError extends SocialappState {}
