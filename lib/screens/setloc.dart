import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetLocationScreen extends StatefulWidget {
  final VoidCallback onLocationSet;
  
  const SetLocationScreen({
    Key? key,
    required this.onLocationSet,
  }) : super(key: key);

  @override
  _SetLocationScreenState createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadHtmlString('''
        <!DOCTYPE html>
        <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            body, html {
              margin: 0;
              padding: 0;
              width: 100%;
              height: 100%;
              overflow: hidden;
            }
            iframe {
              width: 100%;
              height: 100%;
              border: none;
            }
          </style>
        </head>
        <body>
          <iframe 
            src="https://www.google.com/maps/embed?pb=!1m17!1m12!1m3!1d3412.495062961182!2d29.931398075438103!3d31.207010974358983!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMzHCsDEyJzI1LjIiTiAyOcKwNTYnMDIuMyJF!5e0!3m2!1sen!2seg!4v1745885459919!5m2!1sen!2seg" 
            allowfullscreen="" 
            loading="lazy" 
            referrerpolicy="no-referrer-when-downgrade">
          </iframe>
        </body>
        </html>
      ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // White container for title and search
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set your location",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Search your location for accurate matching.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Search Box
                  Container(
                    height: 56,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.blue, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search your location',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Map Container
            Expanded(
              child: Stack(
                children: [
                  // WebView Map
                  Positioned.fill(
                    child: WebViewWidget(controller: controller),
                  ),

                  // Loading Indicator
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    ),

                  // Floating GPS button
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        // Implement location refresh if needed
                      },
                      child: Icon(Icons.my_location, color: Colors.black),
                    ),
                  ),

                  // Confirm Location Button
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 100,
                    child: ElevatedButton(
                      onPressed: widget.onLocationSet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Confirm Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}