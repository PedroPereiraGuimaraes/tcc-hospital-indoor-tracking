def valid_create_equipment():
    return {"name": "string",
            "patrimonio": "string",
            "maintenance": False
        }

def valid_update_equipment():
    return {"name": "string2",
            "patrimonio": "string",
            "maintenance": False
        }

def valid_maintenante_equipment_update():
    return {"patrimonio": "string",
            "maintenance": True
        }