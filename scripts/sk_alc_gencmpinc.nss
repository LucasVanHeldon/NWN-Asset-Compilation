string GenerateAlchemyComponentOnObject(object oObj)
{

/*
1   Betula alleghaniensis       10  20
2   Campsis radicans            10  30
3   Carya ovata                 2   75
4   Cercis canadensis           20  30
5   Cornus mas                  30  15
6   Fraxinus americana          30  10
7   Fraxinus nigra              40  10
8   Fraxinus pennsylvanica      35  15
9   Gleditsia triacanthos       2   70
10  Gymnocladus dioicus         70  10
11  Hamamelis virginiana        200 10
12  Nyssa sylvatica             3   45
13  Parthenocissus quinquefolia 20  10
14  Pinus strobus
15  Populus balsamifera         80  15
16  Prunus serotina             150 15
17  Quercus macrocarpa          700 5
18  Taxodium distichum          30  10
19  Toxicodendron radicans      100 20
20  Ulmus americana

                                SUM 415
*/

    string sItem = "acomp_";
    string sNum = "000";
    int nRand = Random(385);

    if(0>(nRand-=20)){
        sNum = "001";
    }else
    if(0>(nRand-=30)){
        sNum = "002";
    }else
    if(0>(nRand-=75)){
        sNum = "003";
    }else
    if(0>(nRand-=30)){
        sNum = "004";
    }else
    if(0>(nRand-=15)){
        sNum = "005";
    }else
    if(0>(nRand-=10)){
        sNum = "006";
    }else
    if(0>(nRand-=10)){
        sNum = "007";
    }else
    if(0>(nRand-=15)){
        sNum = "008";
    }else
    if(0>(nRand-=70)){
        sNum = "009";
    }else
    if(0>(nRand-=10)){
        sNum = "010";
    }else
    if(0>(nRand-=10)){
        sNum = "011";
    }else
    if(0>(nRand-=45)){
        sNum = "012";
    }else
    if(0>(nRand-=10)){
        sNum = "013";
    }else
    if(0>(nRand-=15)){
        sNum = "015";
    }else
    if(0>(nRand-=15)){
        sNum = "016";
    }else
    if(0>(nRand-=5)){
        sNum = "017";
    }else
    if(0>(nRand-=10)){
        sNum = "018";
    }else
    if(0>(nRand-=20)){
        sNum = "019";
    }

    else sNum = "003";


    //CreateItemOnObject(sItem+sNum,oObj,d4());
    CreateItemOnObject(sItem+sNum,oObj);

    //SendMessageToPC(GetFirstPC(),"Item created");

    return sItem+sNum;
}

string GenerateAlchemyComponent()
{
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return "";
    }

    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    return GenerateAlchemyComponentOnObject(OBJECT_SELF);
}
