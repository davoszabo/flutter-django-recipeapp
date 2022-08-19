import profile
from rest_framework import viewsets, permissions, views
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend

from .filters import RecipeFilter
from .models import Recipe, Profile
from .serializers import RecipeListSerializer, RecipeDetailSerializer

# from rest_framework import permissions

class RecipeViewSet(viewsets.ViewSet):
    """
    A simple ViewSet for listing or retrieving cuisines.
    """

    def list(self, request):
        #queryset = Recipe.objects.all().order_by('?')[:10]
        #queryset = Recipe.objects.all()#.order_by('?')[:10]
        print(request.GET)
        filter_query = RecipeFilter(request.GET, queryset=Recipe.objects.all().order_by("?"))
        serializer = RecipeListSerializer(filter_query.qs[:10], many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None):
        queryset = Recipe.objects.all()
        recipe = get_object_or_404(queryset, pk=pk)
        serializer = RecipeDetailSerializer(recipe)
        return Response(serializer.data)


# class CuisineViewSet(viewsets.ViewSet):
#     """
#     A simple ViewSet for listing or retrieving cuisines.
#     """
#     def list(self, request):
#         queryset = Cuisine.objects.all().order_by('?')[:10]
#         serializer = CuisineListSerializer(queryset, many=True)
#         return Response(serializer.data)

#     def retrieve(self, request, pk=None):
#         queryset = Cuisine.objects.all()
#         cuisine = get_object_or_404(queryset, pk=pk)
#         serializer = CuisineDetailSerializer(cuisine)
#         return Response(serializer.data)

# class CuisineViewSet(viewsets.ReadOnlyModelViewSet):
#    queryset = Cuisine.objects.all().order_by('?')
#    serializer_class = CuisineSerializer
   # permission_classes = [permissions.IsAuthenticatedOrReadOnly]

class ToggleFavoriteView(views.APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, recipe_id):
        profile = Profile.objects.get(pk=request.user)
        
        if profile.favorites.filter(pk=recipe_id).exists():                                                              
            profile.favorites.remove(recipe_id)
        else:           
            profile.favorites.add(recipe_id)
        return Response({"msg":"Toggling favorite done."})

class FavoriteListView(viewsets.ViewSet):

    permission_classes = [permissions.IsAuthenticated]

    def list(self, request):
        profile = Profile.objects.get(pk=request.user)
        queryset = profile.favorites.all()
        serializer = RecipeListSerializer(queryset, many=True)
        return Response(serializer.data)