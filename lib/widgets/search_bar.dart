//@dart=2.8
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/views/note_detail_page.dart';

class SearchBar extends SearchDelegate {
  NoteController noteController = Get.find<NoteController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){query = "";}, icon: const Icon(Icons.clear),),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {Get.back();},
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,),);
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggetionsList = query.isEmpty ? noteController.notes :
        noteController.notes.where((p) {
          return p.title.toLowerCase().contains(query.toLowerCase())
                 || p.content.toLowerCase().contains(query.toLowerCase());
        }).toList();
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: StaggeredGridView.countBuilder(
        itemCount: suggetionsList.length,
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        itemBuilder: (count, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                NoteDetailPage(),
                arguments: index,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(10,10),
                    blurRadius: 15
                  )
                ]
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggetionsList[index].title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(height: 10.0,),
                  Text(
                    suggetionsList[index].content,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                    maxLines: 6,
                  ),
                  const SizedBox(height: 10.0,),
                  Text(suggetionsList[index].dateTimeEdited),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
}