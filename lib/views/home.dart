// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odevdeneme/models/book_model.dart';
import 'package:odevdeneme/views/add_books.dart';
import 'package:odevdeneme/widgets/book_card.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(icon: Icon(Icons.book), label: "Kitaplar"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), label: "Satın Al"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ayarlar")
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>> kitpalariGetir() {
    //BU FONKSİYON İLE VERİYİ ÇEKTİK
    return FirebaseFirestore.instance
        .collection("books")
        .where("isPublish", isEqualTo: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: _items),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddBooksView()));
            },
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 180, 8, 8),
            )),
        appBar: AppBar(
          title: const Text("YASİN BÖLÜKBAŞI KÜTÜPHANE"),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: kitpalariGetir(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Hata Oluştu'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final allBooks = snapshot.data?.docs;
                return Center(
                  child: ListView.builder(
                    itemCount: allBooks?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final book = Book.fromJson(
                          allBooks?[index].data() as Map<String, dynamic>);
                      return BooksCard(
                        book: book,
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                    child: Text("Kütüphaneye Kayıtlı bir kitap yok"));
              }
            }));
  }
}
