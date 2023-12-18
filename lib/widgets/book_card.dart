import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odevdeneme/models/book_model.dart';
import 'package:odevdeneme/views/add_books.dart';

class BooksCard extends StatelessWidget {
  const BooksCard({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text("${book.bookName} - ${book.publishedYear}"),
          subtitle:
              Text("Yazar: ${book.author}, Sayfa Sayısı: ${book.pageNumber}"),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddBooksView(updateBookProperties: book)));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          title: Center(child: Text("${book.bookName}")),
                          content: SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "${book.bookName} adlı kitabı kütüphaneden silmek istediğinize emin msisiniz?",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("İptal Et")),
                            ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("books")
                                      .doc(book.bookName)
                                      .delete();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Bu kitap başarıyla silindi: ${book.bookName}")));
                                },
                                child: const Text("Sil")),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.restore_from_trash_rounded)),
          ]),
        ),
      ),
    );
  }
}
