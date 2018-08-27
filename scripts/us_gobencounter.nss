#include "encounter"
#include "nw_o0_itemmaker"

void main()
{
    int   EL = GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");
    float CR = IntToFloat(EL);


    int nCR = EL;
    int nNum;

    do
    {
        nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)));
        nCR = nCR - 1;
    }
    while(nNum == 0 && nCR > 0);

    int   num = FloatToInt(CalcNumFromELCR(EL,CR));
    string sTag = GetLocalArrayString(OBJECT_SELF,"Tags",nNum);
    int i;


    CR = IntToFloat(nCR);
    EL = GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");
    num = FloatToInt(CalcNumFromELCR(EL,CR));
    int n = num/2+1;
    if(n > 0) num = n + Random(n) + 1;

    string msg = "nNum="+IntToString(nNum)+" nCR="+IntToString(nCR) + " num=" + IntToString(num);
    //SendMessageToPC(GetFirstPC(),msg);
    int choice = Random(nNum)+1;
    for(i = 0; i < num; i++)
    {
        sTag = GetLocalArrayString(OBJECT_SELF,"BP"
                                            +IntToString(nCR)+"_",
                                            choice);

        CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
    }

    CR = CR /2.0;

    if(CR >= 1.0 && d6() < 4)
    {
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        nCR = FloatToInt(CR);

        do
        {
            nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)));
            nCR = nCR - 1;
        }
        while(nNum == 0 && nCR > 0);


        choice = Random(nNum)+1;

        for(i = 0; i < num; i++)
        {
            sTag = GetLocalArrayString(OBJECT_SELF,"BP"
                                                +IntToString(nCR)+"_",
                                                choice);

            CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
        }

    }

    /*
    switch(d2())
    {
    case 1:
        CR = 0.333;
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        for(i = 0; i < num; i++) {
            CreateObject(OBJECT_TYPE_CREATURE, d4() < 3? "nw_goblina":"nw_goblinb",GetLocation(OBJECT_SELF));
        }
        break;
    case 2:
        CR = 0.5;
        num = FloatToInt(CalcNumFromELCR(EL,CR));
        for(i = 0; i < num; i++)
        {
            CreateObject(OBJECT_TYPE_CREATURE, d4() < 3? "hobgoblin015":"nw_hobgoblin001",GetLocation(OBJECT_SELF));
        }
        break;
    }

    msg = "nNum="+IntToString(nNum)+" CR="+FloatToString(CR) + " num=" + IntToString(num);
    SendMessageToPC(GetFirstPC(),msg);
    */

    DestroyObject(OBJECT_SELF);

}
