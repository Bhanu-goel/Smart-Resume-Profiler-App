import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'result_screen.dart';

class ResumeAnalysisScreen extends StatefulWidget {
  @override
  _ResumeAnalysisScreenState createState() => _ResumeAnalysisScreenState();
}

class _ResumeAnalysisScreenState extends State<ResumeAnalysisScreen> {
  String? _selectedDomain;
  String? _uploadedResume;
  bool _isEvaluating = false; // Track evaluation status

  final List<String> _jobDomains = [
    'software_engineering',
    'data_science',
    'marketing',
    // Add more domains as needed
  ];

  Future<void> _uploadResume() async {
    String? filePath = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    ).then((result) => result?.files.single.path);

    if (filePath != null) {
      setState(() {
        _uploadedResume = filePath; // Save the file path
      });
    }
  }

  void _evaluateResume() async {
    if (_selectedDomain != null && _uploadedResume != null) {
      setState(() {
        _isEvaluating = true; // Set evaluating status to true
      });

      // Prepare the file for upload
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:5000/auth/evaluate'), // Replace with your backend URL
      );
      request.fields['domain'] = _selectedDomain!;
      request.files
          .add(await http.MultipartFile.fromPath('resume', _uploadedResume!));

      try {
        // Send the request and wait for the response
        var response = await request.send();
        if (response.statusCode == 200) {
          // Successfully received a response
          setState(() {
            _isEvaluating = false; // Reset evaluating status
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultScreen(
                      domain: _selectedDomain!,
                    )),
          );
        } else {
          // Handle errors
          setState(() {
            _isEvaluating = false; // Reset evaluating status
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        setState(() {
          _isEvaluating = false; // Reset evaluating status
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a domain and upload a resume.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1F2D),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent.withOpacity(0.1), Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Resume Analysis',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1F2D),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.greenAccent.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose Your Domain:',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          DropdownButton<String>(
                            value: _selectedDomain,
                            hint: Text('Select Domain',
                                style: TextStyle(color: Colors.white70)),
                            dropdownColor: Color(0xFF0D1F2D),
                            items: _jobDomains.map((String domain) {
                              return DropdownMenuItem<String>(
                                value: domain,
                                child: Text(domain,
                                    style: TextStyle(color: Colors.white)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDomain = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.greenAccent.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload Your Resume:',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _uploadResume,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black,
                            ),
                            child: Text('Select Resume'),
                          ),
                          if (_uploadedResume != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Uploaded Resume: ${_uploadedResume!.split('/').last}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _evaluateResume,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                    ),
                    child: _isEvaluating
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                              SizedBox(width: 10),
                              Text('Evaluating...'),
                            ],
                          )
                        : Text('Evaluate Resume'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
