︠95e86257-01b9-49ff-8d44-d074ec12d80e︠
from time import *
from pulp import *
import matplotlib.pyplot as plt

def klicno_stevilo(graf):
    # Ustvari CLP
    CLP = LpProblem("klicno_stevilo_CLP", LpMaximize)

    # Ustvarimo binarno spremenljivko, ki nam pove ali je vozlišče v kliki ali ne
    vozlisca = list(graf.keys())
    x = {i: LpVariable(f"x_{i}", cat=LpBinary) for i in vozlisca}

    # Maksimizacijska funkcija
    CLP += lpSum(x.values())

    # Pogoj: vozlišči, ki nista povezani ne moreta biti obe v kliki
    for i in vozlisca:
        for j in vozlisca:
            if i < j and j not in graf[i]:
                CLP += x[i] + x[j] <= 1

    # Rešimo CLP
    CLP.solve()

    # Izpišemo rešitev
    klika = [i for i in vozlisca if value(x[i]) == 1]

    return len(klika)

def cas(func):
    zacetek = time()
    func()
    konec = time()
    cas = konec - zacetek
    return cas


###################################################################
# PRIMERJAVA ČASOVNE ZAHTEVNOSTI

# Koda je predstavljena na primeru za popolne grafe stopnje k
# Najprej določi stopnjo popolnega grafa k
k = 40

CLP = []
vgrajena = []

for i in range(3,k):
    G = graphs.CirculantGraph(i,[1,2])
    
    CLP_cas = cas(lambda:klicno_stevilo(G.to_dictionary()))
    vgrajena_cas = cas(lambda:G.clique_number())

    CLP.append(round(CLP_cas,5))
    vgrajena.append(round(vgrajena_cas,5))

    
print("PRIMERJAVA ČASOVNE ZAHTEVNOSTI")

plt.plot(range(3,k), CLP, label='CLP')
plt.plot(range(3,k), vgrajena, label='Vgrajena funkcija')
plt.show()

#print(CLP)
#print(vgrajena)


######################################################################
# PRIMERJAVA KLIČNEGA IN FRAKCIJSKEGA KLIČNEGA ŠTEVILA

print("")
print("PRIMERJAVA KLIČNEGA IN FRAKCIJSKEGA KLIČNEGA ŠTEVILA")

print("")
print("CIRCULAN GRAFI [1,2]")
for i in range(3,20):
    G = graphs.CirculantGraph(i, [1,2])
    klicno = klicno_stevilo(G.to_dictionary())
    frakcijsko = G.fractional_clique_number()
    print(i,":","Klično število:", klicno, ", ", "Frakcijsko klično število:", round(float(frakcijsko),2))


print("")
print("CIRCULAN GRAFI [1,2,3]")
for i in range(4,20):
    G = graphs.CirculantGraph(i, [1,2,3])
    klicno = klicno_stevilo(G.to_dictionary())
    frakcijsko = G.fractional_clique_number()
    print(i,":","Klično število:", klicno, ", ", "Frakcijsko klično število:", round(float(frakcijsko),2))

print("")
print("CIRCULAN GRAFI [1,2,3,4]")
for i in range(5,20):
    G = graphs.CirculantGraph(i, [1,2,3,4])
    klicno = klicno_stevilo(G.to_dictionary())
    frakcijsko = G.fractional_clique_number()
    print(i,":","Klično število:", klicno, ", ", "Frakcijsko klično število:", round(float(frakcijsko),2))









