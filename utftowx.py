!pip install wxconv

#Code to convert UTF to WX

from wxconv import WXC

con = WXC(order='utf2wx', lang="nep")

print("Reading lines...")

# Read the file and split into lines
lines = open(r'\path_of_data', encoding='utf-8').\
        read().strip().split('\n')
pairs = [con.convert(p) for p in lines]

with open(r'\path_of_transliterated_data', 'w', encoding="utf-8") as f:
    for item in pairs:
        f.write("%s\n" % item)
f.close()