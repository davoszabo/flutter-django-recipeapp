from rest_framework import serializers
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework import status
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password


#Serializer to Get User Details using Django Token Authentication
class UserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ["id", "username"]


#Serializer to Register User
class RegisterSerializer(serializers.ModelSerializer):
  username = serializers.CharField(
    required=True,
    validators=[UniqueValidator(queryset=User.objects.all())]
  )
  email = serializers.EmailField(
    required=True,
    validators=[UniqueValidator(queryset=User.objects.all())]
  )
  password = serializers.CharField(
    write_only=True, required=True, validators=[validate_password])
    
  class Meta:
    model = User
    fields = ('username', 'email', 'password')

  def create(self, validated_data):
    user = User.objects.create(
      username=validated_data['username'],
      email=validated_data['email'],
    )
    user.set_password(validated_data['password'])
    user.save()
    return user