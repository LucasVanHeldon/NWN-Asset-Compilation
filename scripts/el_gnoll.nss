#include "encounter"
#include "nw_o0_itemmaker"

void main()
{

    int EL = CalcEL(OBJECT_SELF);
    float CR = GetChallengeRating(OBJECT_SELF);
    int   num = FloatToInt(CalcNumFromELCR(EL,CR));
    int   nNum = Random(GetLocalInt(OBJECT_SELF,"nNum"));
    string sTag = GetLocalArrayString(OBJECT_SELF,"Tags",nNum);

    sTag = GetLocalArrayString(OBJECT_SELF,"Tags",nNum);
    int i;
    for(i = 0; i < num; i++)
    {
        object o = CreateObject(OBJECT_TYPE_CREATURE,sTag,GetLocation(OBJECT_SELF));
        AssignCommand(o,ActionRandomWalk());
    }
    DestroyObject(OBJECT_SELF);

}
