#include "encounter"
#include "nw_o0_itemmaker"

void ENCSpawn(int choice, int num, int nCR)
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
    int nNum;

    do
    {
        nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"+IntToString(nCR)));
        nCR = nCR - 1;
    }
    while(nNum == 0 && nCR > 0);

    string sTag = GetLocalArrayString(OBJECT_SELF,"Tags",nNum);
    int i,num;


    CR = IntToFloat(nCR);
    EL = GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");
    num = FloatToInt(CalcNumFromELCR(EL,CR));

    string msg = "nNum="+IntToString(nNum)+" nCR="+IntToString(nCR) + " num=" + IntToString(num);

    int choice = Random(nNum)+1;
    ENCSpawn(choice,num,nCR);

    CR = CR /2.0;
    nCR = FloatToInt(CR);
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
        ENCSpawn(choice,num,nCR);

    }

    DestroyObject(OBJECT_SELF);

}
