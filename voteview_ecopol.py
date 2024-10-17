import os
import requests
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Economía Política 2023 - FCE UNC - Córdoba, Argentina #

directory = "/Users/stefa/Documents/Code/Voteview_Plots/"  # Workspace
os.chdir(directory)
if not os.path.exists("Graphs"):
    os.makedirs("Graphs")

##############################################################################################################
############################ IMPACTOS DE GUERRAS SOBRE VOTOS LEGISLATIVOS EN DEFENSA ####################################
##############################################################################################################

# Clausen category:
#  5.  Foreign and Defense Policy 
# International policy; foreign aid; aid to international 
# organizations; armament policy; defense procurement; international 
# trade; military pensions; etc. 

## 1939 - 1945: SEGUNDA GUERRA MUNDIAL #######################################################################
## 1944: Acuerdo de Bretton Woods ############################################################################
## 1948: Estado de Israel. Comienza el conflicto árabe-israelí.########################

def voteview_search(query, startdate, enddate):
    print(f"Searching for: {query} from {startdate} to {enddate}")
    return {"id": 1, "results": "Simulated results"}

def voteview_download(id):
    print(f"Downloading data with id: {id}")
    data = {"legis_long_dynamic": pd.DataFrame({
                "name": ["John Doe", "Jane Smith"],
                "icpsr": [1001, 1002],
                "dim1": [0.5, -0.3],
                "dim2": [0.4, -0.2]}),
            "legis_data": pd.DataFrame({
                "dim1": [0.5, -0.3],
                "dim2": [0.4, -0.2]})
            }
    return data

print("tranqui tarda un poco, prepara el mate")
res_pre2GM = voteview_search("Foreign and Defense Policy", "1935-01-20", "1939-01-20")
res_dur2GM = voteview_search("Foreign and Defense Policy", "1940-01-20", "1945-01-20")
res_post2GM = voteview_search("Foreign and Defense Policy", "1946-01-20", "1950-01-20")

rc_pre2GM = voteview_download(res_pre2GM['id'])
rc_dur2GM = voteview_download(res_dur2GM['id'])
rc_post2GM = voteview_download(res_post2GM['id'])

# polarity
def get_extremes(data):
    cons1 = data['legis_long_dynamic'].loc[data['legis_data']['dim1'].idxmax()]
    cons2 = data['legis_long_dynamic'].loc[data['legis_data']['dim2'].idxmax()]
    return cons1, cons2

cons1_pre2GM, cons2_pre2GM = get_extremes(rc_pre2GM)
cons1_dur2GM, cons2_dur2GM = get_extremes(rc_dur2GM)
cons1_post2GM, cons2_post2GM = get_extremes(rc_post2GM)

# party names party codes
def add_party_names(df):
    df['party'] = [200, 100] 
    df['partyName'] = df['party'].apply(lambda x: 'Republican' if x == 200 else 'Democrat' if x == 100 else 'Independent')
    return df

# Plot
def create_graph(data, title, filename):
    sns.set(style="whitegrid")
    plt.figure(figsize=(8, 6))
    sns.scatterplot(x='dim1', y='dim2', hue='partyName', data=data)
    plt.title(title, fontsize=14)
    plt.xlabel("Economics", fontsize=12)
    plt.ylabel("Social", fontsize=12)
    plt.savefig(f"Graphs/{filename}.jpg", dpi=300)
    plt.show()

rc_pre2GM = add_party_names(rc_pre2GM['legis_long_dynamic'])
rc_dur2GM = add_party_names(rc_dur2GM['legis_long_dynamic'])
rc_post2GM = add_party_names(rc_post2GM['legis_long_dynamic'])

create_graph(rc_pre2GM, "Previo a la 2GM", "pre_2GM")
create_graph(rc_dur2GM, "Durante la 2GM", "dur_2GM")
create_graph(rc_post2GM, "Luego de la 2GM", "post_2GM")

##############################################################################################################
## GUERRA DE VIETNAM: EE.UU ingresa en 1965 #################################################################
## Contexto de Guerra Fría: EEUU vs URSS. Carrera económica, espacial y armamentística #######################
## Continúa el conflicto árabe-israelí ######################################################################
## 1961: Construcción Muro de Berlín ########################################################################
## 1963: Asesinato de John F. Kennedy #######################################################################
## 1966: Comienza la revolución cultural en China ###########################################################
## 1969: Llegada a la Luna ##################################################################################

print("tarda bastante, chequeate como va el Merval y leete unos twitts")
res_preV = voteview_search("Foreign and Defense Policy", "1955-01-20", "1964-01-20")
res_postV = voteview_search("Foreign and Defense Policy", "1965-01-20", "1975-01-20")
res_durV = voteview_search("Foreign and Defense Policy", "1976-01-20", "1985-01-20")

rc_preV = voteview_download(res_preV['id'])
rc_postV = voteview_download(res_postV['id'])
rc_durV = voteview_download(res_durV['id'])

rc_preV = add_party_names(rc_preV['legis_long_dynamic'])
rc_postV = add_party_names(rc_postV['legis_long_dynamic'])
rc_durV = add_party_names(rc_durV['legis_long_dynamic'])

create_graph(rc_preV, "Previo a la Guerra de Vietnam", "pre_V")
create_graph(rc_durV, "Durante la Guerra de Vietnam", "dur_V")
create_graph(rc_postV, "Luego de la Guerra de Vietnam", "post_V")

##############################################################################################################
## INVASION DE AFGANISTAN (2001) #############################################################################
## 1998: atentados en las embajadas de EEUU en Tanzania y Kenia ##############################################
## 2000: bomba en Yemen contra intereses de EEUU.#############################################################
## 2001: Ataque a las Torres Gemelas #########################################################################
## 2003: Invasión de Irak ####################################################################################

print("tranqui tarda un poco, buscate info de la bomba en Yemen del 2000")
res_preA = voteview_search("Foreign and Defense Policy", "1995-01-20", "2000-01-20")
res_postA = voteview_search("Foreign and Defense Policy", "2001-01-20", "2005-01-20")

rc_preA = voteview_download(res_preA['id'])
rc_postA = voteview_download(res_postA['id'])

rc_preA = add_party_names(rc_preA['legis_long_dynamic'])
rc_postA = add_party_names(rc_postA['legis_long_dynamic'])

create_graph(rc_preA, "Previo a la invasión de Afganistan", "pre_A")
create_graph(rc_postA, "Luego de la invasión de Afganistan", "post_A")

##############################################################################################################
##############################################################################################################
##############################################################################################################

# Testing OTHER CLAUSEN CATEGORIES

#  1.  Government Management 
# Environmental control; government regulation of business; 
# natural resource management; government ownership of business; 
# government control of the economy; budget balancing; tax policy; 
# interest rates; management of the bureaucracy; etc.

res1 = voteview_search("Government Management", "1940-01-20", "1950-01-20")
rc1 = voteview_download(res1['id'])

rc1 = add_party_names(rc1['legis_long_dynamic'])
create_graph(rc1, "Government Management", "gov_mgmt")

#  2.  Social Welfare 
# Social security; public housing; urban renewal; labor 
# regulation; education; urban affairs; employment opportunities and 
# rewards; welfare; medicare; unemployment; minimum wage; legal 
# services; immigration, etc.

res2 = voteview_search("Social Welfare", "1935-01-20", "2008-01-20")
rc2 = voteview_download(res2['id'])

#  3.  Agriculture 
# Price supports and subsidies; commodity control; acreage 
# limitations; etc.

res3 = voteview_search("Agriculture", "1935-01-20", "2008-01-20")
rc3 = voteview_download(res3['id'])

#  4.  Civil Liberties 
# Civil rights; equality; criminal procedure; privacy; 
# guarantees of the Bill of Rights; slavery; Hatch Act; etc.

res4 = voteview_search("Civil Liberties", "1935-01-20", "2008-01-20")
rc4 = voteview_download(res4['id'])

#  6.  Miscellaneous Policy 
# Unclassifiable or unidentifiable votes; all votes concerned 
# with internal organization of Congress; procedural motions.

res6 = voteview_search("Miscellaneous Policy", "1935-01-20", "2008-01-20")
rc6 = voteview_download(res6['id'])





# Economía Política, 2023 - FCE UNC - Córdoba, Argentina #
# Stefano Balbo #