from django.urls import path
from .views import CustomObtainAuthToken, UserDetailAPI, RegisterUserAPIView

urlpatterns = [
  path("get-details", UserDetailAPI.as_view()),
  path('register', RegisterUserAPIView.as_view()),
  path('authenticate', CustomObtainAuthToken.as_view()),
]