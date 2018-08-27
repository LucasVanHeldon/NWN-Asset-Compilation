#include "encounter"
#include "nw_o0_itemmaker"

void GntSpawn(int choice, int num, int nCR)
{
    string sTag;
    int i;

    for(i = 0; i < num; i++)
    {
        sTag = GetLocalArrayString(OBJECT_SELF,"BP"
                                            +IntToString(nCR)+"_",
                                            choice);

        CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
    }
}


void main()
{
    int   EL = GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");

    float CR = IntToFloat(EL);
    int nCR = EL;
    int nNum,choice;
    int i,num,n;
    string sTag;

    if(EL < 2) EL = 2;
    do
    {
        nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)));
        nCR = nCR - 1;
    }
    while(nNum == 0 && nCR > 0);

    CR = IntToFloat(nCR);
    num = FloatToInt(CalcNumFromELCR(EL,CR));
    sTag = GetLocalArrayString(OBJECT_SELF,"Tags",nNum);


    num = FloatToInt(CalcNumFromELCR(EL,CR));

    n = num/2+1;
    if(n > 0) num = n + Random(n) + 1;

    //string msg = "nNum="+IntToString(nNum)+" nCR="+IntToString(nCR) + " num=" + IntToString(num);

    choice = Random(nNum)+1;
    GntSpawn(choice,num,nCR);


    CR = CR /2.0;
    nCR = FloatToInt(CR);
    if(CR >= 1.0 && d6() < 4)
    {

        nCR = FloatToInt(CR);

        do
        {
            nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)));
            nCR = nCR - 1;
        }
        while(nNum == 0 && nCR > 0);


        CR = IntToFloat(nCR);
        num = FloatToInt(CalcNumFromELCR(EL,CR));

        choice = Random(nNum)+1;
        GntSpawn(choice,num,nCR);

    }

    switch(d3())
    {
    case 1:
        CR = 0.333;
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        for(i = 0; i < num; i++) CreateObject(OBJECT_TYPE_CREATURE, d4() < 3? "nw_goblina":"nw_goblinb",GetLocation(OBJECT_SELF));
        break;
    case 2:
        CR = 0.25;
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        for(i = 0; i < num; i++) CreateObject(OBJECT_TYPE_CREATURE, d4() < 3? "nw_orca":"nw_orcb",GetLocation(OBJECT_SELF));
        break;
    case 3:
        CR = 0.5;
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        for(i = 0; i < num; i++) CreateObject(OBJECT_TYPE_CREATURE, d4() < 3? "hobgoblin015":"nw_hobgoblin001",GetLocation(OBJECT_SELF));
        break;
    }
    DestroyObject(OBJECT_SELF);

}
