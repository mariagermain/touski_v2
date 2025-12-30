
import 'package:touski/generated/locale_keys.g.dart';
import 'package:touski/infra/repositories/openai_repository.dart';

class GetRecipeUsecase {
  final OpenAIRepository openaiRepository;

  const GetRecipeUsecase({required this.openaiRepository});

  Future<String> execute(List<String> foods) async {
    String prompt = '${LocaleKeys.recipe_prompt} ${foods.join(', ')}';
    
    return openaiRepository.makeRequest(prompt);
  }
}
