import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/item.dart';
import '../viewmodel/item_viewmodel.dart';


class HomePage extends StatelessWidget {
  final ItemViewModel viewModel = Get.put(ItemViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter + Sqflite + GetX'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: viewModel.items.length,
          itemBuilder: (context, index) {
            final item = viewModel.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.description ?? ''),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  viewModel.deleteItem(item.id!);
                },
              ),
              onTap: () {
                // Exemplo para editar um item
                showDialog(
                  context: context,
                  builder: (context) {
                    final nameController = TextEditingController(text: item.name);
                    final descriptionController = TextEditingController(text: item.description);
                    return AlertDialog(
                      title: Text('Editar Item'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(labelText: 'Nome'),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(labelText: 'Descrição'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            viewModel.updateItem(Item(
                              id: item.id,
                              name: nameController.text,
                              description: descriptionController.text,
                            ));
                            Get.back();
                          },
                          child: Text('Salvar'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              final descriptionController = TextEditingController();
              return AlertDialog(
                title: Text('Adicionar Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Descrição'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      viewModel.addItem(nameController.text, descriptionController.text);
                      Get.back();
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
