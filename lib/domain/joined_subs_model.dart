class JoinedSubsModel{

  String subsId;
  String title;
  String language;
  String description;
  String photo;
  String amount;
  String LangImg;
  String LangDesc;
  List videos;

  String sub_id;
  String sub_title;
  String sub_lang;
  String sub_photo;
  String booking_amount;
  String booking_id;
  String date;
  String expiry;
  String guide_id;
  String status;
  String user_id;

  JoinedSubsModel({
    required this.subsId,
    required this.title,
    required this.language,
    required this.description,
    required this.photo,
    required this.amount,
    required this.LangImg,
    required this.LangDesc,
    required this.videos,

    required this.sub_id,
    required this.sub_title,
    required this.sub_lang,
    required this.sub_photo,
    required this.booking_amount,
    required this.booking_id,
    required this.date,
    required this.expiry,
    required this.guide_id,
    required this.status,
    required this.user_id
  });
}

