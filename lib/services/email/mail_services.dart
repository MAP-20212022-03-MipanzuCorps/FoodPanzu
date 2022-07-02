import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:map_mvvm/map_mvvm.dart';

Future invoiceMail(
    {String receivingName = "FoodPanzuUser",
    required String receivingEmail,
    required String message}) async {
  const serviceId = 'service_1yliw24';
  const templateId = 'template_x04izii';
  const userId = 'VIBcWRpnUeLK8jjZa';
  const privateKey = "QPSfVXLvZ_tySkp127rz4";
  var url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  if (!RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(receivingEmail)) {
    //do nothing
  }
  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': privateKey,
          'template_params': {
            'to_name': receivingName,
            'to_email': receivingEmail,
            'message': message
          }
        },
      ),
    );
  } catch (error) {
    throw Failure("400",
        message: error.toString(), location: "mail_service.dart");
  }
}
