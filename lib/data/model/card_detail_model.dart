

List<CardDetailModel> mapToCardDetailModelList(
  List cardsList
) => cardsList.map((data){
  return CardDetailModel.mapToModel(data as Map<String, dynamic>);
}).toList();

List<Map> cardDetailModelToMapList(
  List<CardDetailModel> cardsList
) => cardsList.map((cardData){
  return CardDetailModel.modelToMap(cardData);
}).toList();

class CardDetailModel{

  String cardNumber;

  String expMonth;

  String expYear;

  String ccv;

  String? companyName;

  String? companyCode;

  String? companyAddress;

  String? vatCode;

  bool defaultCard;

  CardDetailModel({
    required this.cardNumber,
    required this.expMonth,
    required this.expYear,
    required this.ccv,
    this.defaultCard = false,
    this.companyName,
    this.companyCode,
    this.companyAddress,
    this.vatCode,
  });

  factory CardDetailModel.mapToModel(
    Map<String, dynamic> data
  ) => CardDetailModel(
    cardNumber: data['card_number'],
    expMonth: data['exp_month'],
    expYear: data['exp_year'],
    ccv: data['ccv'],
    defaultCard: data['default_card'],
    companyName: data['company_name'],
    companyAddress: data['company_address'],
    companyCode: data['company_code'],
    vatCode: data['vat']
  );

  static Map<String, dynamic> modelToMap(
    CardDetailModel cardDetailModel
  ) => {
    'card_number': cardDetailModel.cardNumber,
    'exp_month': cardDetailModel.expMonth,
    'exp_year': cardDetailModel.expYear,
    'ccv': cardDetailModel.ccv,
    'company_name': cardDetailModel.companyName,
    'company_address': cardDetailModel.companyAddress,
    'company_code': cardDetailModel.companyCode,
    'vat': cardDetailModel.vatCode,
    'default_card': cardDetailModel.defaultCard
  };

  CardDetailModel copyWith({
    String? cardNumber,
    String? expMonth,
    String? expYear,
    String? ccv,
    String? companyName,
    String? companyCode,
    String? companyAddress,
    String? vatCode,
    bool? defaultCard
  }) => CardDetailModel(
    cardNumber: cardNumber ?? this.cardNumber,
    expMonth: expMonth ?? this.expMonth,
    expYear: expYear ?? this.expYear,
    ccv: ccv ?? this.ccv,
    companyName: companyName ?? this.companyName,
    companyCode: companyCode ?? this.companyCode,
    companyAddress: companyAddress ?? this.companyAddress,
    vatCode: vatCode ?? this.vatCode,
    defaultCard: defaultCard ?? this.defaultCard
  );
}