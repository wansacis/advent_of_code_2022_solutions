#!/usr/bin/python3
data = open('./data', "r");
lines = data.readlines();
result = 0
result2 = 0
group = [];

def score(letter):
    if(ord(letter) <= ord('Z')):
        return ord(letter) - ord('A')+27
    else:
        return ord(letter) - ord('a')+1

for i,line in enumerate(lines):
    l = line.strip()
    itemsA = [*l[:round(len(l)/2)]]
    itemsB = [*l[round(len(l)/2):]]
    overlap = list(set(itemsA) & set(itemsB))
    for x in overlap:
        result += score(x)
    group.append([*l])
    if(i%3 == 2):
        badge = list(set(group[0]) & set(group[1]) & set(group[2]))[0]
        group = [];
        result2+=score(badge)

print(result)
print(result2)
