from re import search
import django_filters
from django.db.models import Q

from .models import Recipe

class RecipeFilter(django_filters.FilterSet):

    #tags = django_filters.CharFilter(lookup_expr='icontains')
    tags = django_filters.CharFilter(label="tags", method='tags_filter')

    search = django_filters.CharFilter(label="search", method='search_filter')

    def tags_filter(self, queryset, name, value):
        print(value)
        q_list = Q()
        for q in value.split(' '):
            q_list &= (Q(tags__icontains=q))
        filtered_list = queryset.filter(q_list)
        return filtered_list

    def search_filter(self, queryset, name, value):
        # print(name)
        filtered = queryset.filter(Q(name__icontains=value) | Q(description__icontains=value) | Q(ingredients__icontains=value))
        return filtered

    class Meta:
        model = Recipe
        fields = ["tags", "search"]