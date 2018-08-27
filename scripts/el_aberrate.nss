#include "encounter"
#include "nw_o0_itemmaker"

void main()
{
    int EL = CalcEL(OBJECT_SELF);
    float CR = GetChallengeRating(OBJECT_SELF);
    int nCR = FloatToInt(CR);
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
    int choice;


    CR = IntToFloat(nCR);
    EL = GetLocalInt(GetObjectByTag("EL_VARS"),"nEncLvl");
    num = FloatToInt(CalcNumFromELCR(EL,CR));
    int n = num/2+1;
    if(n > 0) num = n + Random(n) + 1;

    string msg = "nNum="+IntToString(nNum)+" nCR="+IntToString(nCR) + " num=" + IntToString(num);
    SendMessageToPC(GetFirstPC(),msg);

    choice = Random(nNum)+1;
    sTag = GetLocalArrayString(OBJECT_SELF,"BP"
                                            +IntToString(nCR),
                                            choice);

    for(i = 0; i < num; i++)
    {

        CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
    }


    DestroyObject(OBJECT_SELF);

}
