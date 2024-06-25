// import 'dart:async';
// import 'dart:convert';
// import 'package:ap_landscaping/config.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:http/http.dart' as http;
//
// class CustomerGoogleLoginPage extends StatefulWidget {
//   @override
//   _CustomerGoogleLoginPageState createState() => _CustomerGoogleLoginPageState();
// }
//
// class _CustomerGoogleLoginPageState extends State<CustomerGoogleLoginPage> {
//   final Completer<WebViewController> _controllerCompleter = Completer<WebViewController>();
//   bool _isLoading = true;
//   String? _htmlContent;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchInitialData();
//   }
//
//   Future<void> _fetchInitialData() async {
//     try {
//       final response = await http.get(Uri.parse(googleLogin));
//       if (response.statusCode == 200) {
//         setState(() {
//           _htmlContent = response.body;
//           _isLoading = false;
//         });
//       } else {
//         // Handle API request failure
//         _showErrorDialog('Failed to load data from API');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       _showErrorDialog('Error fetching data: $e');
//     }
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Login'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : WebView(
//         initialUrl: 'about:blank',
//         onWebViewCreated: (WebViewController webViewController) {
//           _controllerCompleter.complete(webViewController);
//           if (_htmlContent != null) {
//             webViewController.loadUrl(Uri.dataFromString(
//               _htmlContent!,
//               mimeType: 'text/html',
//               encoding: Encoding.getByName('utf-8'),
//             ).toString());
//           }
//         },
//         javascriptMode: JavascriptMode.unrestricted,
//         onPageStarted: (String url) {
//           print('Page started loading: $url');
//         },
//         onPageFinished: (String url) {
//           print('Page finished loading: $url');
//         },
//         onWebResourceError: (WebResourceError error) {
//           print('Web resource error: ${error.description}');
//           _showErrorDialog('Failed to load the page. Error: ${error.description}');
//         },
//       ),
//     );
//   }
// }
