import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import '../../services/comment_service.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_button.dart';

class CommentScreen extends StatefulWidget {

  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();

}

class _CommentScreenState extends State<CommentScreen> {

  final CommentService _service = CommentService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  List<CommentModel> _comments = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {

    setState(() {
      _loading = true;
    });

    final data = await _service.getComments();

    setState(() {
      _comments = data;
      _loading = false;
    });

  }

  Future<void> _submitComment() async {

    final comment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      message: _messageController.text,
      createdAt: DateTime.now(),
    );

    await _service.addComment(comment);

    _titleController.clear();
    _messageController.clear();

    _loadComments();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Feedback submitted"))
    );

  }

  Widget _commentCard(CommentModel comment){

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: const Icon(Icons.feedback),
        title: Text(comment.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.message),
            const SizedBox(height: 5),
            Text("Date: ${comment.createdAt}")
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Feedback / Bug Report"),
      ),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(

              children: [

                CustomInputField(
                  controller: _titleController,
                  label: "Title",
                ),

                const SizedBox(height: 10),

                CustomInputField(
                  controller: _messageController,
                  label: "Message",
                  maxLines: 3,
                ),

                const SizedBox(height: 10),

                CustomButton(
                  text: "Submit Comment",
                  onPressed: _submitComment,
                )

              ],

            ),
          ),

          const Divider(),

          Expanded(

            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _comments.length,
                    itemBuilder: (context,index){

                      final comment = _comments[index];

                      return _commentCard(comment);

                    },
                  ),

          )

        ],

      ),

    );

  }

}