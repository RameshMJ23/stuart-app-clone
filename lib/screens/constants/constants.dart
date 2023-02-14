import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stuartappclone/bloc/filter_bloc/filter_state.dart';
import 'package:stuartappclone/data/model/bitmap_descriptor_model.dart';
import 'package:stuartappclone/data/model/card_detail_model.dart';
import 'package:stuartappclone/data/model/location_model.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';

Color get getPeachColor => const Color(0xFFEFE0D7);

Color get getVioletColor => const Color(0xFF8D6E97);

Color get getRedColor => const Color(0xFFCC4242);

Color get getGreenColor => const Color(0xFF749C6A);

OutlineInputBorder get getTextFieldBorder => const OutlineInputBorder(
  borderSide: BorderSide(color: Colors.transparent),
);


Widget get authOrText => Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      "Or",
      style: StuartTextStyles.w60016.copyWith(color: Colors.black),
    ),
  ),
);

Widget loginGoogleButton({
  required BuildContext context,
  required String content,
  required Function(BuildContext) onPressed
}) => BuildButton.custom(
  customButtonIcon: Icons.add,
  customButtonText: content,
  buttonColor: Colors.white,
  onPressed: (){
    showLoadingDialog(context: context, dialogFunc: onPressed);
  },
);

showLoadingDialog({
  String content = "Loading...",
  required BuildContext context,
  required Function(BuildContext) dialogFunc
}){
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext){

        dialogFunc(dialogContext);
        return Dialog(
          key: const Key("authLoadingDialog"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 50.0, vertical: 15.0
            ),
            child: Row(
              children: [
                CircularProgressIndicator(
                  color: getVioletColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0
                    ),
                    child: Text(
                      content,
                      style: StuartTextStyles.normal16,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
  );
}
AppBar getLeadingOnlyAppBar({
  required BuildContext context,
  List<Widget>? trailingWidgets,
  Function? leadingFunction
}) => AppBar(
  elevation: 0.0,
  backgroundColor: getPeachColor,
  leading: getAppBarLeading(
    context: context, leadingFunction: leadingFunction
  ),
  actions: trailingWidgets,
);

Widget getAppBarLeading({
  required BuildContext context,
  Function? leadingFunction
}) => IconButton(
  icon: const Icon(
    Icons.arrow_back,
    color: Colors.black87
  ),
  onPressed: (){
    if(leadingFunction != null) leadingFunction();
    Navigator.pop(context);
  },
);

Widget buildTextButton({
  required String buttonName,
  double borderRadius = 3.0,
  VoidCallback? onTap,
  Color? textColor,
}) => InkWell(
  splashColor: getVioletColor.withOpacity(0.3),
  highlightColor: getVioletColor.withOpacity(0.2),
  child: Container(
    padding: const EdgeInsets.symmetric(
      vertical: 5.0, horizontal: 10.0
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Text(
      buttonName,
      style: StuartTextStyles.w60016.copyWith(
        color: textColor ?? getVioletColor
      ),
    ),
  ),
  onTap: onTap,
);

Widget getUserImage({
  String? imageUrl,
  double marginVertPad = 0.0,
  Key? key
}) => Container(
  key: key,
  margin: EdgeInsets.symmetric(vertical: marginVertPad),
  height: 100.0,
  width: 100.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100.0),
    image: DecorationImage(
      image: imageUrl != null
        ? NetworkImage(imageUrl)
        : const AssetImage("assets/person_icon.jpg") as ImageProvider,
      fit: BoxFit.fill
    )
  ),
);

Widget buildScreenTitle({
  required String content,
  double topPadding = 15.0,
  double bottomPadding = 40.0,
  double fontSize = 30.0
}) => Padding(
  padding: EdgeInsets.only(
    top: topPadding,
    bottom: bottomPadding
  ),
  child: Text(
    content,
    style: StuartTextStyles.w60030.copyWith(
      fontSize: fontSize
    ),
  ),
);


Widget buildReportField({
  required String fieldName,
  required String hintText,
  bool multiLine = false,
  GlobalKey? key,
  TextEditingController? textEditingController
}) => Padding(
  key: key,
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          fieldName,
          style: StuartTextStyles.w60016,
        ),
      ),
      TextFormField(
        controller: textEditingController,
        maxLines: multiLine ? null: 1,
        minLines: multiLine ? 6 : 1,
        decoration: InputDecoration(
          hintText: hintText,
          border: reportFieldBorder,
          focusedErrorBorder: reportFieldBorder,
          focusedBorder: reportFieldBorder,
          enabledBorder: reportFieldBorder,
          fillColor: Colors.white.withOpacity(0.75),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0, vertical: 10.0
          ),
          hintStyle: StuartTextStyles.w40014
        ),
        style: StuartTextStyles.w40016.copyWith(color: Colors.black87),
      )
    ],
  ),
);

OutlineInputBorder get reportFieldBorder => OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: const BorderSide(color: Colors.transparent)
);

String? emailValidator(TextEditingController controller, String? val){
  return controller.text.isEmpty
    ? "This field cannot be empty"
    : (controller.text.length < 4
      || !controller.text.contains("@")
      || !controller.text.contains(".")
    )
    ? "Invalid email"
    : null;
}

Widget noHistoryAvail({
  required Key key,
  required IconData icon,
  required String content
}) => Expanded(
  key: key,
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Icon(
            icon,
            size: 60.0,
            color: Colors.black54,
          ),
        ),
        Text(
          content,
          style: StuartTextStyles.w50016,
        )
      ],
    ),
  ),
);


Widget buildKeyIcon({
  double radius = 15.0
}) => Container(
  height: radius,
  width: radius,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: getRedColor
  ),
  child: Transform.rotate(
    angle: 20,
    child: Icon(
      Icons.vpn_key,
      color: Colors.white,
      size: radius / 2,
    ),
  ),
);

Widget buildOptionTile({
  required String title,
  String? leadingIconUrl,
  required VoidCallback onPressed,
  double leadingIconSize = 25.0,
  double vertPad = 6.0
}) => Theme(
  data: ThemeData(
    splashColor: getVioletColor.withOpacity(0.3),
    highlightColor: getVioletColor.withOpacity(0.2)
  ),
  child: ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0)
    ),
    focusColor: getVioletColor.withOpacity(0.3),
    selectedTileColor: getVioletColor.withOpacity(0.3),
    selectedColor: getVioletColor.withOpacity(0.3),
    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
    contentPadding: EdgeInsets.symmetric(vertical: vertPad, horizontal: 10.0),
    title: Text(
      title,
      style: StuartTextStyles.w50016,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 15.0,
      color: Colors.black54,
    ),
    horizontalTitleGap: 0.0,
    leading: leadingIconUrl != null
      ? Container(
        height: leadingIconSize,
        width: leadingIconSize,
        decoration: BoxDecoration(
          color: getPeachColor,
          image: DecorationImage(
            image: AssetImage(
              leadingIconUrl
            )
          )
        ),
      ): null,
    onTap: onPressed,
  ),
);

BitmapDescriptor getEvIcon(
  LocationModel locationModel, List<BitMapDescriptorModel> iconList
){
  if(locationModel.limitedAccess){

    return locationModel.connection_info.where(
            (info) => info.available).isNotEmpty
        ? _getBitMapImage(iconList, BitMapDescriptorEnum.greenWithKey)
        :  _getBitMapImage(iconList, BitMapDescriptorEnum.redWithKey);

  }else{

    return locationModel.connection_info.where(
            (info) => info.available).isNotEmpty
        ? _getBitMapImage(iconList, BitMapDescriptorEnum.greenWithoutKey)
        : _getBitMapImage(iconList, BitMapDescriptorEnum.redWithoutKey);

  }
}

BitmapDescriptor _getBitMapImage(
    List<BitMapDescriptorModel> imageList, BitMapDescriptorEnum conditionEnum
    ) => imageList.firstWhere(
        (element) => element.bitMapEnum == conditionEnum
).image;

Widget buildMasterCard({
  bool showBorder = true,
  double height = 20.0,
  double width = 30.0
}) => buildPaymentIcons(
  imageUrl: "assets/mastercard_logo.jpg",
  borderColor: showBorder ? Colors.grey.shade200: Colors.transparent,
  borderRadius: 3.0,
  height: height,
  width: width
);

Widget buildVisaCard({
  bool showBorder = true,
  double height = 20.0,
  double width = 30.0
}) => buildPaymentIcons(
  imageUrl: "assets/visa_logo.jpg",
  borderColor: showBorder ? Colors.grey.shade200: Colors.transparent,
  borderRadius: 3.0,
  height: height,
  width: width
);

Widget buildPaymentIcons({
  required String imageUrl,
  required Color borderColor,
  required double borderRadius,
  double height = 20.0,
  double width = 30.0
}) => Container(
  margin: const EdgeInsets.symmetric(horizontal: 5.0),
  padding: const EdgeInsets.symmetric(horizontal: 3.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor),
    color: Colors.grey[50],
  ),
  height: height,
  width: width,
  child: Image.asset(
    imageUrl
  ),
);


String getCardNumToShow(CardDetailModel cardDetails){
  String lastCardDigits = cardDetails.cardNumber
      .substring(15, 19);

  if(cardDetails.companyName != null){
    return "Business •••• $lastCardDigits";
  }else{
    return "Personal •••• $lastCardDigits";
  }
}

bool isFilterEnabled(FilterState filterState){
  return (filterState.availConnectors
      || filterState.publicConnectors
      || !filterState.type1 || !filterState.type2
      || filterState.lowestPowerRange != "0.0"
      || filterState.highestPowerRange != "175.0"
  );
}

showErrorDialog({
  required BuildContext context,
  required String title,
  required String content,
  Function? onPressed
}){
  showDialog(
    context: context,
    builder: (dialogContext){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: getPeachColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 15.0
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0
                ),
                child: Text(
                  title,
                  style: StuartTextStyles.w50022,
                ),
              ),
              Text(
                content,
                style: StuartTextStyles.w40014,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: BuildButton(
                    buttonName: "Ok",
                    onPressed: (){
                      if(onPressed != null) onPressed();
                      Navigator.pop(dialogContext);
                    }
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  );
}