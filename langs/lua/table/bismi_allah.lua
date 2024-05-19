--in the name of Allah
--la ilaha illa Allah mohammed rassoul Allah

print("[lua] in the name of Allah")
print("[lua] la ilaha illa Allah mohammed rassoul Allah")

bismi_allah_table = {}
bismi_allah_table[1] = 12

bismi_allah_metatable = {}
bismi_allah_metatable.__index = function(table, key) return key end

setmetatable(bismi_allah_table, bismi_allah_metatable)

print(bismi_allah_table[1])
print(bismi_allah_table["la ilaha illa Allah"])

