import 'package:flutter/material.dart';

class AssistantEvaluation extends StatefulWidget {
  const AssistantEvaluation({super.key});

  @override
  State<AssistantEvaluation> createState() => _AssistantEvaluationState();
}

class _AssistantEvaluationState extends State<AssistantEvaluation> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _submitEvaluation() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء اختيار تقييم قبل الإرسال")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ تم إرسال التقييم بنجاح")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقييم المساعد"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ما رأيك في أداء المساعد؟",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: index < _rating ? Colors.amber : Colors.grey,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),

            const SizedBox(height: 20),
            Text(
              "التقييم: ${_rating.toInt()} / 5",
              style: const TextStyle(fontSize: 18, color: Colors.teal),
            ),

            const SizedBox(height: 25),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "أضف تعليقك (اختياري)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("إرسال التقييم"),
              onPressed: _submitEvaluation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
