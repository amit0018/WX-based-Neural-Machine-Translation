#Code to convert WX to UTF (Generated sentences)
from wxconv import WXC

con = WXC(order='wx2utf', lang="hin")

print("Reading lines...")

# Read the file and split into lines
lines = open(r'hyp', encoding='utf-8').\
        read().strip().split('\n')
pairs = [con.convert(p) for p in lines]

with open(r'\path_of_de-transliterated_generated_data', 'w', encoding="utf-8") as f:
    for item in pairs:
        f.write("%s\n" % item)
f.close()