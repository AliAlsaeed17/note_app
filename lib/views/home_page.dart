//@dart=2.8
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/widgets/alert_dialog.dart';
import 'package:note_app/widgets/search_bar.dart';

import 'add_new_note_page.dart';
import 'note_detail_page.dart';


class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  Widget emptyNotes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/note.json'),
          const SizedBox(height: 50,),
          const Text(
            "You don't have any Notes",style: TextStyle(
            fontSize: 30,fontWeight: FontWeight.bold
          ),
          ),
        ],

    );
  }

  Widget viewNotes() {
    return Scrollbar(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child:StaggeredGridView.countBuilder(
            itemCount: controller.notes.length,
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 20.0,


            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //todo go to other page with index
                  Get.to(
                    NoteDetailPage(),
                    arguments: index,
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NoteAlertDialog(
                        contentText: "Are you sure you want to delete the note?",
                        confirmFunction: () {
                          controller.deleteNote(controller.notes[index].id);
                          Get.back();
                        },
                        declineFunction: () {
                          Get.back();
                        },
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //todo add note(title) from index
                        controller.notes[index].title,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        //todo add note(content) from index
                        controller.notes[index].content,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        //todo add note(date time) from index
                        controller.notes[index].dateTimeEdited,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        brightness: Brightness.light,


        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return NoteAlertDialog(
                      contentText: "Are you sure you want to delete all notes?",
                      confirmFunction: () {
                        controller.deleteAllNotes();
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>AddNewNotePage());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
