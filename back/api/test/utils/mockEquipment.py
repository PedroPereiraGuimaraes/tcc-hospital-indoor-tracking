from datetime import datetime

def valid_create_equipment():
    return {"name": "string",
            "patrimonio": "string",
            "maintenance": False
        }

def valid_update_equipment():
    return {"name": "string2",
            "patrimonio": "string",
            "last_maintenance": "2024-06-21T23:01:50.526Z",
            "next_maintenance": "2024-06-21T23:01:50.526Z"
        }

def valid_update_equipment_fail():
    return {"name": "string2",
            "patrimonio": "string2",
            "last_maintenance": "2024-06-21T23:01:50.526Z",
            "next_maintenance": "2024-06-21T23:01:50.526Z"
        }

# def valid_maintenante_equipment_update():
#     return {"patrimonio": "string",
#             "maintenance": False
#         }

# def valid_maintenante_equipment_update_fail():
#     return {"patrimonio": "string2",
#             "maintenance": False
#         }