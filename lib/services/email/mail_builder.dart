import 'package:foodpanzu/models/menu_model.dart';
import 'package:foodpanzu/models/order_item_model.dart';
import 'package:foodpanzu/models/order_model.dart';
import 'package:foodpanzu/models/restaurant_model.dart';
import 'package:foodpanzu/models/user_model.dart';

String orderInvoiceMailBuilder(
    {required Order order,
    required List<OrderItem> orderItems,
    required List<Menu> menuList,
    required Restaurant restaurant}) {
  String datePaid = "2/22/2022";

  // ignore: prefer_interpolation_to_compose_strings
  String html = '<!DOCTYPE html>' +
      '<html lang="en">' +
      '' +
      '<head>' +
      '    <meta charset="UTF-8" />' +
      '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />' +
      '    <title>Document</title>' +
      '    <style>' +
      '        @import url("https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,200&display=swap");' +
      '        * {' +
      '            margin: 0;' +
      '            padding: 0;' +
      '            border: 0;' +
      '        }' +
      '        body {' +
      '            font-family: "Raleway", sans-serif;' +
      '            background-color: #d8dada;' +
      '            font-size: 19px;' +
      '            max-width: 800px;' +
      '            margin: 0 auto;' +
      '            padding: 3%;' +
      '        }' +
      '' +
      '        img {' +
      '            max-width: 100%;' +
      '        }' +
      '' +
      '        header {' +
      '            width: 98%;' +
      '        }' +
      '' +
      '        #logo {' +
      '            max-width: 120px;' +
      '            margin: 3% 0 3% 3%;' +
      '            float: left;' +
      '        }' +
      '' +
      '        #wrapper {' +
      '            background-color: #f0f6fb;' +
      '        }' +
      '' +
      '' +
      '        h1,' +
      '        h4,' +
      '        p,' +
      '        table {' +
      '            margin: 3%;' +
      '        }' +
      '' +
      '        table {' +
      '    ' +
      '            border-collapse: collapse;' +
      '        }' +
      '' +
      '        tr {' +
      '            border-bottom: 1px solid rgb(134, 134, 134);' +
      '        }' +
      '' +
      '        td{' +
      '            padding: 0 15px;' +
      '        }' +
      '' +
      '        hr {' +
      '            height: 1px;' +
      '            background-color: #303840;' +
      '            clear: both;' +
      '            width: 96%;' +
      '            margin: auto;' +
      '        }' +
      '' +
      '    </style>' +
      '</head>' +
      '' +
      '<body>' +
      '    <div id="wrapper">' +
      '        <div id="banner">' +
      '            <img src="https://firebasestorage.googleapis.com/v0/b/foodpanzu.appspot.com/o/FoodPanzu.PNG?alt=media&token=5c15bddc-4f75-4b01-946d-37d137f0d851"' +
      '                alt="" width="800px" />' +
      '        </div>' +
      '        <div class="one-col">' +
      '            <h1>Your recent order invoice from FoodPanzu</h1>' +
      '' +
      '            <table class="table">' +
      '                <thead>' +
      '                    <tr>' +
      '                        <th>Order Item</th>' +
      '                        <th>Quantity</th>' +
      '                        <th>Restaurant Name</th>' +
      '                        <th>Table Number</th>' +
      '                        <th>Amount Paid</th>' +
      '                        <th>Date Paid</th>' +
      '                    </tr>' +
      '                </thead>' +
      '                <tbody>';

  for (int i = 0; i < orderItems.length; i++) {
    html += '<tr><td>${menuList[i].foodName}</td>';
    html += '<td>${orderItems[i].quantity}</td>';
    html += '<td>${restaurant.restName}</td>';
    html += '<td>${order.tableNumber}</td>';
    html += '<td>${(menuList[i].foodPrice * orderItems[i].quantity)}</td>';
    html += '<td>$datePaid</td><tr>';
  }

  //row for total price before tax
  html +=
      '</tbody></table><h4>Total before Tax :RM${(order.totalPrice / 1.06).toStringAsFixed(2)}</h4>';

  //row for total price after tax
  html +=
      '<h4>Total before Tax :RM${order.totalPrice.toStringAsFixed(2)}</h4><hr/></div></div></html>';
  return html;
}
