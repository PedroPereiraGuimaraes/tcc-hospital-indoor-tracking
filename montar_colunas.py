import pandas as pd

mac_conhecidos = [
    '30:87:D9:02:FA:C8',
    '30:87:D9:02:FE:08',
    'B4:79:C8:05:B9:38',
    'B4:79:C8:05:B9:A8',
    'B4:79:C8:05:C2:38',
    'B4:79:C8:05:C2:78',
    'B4:79:C8:38:B1:C8',
    'B4:79:C8:38:C0:B8',
    'B4:79:C8:39:31:28',
    '30:87:D9:42:FA:C8',
    '6C:14:6E:3E:DB:50',
    '6C:14:6E:3E:DF:10',
    '6C:14:6E:3E:DB:52',
    '6C:14:6E:3E:DE:71',
    '6C:14:6E:3E:DE:72',
    'B4:79:C8:45:C2:38',
    'B4:79:C8:45:C2:78',
    'B4:79:C8:78:B1:C8',
    'E8:1D:A8:30:F1:E8'
]

df = pd.DataFrame(columns = mac_conhecidos)



mac_recebido = None

if(mac_recebido in mac_conhecidos):
    df.append(linha)