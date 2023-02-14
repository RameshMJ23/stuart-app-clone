import 'package:flutter/material.dart';
import 'package:stuartappclone/screens/constants/StuartTextStyles.dart';
import 'package:stuartappclone/screens/constants/constants.dart';
import 'package:stuartappclone/screens/no_internet_screen_builder.dart';
import 'package:stuartappclone/screens/widgets/build_button.dart';
import 'package:stuartappclone/screens/widgets/build_textfield.dart';
import 'package:stuartappclone/screens/widgets/report_issue_widget.dart';


enum MessageEnum{
  sendingMessage,
  sentMessage,
  noMessageSent
}

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final layerLink = LayerLink();
  late OverlayEntry sticky;
  GlobalKey stickyKey = GlobalKey();
  late TextEditingController _messageController;
  late ValueNotifier<MessageEnum> _messageSentNotif;

  @override
  void initState() {
    // TODO: implement initState

    sticky = OverlayEntry(
      builder: (context) => stickyBuilder(context),
    );

    _messageController = TextEditingController();

    _messageSentNotif = ValueNotifier<MessageEnum>(MessageEnum.noMessageSent);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NoInternetScreenBuilder(
      child: WillPopScope(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: getPeachColor,
            appBar: getLeadingOnlyAppBar(context: context, leadingFunction: (){
              if(sticky.mounted) sticky.remove();
            }),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0
              ),
              child: ValueListenableBuilder<MessageEnum>(
                valueListenable: _messageSentNotif,
                builder: (context, messageSent, child){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Something went wrong?",
                        style: StuartTextStyles.w50022,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _messageSentNotif,
                          builder: (context, messageEnum, child){
                            return (messageEnum  == MessageEnum.noMessageSent
                                || messageEnum == MessageEnum.sendingMessage)
                                ? Column(
                              children: [
                                buildReportField(
                                    textEditingController: _messageController,
                                    key: stickyKey,
                                    fieldName: "Message",
                                    hintText: "Please explain what happened",
                                    multiLine: true
                                ),
                                buildReportField(
                                    fieldName: "Email Address",
                                    hintText: "Enter your email address(optional)"
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: BuildButton(
                                      marginVertPad: 10.0,
                                      buttonName: messageEnum == MessageEnum.sendingMessage
                                          ? "Please wait..." : "Send",
                                      onPressed: (){
                                        if(_messageController.text.trim().isEmpty){
                                          Overlay.of(context)!.insert(sticky);
                                        }else{
                                          if(sticky.mounted) sticky.remove();
                                          _messageSentNotif.value = MessageEnum.sendingMessage;

                                          Future.delayed(const Duration(seconds: 1), (){
                                            _messageSentNotif.value = MessageEnum.sentMessage;
                                          });

                                          Future.delayed(const Duration(seconds: 3), (){
                                            if(mounted){
                                              Navigator.pop(context);
                                            }
                                          });
                                        }
                                      }
                                  ),
                                )
                              ],
                            )
                                : _messageSentWidget();
                          }
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          onWillPop: () async{
            if(sticky.mounted) sticky.remove();
            return Future.value(true);
          }
      ),
    );
  }

  Widget _messageSentWidget() => Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    color: getGreenColor,
    child: Text(
      "Thank you! Your message has been received! We'll look into it ASAP!",
      style: StuartTextStyles.w50015.copyWith(color: Colors.white70),
      textAlign: TextAlign.center,
    ),
  );

  Widget stickyBuilder(BuildContext context) {

    final box = stickyKey.currentContext!.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);

    return Positioned(
      top: pos.dy + box.size.height,
      left: 100.0,
      child: GestureDetector(
        child: Container(
          child: CustomPaint(
            size: Size(160, (110*0.4276094276094276).toDouble()),
            painter: RPSCustomPainter(),
          ),
          decoration: const BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2,8),
                    blurRadius: 5.0
                )
              ]
          ),
        ),
        onTap: (){
          sticky.remove();
        },
      ),
    );
  }
}

