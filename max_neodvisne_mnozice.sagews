︠97bee36e-86aa-4615-b361-2c274d637702s︠
def neodvisna(graf, mnozica):
    for u in mnozica:
        for v in graf[u]:
            if v in mnozica:
                return False
    return True

def vse_neodvisne(graf, mnozica, vozlisca, vse_mnozice):
    if neodvisna(graf, mnozica):
        vse_mnozice.append(mnozica.copy())

    for u in vozlisca:
        vse_neodvisne(graf, mnozica + [u], [v for v in vozlisca if v != u], vse_mnozice)

def maksimalne(seznam):
    n = max(len(i) for i in seznam)

    najvecje_mnozice = [i for i in seznam if len(i) == n]

    unikati = list({tuple(sorted(i)) for i in najvecje_mnozice})
    vse_najvecje = [set(i) for i in unikati]
    return vse_najvecje

def vse_max_neodvisne(graf):
    vse_mnozice = []
    vse_neodvisne(graf, [], list(graf.keys()), vse_mnozice)
    vse_max_mnozice = maksimalne(vse_mnozice)
    return vse_max_mnozice

############################################################################
#ISKANJE VSEH MAKSIMALNIH NEODVISNIH MNOŽIC VOZLIŠČ

G = graphs.RandomRegular(3, 8).to_dictionary()

print("ISKANJE VSEH MAKSIMALNIH NEODVISNIH MNOŽIC VOZLIŠČ")
graphs.RandomRegular(3, 8).show()
print("Velikost največje množice vozlišč:", len(vse_max_neodvisne(G)[0]))
print("Vse maksimalne množice vozlišč:", vse_max_neodvisne(G))



︡d68449ff-f2d5-4867-b0bc-28d2a8486d93︡{"stdout":"ISKANJE VSEH MAKSIMALNIH NEODVISNIH MNOŽIC VOZLIŠČ\n"}︡{"file":{"filename":"/tmp/tmp1n93p_3a/tmp_7i79s3br.svg","show":true,"text":null,"uuid":"f1783563-3b25-42a8-b5ed-044a39c90fec"},"once":false}︡{"stdout":"Velikost največje množice vozlišč:"}︡{"stdout":" 3\n"}︡{"stdout":"Vse maksimalne množice vozlišč:"}︡{"stdout":" [{2, 4, 5}, {0, 1, 7}, {4, 5, 7}, {0, 1, 3}, {0, 3, 6}, {2, 5, 6}]\n"}︡{"done":true}









