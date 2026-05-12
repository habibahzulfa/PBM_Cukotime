import 'package:flutter/material.dart';

import 'api_services.dart';
import 'models.dart';

class SubmitPage extends StatefulWidget {
  final ProductModel product;

  const SubmitPage({
    super.key,
    required this.product,
  });

  @override
  State<SubmitPage> createState() =>
      _SubmitPageState();
}

class _SubmitPageState
    extends State<SubmitPage> {

  final githubController =
      TextEditingController();

  bool isLoading = false;

  Future submitTugas() async {

    if (githubController.text.isEmpty) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          content: Text(
            'GitHub URL wajib diisi',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    bool success =
        await ApiService.submitTugas(
      widget.product,
      githubController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          content: Text(
            'Tugas berhasil dikirim',
          ),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          content: Text(
            'Submit gagal',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          Color(0xffF7F1E5),

      appBar: AppBar(

        backgroundColor:
            Color(0xff8B5E3C),

        elevation: 0,

        centerTitle: true,

        title: Text(

          'Submit GitHub',

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Container(

                width: double.infinity,

                padding:
                    EdgeInsets.all(24),

                decoration:
                    BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    25,
                  ),

                  boxShadow: [

                    BoxShadow(
                      color:
                          Colors.black12,

                      blurRadius: 10,

                      offset:
                          Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Container(

                      height: 60,
                      width: 60,

                      decoration:
                          BoxDecoration(

                        color:
                            Color(0xffF7E6D5),

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: Icon(

                        Icons.link_rounded,

                        color:
                            Color(0xff8B5E3C),

                        size: 32,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(

                      'Upload Repository',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xff5C3B28),
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(

                      'Masukkan link GitHub repository tugasmu di bawah ini.',

                      style: TextStyle(
                        color:
                            Colors.brown.shade400,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 25),

                    TextField(

                      controller:
                          githubController,

                      cursorColor:
                          Color(0xff8B5E3C),

                      decoration:
                          InputDecoration(

                        hintText:
                            'https://github.com/username/repository',

                        filled: true,

                        fillColor:
                            Color(0xffF7F1E5),

                        prefixIcon:
                            Icon(

                          Icons.code,

                          color:
                              Color(0xff8B5E3C),
                        ),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              BorderSide.none,
                        ),

                        focusedBorder:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),

                          borderSide:
                              BorderSide(

                            color:
                                Color(0xff8B5E3C),

                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    SizedBox(

                      width:
                          double.infinity,

                      height: 55,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              Color(0xff8B5E3C),

                          elevation: 0,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),

                        onPressed:
                            isLoading
                                ? null
                                : submitTugas,

                        child:
                            isLoading
                                ? SizedBox(

                                    height: 22,
                                    width: 22,

                                    child:
                                        CircularProgressIndicator(

                                      color:
                                          Colors.white,

                                      strokeWidth:
                                          2.5,
                                    ),
                                  )
                                : Text(

                                    'Upload / Submit Tugas',

                                    style: TextStyle(

                                      color:
                                          Colors.white,

                                      fontSize: 16,

                                      fontWeight:
                                          FontWeight.bold,
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
      ),
    );
  }
}