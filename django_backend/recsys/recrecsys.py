from ast import Try
import pandas as pd
import numpy as np
import pickle
from surprise import Dataset
from surprise import Reader
from surprise import SVD, KNNBasic

path = '/usr/src/app/recsys/'

class RecRecSys:
    def __init__(self):
        # self.recipe_ratings = pd.read_pickle('refined_recipes_2_sample_main.pkl')
        self.trainset = pickle.load(open(f'{path}trainset.pkl', 'rb'))
        self.rec_model = pickle.load(open(f'{path}recrecsys.pkl', 'rb'))
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

    def fit_svd(self, raw_user_id, top_n=10):
        self.make_anti_testset(raw_user_id)

        predictions = self.rec_model.test(self.anti_testset)

        pred = pd.DataFrame(predictions)
        pred.sort_values(by=['est'], inplace=True, ascending=False)

        recipe_list = pred.head(top_n)['iid'].to_list()

        print("[recrecsys::fit_svd] Recommended IDs represented as a list.", recipe_list)
        
        return recipe_list

    def fit_knn(self, raw_user_id, top_n=10):
        self.make_anti_testset(raw_user_id)

        predictions = self.rec_model.test(self.anti_testset)

        pred = pd.DataFrame(predictions)
        pred = pred.loc[pred["est"] == 5]
        pred = pd.concat([pred, pred['details'].apply(pd.Series)], axis = 1).drop('details', axis = 1)
        pred.sort_values(by=['actual_k'], inplace=True, ascending=False)

        recipe_list = pred.head(top_n)['iid'].to_list()
        
        print("[recrecsys::fit_knn] Recommended IDs represented as a list.", recipe_list)
        
        return recipe_list

    def train(self, rec_id, liked_recipes_list, rec_system):
        print("[recrecsys::train] Model is being retrained with the new user.")
        #rec_base_id = 1853000000 
        #rec_id = rec_base_id + raw_user_id

        df_new_user = pd.DataFrame({"User": rec_id, "Item": liked_recipes_list, "Rating": 5})
        df_recipe_ratings = pd.read_pickle(f'{path}recipe_ratings.pkl')

        # print(df_recipe_ratings)
        # df.drop(df.loc[df['line_race']==0].index, inplace=True)

        df_concat = pd.concat([df_recipe_ratings, df_new_user], sort=False, ignore_index=True)

        reader = Reader(rating_scale=(0, 5))
        #data = Dataset.load_from_df(df_recipe_ratings, reader)
        data = Dataset.load_from_df(df_concat, reader)

        self.trainset = data.build_full_trainset()
        
        # pickle.dump(train_set, open('trainset.pkl', 'wb'))
           
        algo = SVD(n_factors=100, n_epochs=25, lr_all=0.005, reg_all=0.1) if rec_system == "SVD" else KNNBasic(sim_options = {"name":"pearson", "user_based":False})
        algo.fit(self.trainset)
        self.rec_model = algo
        # pickle.dump(algo, open('recrecsys.pkl', 'wb'))

    def trainset_contains(self, raw_user_id):
        try:
            self.trainset.to_inner_uid(raw_user_id)
            return True
        except:
            print("[recrecsys::trainset_contains] Item is not part of the trainset.")
            return False

