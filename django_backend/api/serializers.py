from rest_framework import serializers

from .models import Recipe

class RecipeListSerializer(serializers.ModelSerializer):
   class Meta:
       model = Recipe
       fields = ('id', 'name', 'submitted', 'search_terms', 'image_url', 'minutes', 'rating', 'review_count')

class RecipeDetailSerializer(serializers.ModelSerializer):
   class Meta:
       model = Recipe
       fields = '__all__' 
       #('id', 'name', 'description', 'ingredients', 'ingredients_raw_str', 'serving_size', 'servings', 'steps', 'tags', 'search_terms', 'author_id', 'author_name', 'submitted', 'image_url', 'minutes', 'category', 'calories', 'n_steps', 'n_ingredients', 'nutrition', 'rating', 'review_count')

# id = models.AutoField(primary_key=True)
#     name = models.CharField(max_length=250)
#     description = models.TextField(null=True)
#     ingredients = ArrayField(models.CharField(max_length=100))
#     ingredients_raw_str = ArrayField(models.TextField())
#     serving_size = models.CharField(max_length=15)
#     servings = models.IntegerField()
#     steps = ArrayField(models.TextField())
#     tags = ArrayField(models.CharField(max_length=30))
#     search_terms = ArrayField(models.CharField(max_length=30))
#     author_id = models.IntegerField()
#     author_name = models.CharField(max_length=30)
#     submitted = models.DateField()
#     image_url = models.CharField(max_length=250, null=True)
#     minutes = models.IntegerField()
#     category = models.CharField(max_length=30, null=True)
#     calories = models.DecimalField(max_digits=7, decimal_places=1)
#     n_steps = models.IntegerField()
#     n_ingredients = models.IntegerField()
#     nutrition = ArrayField(models.DecimalField(max_digits=7, decimal_places=1))
#     rating = models.DecimalField(null=True, max_digits=2, decimal_places=1)
#     review_count = models.IntegerField(null=True)
# class DynamicFieldsCuisineSerializer(serializers.ModelSerializer):
#     def __init__(self, *args, **kwargs):
#         # Don't pass the 'fields' arg up to the superclass
#         fields = kwargs.pop('fields', None)

#         # Instantiate the superclass normally
#         super().__init__(*args, **kwargs)

#         if fields is not None:
#             # Drop any fields that are not specified in the `fields` argument.
#             allowed = set(fields)
#             existing = set(self.fields)
#             for field_name in existing - allowed:
#                 self.fields.pop(field_name)

# class CuisineListSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = Cuisine
#        fields = ('id', 'name', 'image_url')

# class CuisineDetailSerializer(serializers.ModelSerializer):
#    class Meta:
#        model = Cuisine
#        fields = ('id', 'name', 'image_url', 'description', 'cuisine', 'course', 'diet', 'prep_time', 'instructions', 'image_available')


