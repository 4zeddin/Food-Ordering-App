import 'package:flutter_dotenv/flutter_dotenv.dart';

String publishablekey = '${dotenv.env['STRIPE_PUBLIC_KEY']}';
String secretkey = '${dotenv.env['STRIPE_SECRET_KEY']}';
