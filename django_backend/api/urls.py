from django.urls import include, path

from rest_framework import routers

from .views import RecipeViewSet, ToggleFavoriteView, FavoriteListView

router = routers.DefaultRouter()
router.register(r'recipes', RecipeViewSet, basename='recipe')
router.register(r'favorites', FavoriteListView, basename='favorite')

urlpatterns = [
   path('', include(router.urls)),
   path('auth/', include('authentication.urls')),
   path('togglefav/<int:recipe_id>', ToggleFavoriteView.as_view(), name='togglefav'),
]