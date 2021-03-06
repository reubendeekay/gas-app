import 'package:gas/models/product_model.dart';

List<Map<String, dynamic>> paymentMethods = [
  {
    'icon': 'https://www.un.org/sites/un2.un.org/files/mpesa.png',
    'name': 'M-Pesa',
    'details': '0796 **** 87'
  },
  // {
  //   'icon': 'https://www.un.org/sites/un2.un.org/files/visa.png',
  //   'name': 'Visa',
  //   'details': '8719 **** **** 1892'
  // },
  {
    'icon':
        'https://logos-world.net/wp-content/uploads/2020/09/Mastercard-Logo.png',
    'name': 'Credit Card',
    'details': '8719 **** **** 1892'
  },
  {
    'name': 'PayPal',
    'icon':
        'https://seeklogo.com/images/P/paypal-logo-481A2E654B-seeklogo.com.png',
    'details': 'Pay via paypal wallet'
  },
  {
    'icon':
        'https://toppng.com/uploads/preview/cash-in-hand-icon-11549486230pl37r7u3fu.png',
    'name': 'Cash',
    'details': 'Pay on Arrival',
  }
];

List<String> deliveryStatus = [
  'Pending approval',
  'Your order is being prepared',
  'Driver is on the way to pick your order',
  'Driver is on the way to you',
  'Your order is ready for pickup',
];

List<String> gasQuantities = [
  '6kg',
  '13kg',
  '22.5kg',
  '50kg',
];
