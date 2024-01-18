︠7237cb18-dac2-4d1c-be3c-f367b990e9bas︠

from pulp import *
from time import *
import matplotlib.pyplot as plt

def kromaticno_stevilo(G):
    graf = [
        [
            list(range(10)),
            [(i, j) for i in G for j in G[i]]
        ]
    ]
    
    for vozlisca, povezave in graf:
        n = len(vozlisca)


        model = LpProblem(sense=LpMinimize)

        # n*n spremenljivk, x[i][k] pomeni i-to vozlisce pobarvano z k-to barvo
        spremenljivke = [
            [LpVariable(name=f"x_{i}_{j}", cat=LpBinary) for j in range(n)]
            for i in range(n)
        ]

        # se ena spremenljivka, in sicer kromaticno stevilo
        kromaticno_stevilo = LpVariable(name="chromatic number", cat='Integer')

        # vsako vozlisce ima lahko le eno barvo
        for u in range(n):
            model += lpSum(spremenljivke[u]) == 1

        # sosednji vozlisci sta razlicne barve
        for u, v in povezave:
            for k in range(n):
                model += spremenljivke[u][k] + spremenljivke[v][k] <= 1

        # kromaticno stevilo je omejeno z stevilom najvec uporabljenih barv
        for u in range(n):
            for k in range(n):
                model += kromaticno_stevilo >= (k + 1) * spremenljivke[u][k]

        # optimizacijska funkcija-minimiziranje kromaticnega stevila
        model += kromaticno_stevilo

        status = model.solve(PULP_CBC_CMD(msg=False))

        return(int(kromaticno_stevilo.value()))

def cas(func):
    zacetek = time()
    func()
    konec = time()
    cas = konec - zacetek
    return cas
        
G = graphs.KneserGraph(20,20)
kromaticno_stevilo(G)
B = G.chromatic_number()
print("k =", B)
C = G.fractional_chromatic_number()
print("k=", C)

###################################################################
# PRIMERJAVA ČASOVNE ZAHTEVNOSTI

# Koda je predstavljena na primeru za popolne grafe stopnje k
# Najprej določi stopnjo popolnega grafa k
k = 11

CLP = []
vgrajena = []

for i in range(k):
    G = graphs.CompleteGraph(i)
    
    CLP_cas = cas(lambda:kromaticno_stevilo(G))
    vgrajena_cas = cas(lambda:G.chromatic_number())

    CLP.append(round(CLP_cas,5))
    vgrajena.append(round(vgrajena_cas,5))

    
print("PRIMERJAVA ČASOVNE ZAHTEVNOSTI")

plt.plot(range(k), CLP, label='CLP')
plt.plot(range(k), vgrajena, label='Vgrajena funkcija')
plt.show()

#print(CLP)
#print(vgrajena)


######################################################################
# PRIMERJAVA KROMATIČNEGA IN FRAKCIJSKEGA KROMATIČNEGA ŠTEVILA

print("")
print("PRIMERJAVA KROMATIČNEGA IN FRAKCIJSKEGA KROMATIČNEGA ŠTEVILA")

print("")
print("CIRCULAN GRAFI [1,2]")
for i in range(3,11):
    G = graphs.CirculantGraph(i, [1,2])
    kromaticno = kromaticno_stevilo(G)
    frakcijsko = G.fractional_chromatic_number()
    print(i,":","Kromatično število:", kromaticno, ", ", "Frak. kromat. število:", round(float(frakcijsko),2))


print("")
print("CIRCULAN GRAFI [1,2,3]")
for i in range(4,11):
    G = graphs.CirculantGraph(i, [1,2,3])
    kromaticno = kromaticno_stevilo(G)
    frakcijsko = G.fractional_chromatic_number()
    print(i,":","Kromatično število:", kromaticno, ", ", "Frak. kromat. število:", round(float(frakcijsko),2))

print("")
print("CIRCULAN GRAFI [1,2,3,4]")
for i in range(5,11):
    G = graphs.CirculantGraph(i, [1,2,3,4])
    kromaticno = kromaticno_stevilo(G)
    frakcijsko = G.fractional_chromatic_number()
    print(i,":","Kromatično število:", kromaticno, ", ", "Frak. kromat. število:", round(float(frakcijsko),2))
︡935f5dc7-cdb2-4cd0-9ac4-d489270c19bc︡{"stdout":"1"}︡{"stdout":"\n"}︡{"stdout":"k = 1\n"}︡{"stdout":"k= 1\n"}︡{"stdout":"PRIMERJAVA ČASOVNE ZAHTEVNOSTI\n"}︡{"stdout":"[<matplotlib.lines.Line2D object at 0x7ff929c8a890>]\n"}︡{"stdout":"[<matplotlib.lines.Line2D object at 0x7ff921a2bf50>]\n"}︡{"file":{"filename":"31c8a9d2-19a7-4ddb-a772-e55737180ebc.svg","show":true,"text":null,"uuid":"a2c7bed7-5b11-493e-ab21-6e3431a7d407"},"once":false}︡{"stdout":"\n"}︡{"stdout":"PRIMERJAVA KROMATIČNEGA IN FRAKCIJSKEGA KROMATIČNEGA ŠTEVILA\n"}︡{"stdout":"\n"}︡{"stdout":"CIRCULAN GRAFI [1,2]\n"}︡{"stdout":"3"}︡{"stdout":" : Kromatično število: 3 ,  Frak. kromat. število: 3.0\n4"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 4.0\n5"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 5.0\n6"}︡{"stdout":" : Kromatično število: 3 ,  Frak. kromat. število: 3.0\n7"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 3.5\n8"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 4.0\n9"}︡{"stdout":" : Kromatično število: 3 ,  Frak. kromat. število: 3.0\n10"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 3.33\n"}︡{"stdout":"\n"}︡{"stdout":"CIRCULAN GRAFI [1,2,3]\n"}︡{"stdout":"4"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 4.0\n5"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 5.0\n6"}︡{"stdout":" : Kromatično število: 6 ,  Frak. kromat. število: 6.0\n7"}︡{"stdout":" : Kromatično število: 7 ,  Frak. kromat. število: 7.0\n8"}︡{"stdout":" : Kromatično število: 4 ,  Frak. kromat. število: 4.0\n9"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 4.5\n10"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 5.0\n"}︡{"stdout":"\n"}︡{"stdout":"CIRCULAN GRAFI [1,2,3,4]\n"}︡{"stdout":"5"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 5.0\n6"}︡{"stdout":" : Kromatično število: 6 ,  Frak. kromat. število: 6.0\n7"}︡{"stdout":" : Kromatično število: 7 ,  Frak. kromat. število: 7.0\n8"}︡{"stdout":" : Kromatično število: 8 ,  Frak. kromat. število: 8.0\n9"}︡{"stdout":" : Kromatično število: 9 ,  Frak. kromat. število: 9.0\n10"}︡{"stdout":" : Kromatično število: 5 ,  Frak. kromat. število: 5.0\n"}︡{"done":true}









