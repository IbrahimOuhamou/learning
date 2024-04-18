#in the name of Allah

print("in the name of Allah")

import hashlib

bismi_allah_hash = hashlib.sha256()
bismi_allah_hash.update(b"bismi_allah")
print(bismi_allah_hash.digest())

print()

print(bismi_allah_hash.hexdigest())

