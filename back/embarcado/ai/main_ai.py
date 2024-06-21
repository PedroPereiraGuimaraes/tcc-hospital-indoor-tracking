import sys
import os
from model_ai import get_current_room_with_model
import time
import pandas as pd


sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../..', 'api')))

# print(f"\n{sys.path}")
import pandas as pd
from src.database.repository.equipment import EquipmentDAO
from src.database.repository.room import RoomDAO


def validating_input(macList, rowValues):
    
    # List with all macs used to train the model
    all_macs = ['30:87:D9:02:FA:C8','90:3A:72:25:03:C8','B4:79:C8:05:B9:A8','90:3A:72:24:EF:E8','18:7C:0B:8D:E4:28','B4:79:C8:38:AB:18','90:3A:72:24:E9:68','18:7C:0B:8D:E3:E8','D0:4F:58:52:D2:90','B4:79:C8:45:BA:58','B4:79:C8:45:C2:D8','30:87:D9:41:4E:88','B4:79:C8:85:BA:18','20:58:69:0E:B5:78','80:BC:37:63:DF:50','30:87:D9:81:3B:38','18:7C:0B:8D:E2:88','D0:4F:58:52:D2:A0']
    
    # Create a DataFrame with all MACs, filled with zeros
    all_macs_df = pd.DataFrame(0, index=[0], columns=all_macs)

    # Create dataframe with macList and rowValues
    df = pd.DataFrame([rowValues], columns=macList)

    # Join dataframes (all_macs_df, df)
    for i in range(0, df.shape[1]):
        all_macs_df[df.columns[i]] = df.iloc[0, i]

    return all_macs_df

# Get the current room based on the model's response, and if it is different from what is stored in the database, change its value
def verify_equipment_room_on_database(new_current_room, esp_id):
    try:
        # Get current room saved in the database
        equipmentDAO = EquipmentDAO()
        equipment = equipmentDAO.get_current_room_and_date(esp_id)

        roomDAO = RoomDAO()


        # If the room is different, change data in the database
        if str(new_current_room) != str(equipment['current_room']):
            print(f"current room: {new_current_room}")
            equipmentDAO.update_historic(esp_id, equipment['current_room'], equipment['current_date'])
            equipmentDAO.update_current_room(esp_id, str(new_current_room))
            roomDAO.update_equipment_in_room(str(new_current_room), equipment['name'], equipment['patrimonio'])
        else:
            print("It didn't move")
    except Exception as e:
        print(f"Error when connecting with database: {e}")
        time.sleep(10) # wait 10 seconds
        verify_equipment_room_on_database(new_current_room, esp_id)

def check_room(keys, values, esp_id):
    input_model = validating_input(keys, values)

    # model_response -> current room based on model response
    model_response = get_current_room_with_model(input_model)
    verify_equipment_room_on_database(model_response, esp_id)

def get_data_for_training(MacList, RowsZeros):
    arquivo_csv = 'dataframe.csv'
    df = pd.read_csv(arquivo_csv)

    # Chamando a função para obter df_aux
    df_new_line = validating_input(MacList, RowsZeros)
    
    df = pd.concat([df, df_new_line], ignore_index=True)
    df.to_csv("dataframe.csv", index=False)
    print("DataFrame salvo como dataframe.csv")

def create_all_rooms():
    roomDAO = RoomDAO()

    arquivo_csv = 'back/trainingData/joinData/train_dataset.csv'
    df = pd.read_csv(arquivo_csv, usecols=['Sala'])
    print(df['Sala'].unique())
    rooms = df['Sala'].unique()
    for room in rooms:
        roomDAO.create(str(room))

# Test
# keys = ['90:3A:72:25:03:C8','30:87:D9:02:FA:C8','B4:79:C8:05:B9:A8','B4:79:C8:45:BA:58']
# values = [-61,-62,-83,-87]
# check_room(keys, values, 'ESP2')