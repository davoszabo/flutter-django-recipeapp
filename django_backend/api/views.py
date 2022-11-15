import profile
from rest_framework import viewsets, permissions, views
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from django_filters.rest_framework import DjangoFilterBackend

from .filters import RecipeFilter
from .models import Recipe, Profile
from .serializers import RecipeListSerializer, RecipeDetailSerializer

import sys
sys.path.append('../')

from recsys.recrecsys import RecRecSys  
from django.db.models import Case, When

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
        serializer = RecipeListSerializer(filter_query.qs[:100], many=True)
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

recsys_model = RecRecSys()

class RecommendListView(viewsets.ViewSet):

    permission_classes = [permissions.IsAuthenticated]

    def list(self, request):
        
        # rec_list = recsys_model.fit(request.user)
        rec_system = request.GET.get('recSys')
        print(rec_system)

        user_id = request.user.id
        base_id = 1853000000
        rec_id = user_id + base_id
        print("[RecommendListView::list] requester user ID: ", user_id)
        #print("[RecommendListView::list] is user ID in training set: ", recsys_model.trainset_contains(rec_id))

        #rec_id = 2312

        profile = Profile.objects.get(pk=request.user)
        liked_recipes_list = list(profile.favorites.values_list('pk', flat=True))
        print("[RecommendListView::list] the user favorite recipe IDs: ", liked_recipes_list)
        
        # if(not recsys_model.trainset_contains(rec_id)):
        #     recsys_model.train(rec_id, liked_recipes_list)
        recsys_model.train(rec_id, liked_recipes_list, rec_system)
        

        # rec_list = recsys_model.fit_knn(rec_id)
        if rec_system == "SVD":
            rec_list = recsys_model.fit_svd(rec_id)
        elif rec_system == "KNN":
            rec_list = recsys_model.fit_knn(rec_id)

        
        
        preserved = Case(*[When(pk=pk, then=pos) for pos, pk in enumerate(rec_list)])
        queryset = Recipe.objects.filter(pk__in=rec_list).order_by(preserved)
        serializer = RecipeListSerializer(queryset, many=True)
        return Response(serializer.data)