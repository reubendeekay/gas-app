import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gas/models/driver_model.dart';
import 'package:gas/models/message_model.dart';
import 'package:gas/models/request_model.dart';
import 'package:gas/models/user_model.dart';
import 'package:gas/providers/auth_provider.dart';
import 'package:gas/providers/chat_provider.dart';
import 'package:gas/providers/location_provider.dart';
import 'package:gas/providers/request_provider.dart';
import 'package:gas/screens/chat/chatroom.dart';
import 'package:gas/screens/trail/widgets/delivery_driver_processing.dart';
import 'package:gas/screens/trail/widgets/trail_delivery_details_widget.dart';
import 'package:gas/screens/trail/widgets/trail_order_summary_widget.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class TrailDeliverySheet extends StatelessWidget {
  const TrailDeliverySheet({Key? key, required this.request}) : super(key: key);

  final RequestModel request;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
              height: size.height - 225,
            ),
          ),
          request.driver == null
              ? const DeliveryDriverProcessing()
              : Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  // padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Container(
                          height: 4,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DeliveryDriverWidget(
                        request: request,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      TrailDeliveryDetailsWidget(
                        request: request,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      TrailOrderSummaryWidget(
                        request: request,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class DeliveryDriverWidget extends StatefulWidget {
  const DeliveryDriverWidget({Key? key, required this.request})
      : super(key: key);
  final RequestModel request;

  @override
  State<DeliveryDriverWidget> createState() => _DeliveryDriverWidgetState();
}

class _DeliveryDriverWidgetState extends State<DeliveryDriverWidget> {
  String messageText = '';
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: CachedNetworkImageProvider(
                  widget.request.driver!.user!.profilePic!,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.request.driver!.user!.fullName!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Text(
                    widget.request.driver!.plateNumber ?? 'No Plate Number',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(
                      widget.request.driver!.user!.phone!);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[200]),
                  child: const Icon(Icons.call),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: TextFormField(
                        onChanged: (val) {
                          setState(() {
                            messageText = val;
                          });
                        },
                        controller: messageController,
                        onEditingComplete: () async {
                          if (messageText.isNotEmpty) {
                            final message = MessageModel(
                                receiverId: widget.request.driver!.userId,
                                senderId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                message: messageText,
                                sentAt: Timestamp.now(),
                                mediaFiles: [],
                                mediaType: 'text',
                                isRead: false);

                            Provider.of<ChatProvider>(context, listen: false)
                                .sendMessage(widget.request.id!, message,
                                    widget.request.driver!.userId!);
                            messageController.clear();
                            Get.to(() => ChatRoom(
                                  widget.request.driver!,
                                  chatRoomId: widget.request.id!,
                                ));
                          } else {
                            Get.to(() => ChatRoom(
                                  widget.request.driver!,
                                  chatRoomId: widget.request.id!,
                                ));
                          }
                        },
                        textInputAction: TextInputAction.send,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            fillColor: Colors.grey[200],
                            hintText: 'Send Message',
                            hintStyle: const TextStyle(
                                color: Colors.black, fontSize: 12),
                            filled: true,
                            border: InputBorder.none)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
