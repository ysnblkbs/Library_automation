// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odevdeneme/models/book_model.dart';
import 'package:odevdeneme/views/home.dart';
import 'package:odevdeneme/widgets/custom_textfield.dart';

class AddBooksView extends StatefulWidget {
  const AddBooksView({
    Key? key,
    this.updateBookProperties,
  }) : super(key: key);

  final Book? updateBookProperties;
  @override
  State<AddBooksView> createState() => _AddBooksViewState();
}

class _AddBooksViewState extends State<AddBooksView> {
  final GlobalKey<FormState> _key = GlobalKey();
  String? _selectedBookCategory;
  final List<String> _items = [
    'Roman',
    'Piskoloji',
    'Tarih',
    'Bilim Kurgu',
    'Polisiye'
  ];
  bool _isChecked = true;

  // FormField Controller değişkenleri
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _bookPageNumberController =
      TextEditingController();
  final TextEditingController _bookPublishedsYear = TextEditingController();
  @override
  void initState() {
    if (widget.updateBookProperties != null) {
      final book = widget.updateBookProperties;
      _bookNameController.text = book?.bookName ?? "";
      _publisherController.text = book?.publisher ?? "";
      _authorController.text = book?.author ?? "";
      _bookPageNumberController.text = book!.pageNumber.toString();
      _bookPublishedsYear.text = book.publishedYear.toString();
      _selectedBookCategory = book.category;
      _isChecked = book.isPublish ?? true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextField(
                    hintText: "Kitap Adı",
                    controller: _bookNameController,
                  ),
                  CustomTextField(
                    hintText: "Yayınevi",
                    controller: _publisherController,
                  ),
                  CustomTextField(
                    hintText: "Yazarlar",
                    controller: _authorController,
                  ),
                  DropdownButton(
                      hint: const Text("Kitap Türünü Seçin"),
                      value: _selectedBookCategory,
                      items: _items
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          _selectedBookCategory = item;
                        });
                      }),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Sayfa Sayısı",
                    controller: _bookPageNumberController,
                  ),
                  CustomTextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    hintText: "Basım Yılı",
                    controller: _bookPublishedsYear,
                  ),
                  ListTile(
                    title: const Text("Listede Yayınlanacak Mı?"),
                    trailing: Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value ?? false;
                            print(_isChecked);
                          });
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          if (_selectedBookCategory != null) {
                            final bookName = _bookNameController.text.trim();
                            final publisher = _publisherController.text.trim();
                            final author = _authorController.text.trim();
                            final pageNumber =
                                int.parse(_bookPageNumberController.text);
                            final publishedYear =
                                int.tryParse(_bookPublishedsYear.text);
                            final bookCategory = _selectedBookCategory;
                            final isPublished = _isChecked;

                            final book = Book(
                              bookName: bookName,
                              publisher: publisher,
                              author: author,
                              category: bookCategory,
                              pageNumber: pageNumber,
                              publishedYear: publishedYear,
                              isPublish: isPublished,
                            ).toJson();

                            await FirebaseFirestore.instance
                                .collection("books")
                                .doc(bookName)
                                .set(book);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => Home()),
                                (route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Lütfen Kitap Türünü Seçin!')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Formu doğru bilgilerle doldurun")));
                        }
                      },
                      child: const Text("Kaydet"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
