import pandas as pd
import numpy as np
import pickle
from surprise import Dataset
from surprise import Reader

class RecRecSys:
    def __init__(self):
        # self.recipe_ratings = pd.read_pickle('refined_recipes_2_sample_main.pkl')
        self.trainset = pickle.load(open('/usr/src/app/recsys/trainset.pkl', 'rb'))
        self.svd_model = pickle.load(open('/usr/src/app/recsys/recrecsys.pkl', 'rb'))
        self.anti_testset = []

    def make_anti_testset(self, raw_user_id):
        anti_testset_user = []
        
        targetUser = self.trainset.to_inner_uid(raw_user_id)
        
        fillValue = self.trainset.global_mean
        
        user_item_ratings = self.trainset.ur[targetUser]
        user_items = [item for (item,_) in (user_item_ratings)]
        
        for iid in self.trainset.all_items():
            if(iid not in user_items):
                anti_testset_user.append((self.trainset.to_raw_uid(targetUser),self.trainset.to_raw_iid(iid),fillValue))

        self.anti_testset = anti_testset_user
        # return anti_testset_user

    def fit(self, raw_user_id, top_n=10):
        self.make_anti_testset(raw_user_id)

        predictions = self.svd_model.test(self.anti_testset)

        pred = pd.DataFrame(predictions)
        pred.sort_values(by=['est'], inplace=True, ascending=False)

        recipe_list = pred.head(top_n)['iid'].to_list()

        print(recipe_list)
        
        return recipe_list